---
name: cache-line-optimization
description: Prevent false sharing in concurrent Rust code by aligning data structures to cache-line boundaries. Critical for lock-free data structures and multi-threaded hot paths. Use when building multi-threaded code with shared atomics or lock-free structures.
---

# Cache-Line Optimization

Prevent false sharing in concurrent Rust code by aligning data structures to cache-line boundaries. Critical for lock-free data structures and multi-threaded hot paths.

## When to use

- Multi-threaded code with shared atomics
- Lock-free data structures (queues, stacks, counters)
- Per-thread performance counters
- Producer-consumer patterns (SPSC, MPSC, MPMC)
- Any atomic written by one thread and read by another
- Histogram buckets accessed concurrently
- When profiling shows unexpected cache misses

## When NOT to use

- Single-threaded code (no false sharing possible)
- Data structures that are never shared between threads
- Cold paths that don't impact performance
- Read-only shared data (no writes means no invalidation)
- When memory footprint is more critical than performance

## Instructions

### Step 1: Understand False Sharing

**False sharing** occurs when two threads access different variables that reside on the same cache line. When one thread writes, it invalidates the cache line for all other threads, forcing them to reload it.

```
Cache line (64 bytes):
┌────────────────────────────────────────────────────────┐
│ [Thread 1's counter] [Thread 2's counter] [padding...] │
└────────────────────────────────────────────────────────┘
         ↑                      ↑
    Thread 1 writes        Thread 2 reads
    → Invalidates ENTIRE cache line for Thread 2!
```

**Performance impact**: Can slow down code by 10-100x compared to properly padded version.

### Step 2: Detect False Sharing

**Symptoms**:
- Multi-threaded code is slower than expected
- Adding more threads doesn't improve performance
- Profiling shows high cache miss rate
- `perf stat -d` shows elevated L1/L2 cache misses

**Detection**:
```bash
# Linux: Use perf to detect cache misses
perf stat -d ./your_program

# Look for:
# - High LLC-load-misses (Last Level Cache misses)
# - cache-misses/cache-references ratio > 10%

# MacOS: Use Instruments (Time Profiler → CPU Counters)
```

### Step 3: Create Cache-Line Padded Wrapper

Standard cache line size is 64 bytes on x86_64 and ARM64:

```rust
/// Cache-line padded wrapper to prevent false sharing.
/// Aligns wrapped value to 64-byte boundary (cache line size).
#[repr(C, align(64))]
struct CachePadded<T> {
    value: T,
}

impl<T> CachePadded<T> {
    fn new(value: T) -> Self {
        Self { value }
    }
}

// Compile-time verification
use static_assertions::const_assert_eq;
const_assert_eq!(std::mem::align_of::<CachePadded<AtomicU64>>(), 64);
const_assert_eq!(std::mem::size_of::<CachePadded<AtomicU64>>(), 64);
```

**Key points**:
- `#[repr(C)]` ensures predictable memory layout
- `align(64)` forces 64-byte alignment
- Wrapper adds padding to reach 64 bytes total

### Step 4: Apply to Producer-Consumer Pattern

Classic example: SPSC ring buffer with separate head (producer) and tail (consumer) pointers:

**WRONG (false sharing)**:
```rust
pub struct RingBuffer<T, const N: usize> {
    head: AtomicU64,  // Written by producer
    tail: AtomicU64,  // Written by consumer (on same cache line!)
    slots: [UnsafeCell<MaybeUninit<T>>; N],
}

// Memory layout:
// [head: 8 bytes][tail: 8 bytes][slots...]
//  ↑              ↑
//  Same cache line → false sharing!
```

**RIGHT (cache-line padded)**:
```rust
pub struct RingBuffer<T, const N: usize> {
    head: CachePadded<AtomicU64>,  // Isolated on its own cache line
    tail: CachePadded<AtomicU64>,  // Isolated on its own cache line
    slots: [UnsafeCell<MaybeUninit<T>>; N],
}

// Memory layout:
// [head: 64 bytes][tail: 64 bytes][slots...]
//  ↑               ↑
//  Separate cache lines → no false sharing
```

**Usage**:
```rust
impl<T, const N: usize> RingBuffer<T, N> {
    pub fn push(&self, value: T) -> Result<(), T> {
        let head = self.head.value.load(Ordering::Acquire);
        let tail = self.tail.value.load(Ordering::Acquire);

        let next_head = (head + 1) & (N - 1);
        if next_head == tail {
            return Err(value); // Full
        }

        // Write to slot...
        self.head.value.store(next_head, Ordering::Release);
        Ok(())
    }

    pub fn pop(&self) -> Option<T> {
        let head = self.head.value.load(Ordering::Acquire);
        let tail = self.tail.value.load(Ordering::Acquire);

        if head == tail {
            return None; // Empty
        }

        // Read from slot...
        self.tail.value.store((tail + 1) & (N - 1), Ordering::Release);
        Some(value)
    }
}
```

### Step 5: Apply to Histogram Buckets

When multiple threads record to the same histogram:

**WRONG (false sharing)**:
```rust
pub struct Histogram {
    buckets: [AtomicU64; 13],  // Tightly packed, false sharing!
}

// Memory layout:
// [b0:8][b1:8][b2:8][b3:8][b4:8][b5:8][b6:8][b7:8]...
//  ↑    ↑    ↑    ↑    ↑    ↑    ↑    ↑
//  All on same cache line → severe false sharing!
```

**RIGHT (cache-line padded)**:
```rust
pub struct Histogram {
    buckets: [CachePadded<AtomicU64>; 13],  // Each bucket on separate cache line
}

// Memory layout:
// [b0:64][b1:64][b2:64][b3:64]...
//  ↑     ↑     ↑     ↑
//  Separate cache lines → no false sharing
```

### Step 6: Benchmark Before/After

Always measure impact of padding:

```rust
use criterion::{black_box, criterion_group, criterion_main, Criterion};

// Before: No padding
struct UnpaddedCounters {
    thread1: AtomicU64,
    thread2: AtomicU64,
}

// After: With padding
struct PaddedCounters {
    thread1: CachePadded<AtomicU64>,
    thread2: CachePadded<AtomicU64>,
}

fn bench_false_sharing(c: &mut Criterion) {
    c.bench_function("unpadded_counters", |b| {
        let counters = Arc::new(UnpaddedCounters {
            thread1: AtomicU64::new(0),
            thread2: AtomicU64::new(0),
        });

        b.iter(|| {
            let c1 = Arc::clone(&counters);
            let c2 = Arc::clone(&counters);

            let t1 = std::thread::spawn(move || {
                for _ in 0..10000 {
                    c1.thread1.fetch_add(1, Ordering::Relaxed);
                }
            });

            let t2 = std::thread::spawn(move || {
                for _ in 0..10000 {
                    c2.thread2.fetch_add(1, Ordering::Relaxed);
                }
            });

            t1.join().unwrap();
            t2.join().unwrap();
        });
    });

    c.bench_function("padded_counters", |b| {
        let counters = Arc::new(PaddedCounters {
            thread1: CachePadded::new(AtomicU64::new(0)),
            thread2: CachePadded::new(AtomicU64::new(0)),
        });

        b.iter(|| {
            let c1 = Arc::clone(&counters);
            let c2 = Arc::clone(&counters);

            let t1 = std::thread::spawn(move || {
                for _ in 0..10000 {
                    c1.thread1.value.fetch_add(1, Ordering::Relaxed);
                }
            });

            let t2 = std::thread::spawn(move || {
                for _ in 0..10000 {
                    c2.thread2.value.fetch_add(1, Ordering::Relaxed);
                }
            });

            t1.join().unwrap();
            t2.join().unwrap();
        });
    });
}

criterion_group!(benches, bench_false_sharing);
criterion_main!(benches);
```

**Expected results**:
- Unpadded: ~500μs (false sharing causes cache thrashing)
- Padded: ~50μs (10x faster with proper alignment)

## Best practices

✅ **DO**:
- Pad atomics written by one thread, read by another
- Use `#[repr(C, align(64))]` for cache-line alignment
- Measure before/after with benchmarks
- Use `const_assert_eq!` to verify alignment at compile time
- Consider struct-level alignment for hot structs
- Document trade-offs (memory vs performance)
- Profile to confirm false sharing before optimizing

❌ **DON'T**:
- Don't pad single-threaded code (wastes memory for no gain)
- Don't pad read-only shared data (no writes = no invalidation)
- Don't guess at cache line size (use 64 bytes on modern CPUs)
- Don't pad cold paths that aren't performance-critical
- Don't skip benchmarking (verify padding actually helps)
- Don't use padding when memory is more critical than performance

## Common pitfalls

1. **Pitfall**: Padding doesn't help performance
   - **Symptom**: Benchmarks show no improvement after padding
   - **Cause**: Data wasn't being written concurrently (no false sharing existed)
   - **Fix**: Profile first, only pad if false sharing detected

2. **Pitfall**: Memory usage explodes
   - **Symptom**: Application uses 10x more RAM after padding
   - **Cause**: Padded too many things that didn't need it
   - **Fix**: Only pad hot atomics accessed by multiple threads

3. **Pitfall**: Alignment not working
   - **Symptom**: `const_assert_eq!` fails or performance still slow
   - **Cause**: Forgot `#[repr(C)]` or used wrong alignment value
   - **Fix**: Use `#[repr(C, align(64))]` and verify with `mem::align_of`

4. **Pitfall**: Padding within array
   - **Symptom**: Array elements still share cache lines
   - **Cause**: Padding the array, not the elements
   - **Fix**: Pad element type, not array: `[CachePadded<T>; N]` not `CachePadded<[T; N]>`

5. **Pitfall**: Over-engineering with generic padding
   - **Symptom**: Complex trait bounds and generic padding logic
   - **Cause**: Trying to make padding "reusable" before needed
   - **Fix**: Use simple wrapper struct, abstract later if needed

## Related skills

- performance-profiling-rust - Detect false sharing with profiling
- benchmark-driven-development - Measure impact of padding
- latency-measurement - Track latency improvements

---

**Skill Version:** 1.0
**Last Updated:** 2025-01-06
