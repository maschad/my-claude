---
name: benchmark-driven-development
description: Drive performance optimizations through a disciplined measure-optimize-measure cycle. Write benchmarks first, optimize with data, and validate improvements empirically. Use when building performance-critical code paths, lock-free structures, or when performance requirements are quantified.
---

# Benchmark-Driven Development

Drive performance optimizations through a disciplined measure-optimize-measure cycle. Write benchmarks first, optimize with data, and validate improvements empirically.

## When to use

- Performance-critical code paths (hot loops, lock-free structures)
- When performance requirements are quantified (e.g., "must handle 100k txn/sec")
- Before refactoring for performance (prove current is too slow)
- When multiple optimization strategies exist (data chooses best)
- Systems where premature optimization wastes time
- Code that will be maintained long-term (prevent regressions)

## When NOT to use

- Throwaway prototypes where performance doesn't matter
- I/O-bound code (optimization won't help)
- When correctness is still being established
- Simple CRUD apps with millisecond-scale requirements
- Code that runs once (startup, migrations)

## Instructions

### Step 1: Define Performance Requirements

Before writing any code, establish quantitative targets:

```markdown
## Performance Requirements

**Target**: 100,000 transactions/second sustained
**Latency**: P99 < 10μs end-to-end
**Memory**: Zero heap allocations in hot path
**Throughput**: Single core should saturate 10Gbps link
**Drop rate**: 0% under normal load
```

**Why this matters**: Without targets, you don't know when to stop optimizing or if you've succeeded.

### Step 2: Write Baseline Benchmark

Implement simplest correct version, then benchmark it:

```rust
// src/lib.rs (naive implementation)
pub struct Buffer {
    data: Vec<u8>,
}

impl Buffer {
    pub fn push(&mut self, value: u8) {
        self.data.push(value); // Allocates!
    }

    pub fn pop(&mut self) -> Option<u8> {
        if self.data.is_empty() {
            None
        } else {
            Some(self.data.remove(0)) // O(n)!
        }
    }
}

// benches/buffer_bench.rs
use criterion::{black_box, criterion_group, criterion_main, Criterion};

fn bench_baseline(c: &mut Criterion) {
    c.bench_function("buffer_push_pop", |b| {
        b.iter(|| {
            let mut buffer = Buffer { data: Vec::new() };
            for i in 0..1000 {
                buffer.push(black_box(i));
            }
            for _ in 0..1000 {
                black_box(buffer.pop());
            }
        });
    });
}

criterion_group!(benches, bench_baseline);
criterion_main!(benches);
```

**Run baseline**:
```bash
cargo bench -- --save-baseline naive
```

**Example output**:
```
buffer_push_pop    time:   [45.2 μs 45.8 μs 46.5 μs]
```

### Step 3: Profile to Find Bottlenecks

Use flamegraphs or profiling tools to identify hot spots:

```bash
# Generate flamegraph
cargo flamegraph --bench buffer_bench

# Look for:
# - Unexpected allocations (malloc/free in flamegraph)
# - Expensive syscalls (futex, mmap)
# - Cache misses (perf stat -d)
# - Lock contention (std::sync::Mutex)
```

**What to look for**:
- Functions consuming >10% CPU time are candidates
- Memory allocation shows up as `__rust_alloc` / `malloc`
- Lock contention shows up as `pthread_mutex_lock` with high time

### Step 4: Implement Optimization

Based on profiling data, optimize the hot path:

```rust
// Optimization 1: Pre-allocate + ring buffer
pub struct Buffer<const N: usize> {
    data: [u8; N],  // Stack-allocated, no heap
    head: usize,
    tail: usize,
}

impl<const N: usize> Buffer<N> {
    pub fn new() -> Self {
        assert!(N > 0 && (N & (N - 1)) == 0, "N must be power of 2");
        Self {
            data: [0; N],
            head: 0,
            tail: 0,
        }
    }

    pub fn push(&mut self, value: u8) -> Result<(), u8> {
        let next_head = (self.head + 1) & (N - 1); // Fast modulo
        if next_head == self.tail {
            return Err(value); // Full
        }
        self.data[self.head] = value;
        self.head = next_head;
        Ok(())
    }

    pub fn pop(&mut self) -> Option<u8> {
        if self.head == self.tail {
            return None; // Empty
        }
        let value = self.data[self.tail];
        self.tail = (self.tail + 1) & (N - 1);
        Some(value)
    }
}
```

**Key optimizations**:
- Replaced `Vec` with fixed-size array (zero allocations)
- Replaced `remove(0)` with ring buffer (O(1) instead of O(n))
- Used bitwise AND for modulo (assumes power-of-2 size)

### Step 5: Benchmark Optimization

Compare against baseline:

```rust
fn bench_optimized(c: &mut Criterion) {
    c.bench_function("buffer_push_pop_optimized", |b| {
        b.iter(|| {
            let mut buffer = Buffer::<1024>::new();
            for i in 0..1000 {
                let _ = buffer.push(black_box(i as u8));
            }
            for _ in 0..1000 {
                black_box(buffer.pop());
            }
        });
    });
}
```

**Run comparison**:
```bash
cargo bench -- --baseline naive

# Expected output:
# buffer_push_pop_optimized    time:   [1.2 μs 1.3 μs 1.4 μs]
#                              change: [-96.8% -96.5% -96.2%] (p = 0.00 < 0.05)
```

**Interpretation**: 38x faster (45.8μs → 1.3μs)

### Step 6: Validate Against Requirements

Check if optimization meets targets:

```rust
// Throughput test
fn bench_throughput(c: &mut Criterion) {
    c.bench_function("buffer_throughput", |b| {
        let mut buffer = Buffer::<4096>::new();
        let mut counter = 0u8;

        b.iter(|| {
            // Fill buffer
            for _ in 0..4000 {
                let _ = buffer.push(counter);
                counter = counter.wrapping_add(1);
            }

            // Drain buffer
            for _ in 0..4000 {
                black_box(buffer.pop());
            }
        });
    });
}
```

**Calculate throughput**:
```
Measured: 1.3μs per 1000 operations = 1.3ns per operation
Throughput: 1 / 1.3ns ≈ 769 million ops/sec
```

**Check against requirements**:
- ✅ Target 100k txn/sec → achieved 769M ops/sec (7690x over)
- ✅ Zero allocations → verified (no `__rust_alloc` in flamegraph)
- ✅ P99 latency → measure with histogram

### Step 7: Iterate or Stop

If requirements not met, profile again and repeat cycle:

```
Requirements NOT met?
  ↓
Profile to find new bottleneck
  ↓
Implement targeted optimization
  ↓
Benchmark vs previous best
  ↓
Improvement? → Save new baseline → Repeat
No improvement? → Revert changes
```

If requirements met, **stop optimizing** (avoid premature optimization).

## Best practices

✅ **DO**:
- Write benchmark BEFORE optimizing
- Save baseline with `--save-baseline` before each iteration
- Profile to find actual bottleneck (don't guess)
- Optimize one thing at a time (isolate impact)
- Validate improvements are statistically significant
- Stop optimizing when requirements are met
- Document trade-offs (e.g., "5% overhead for observability")
- Commit benchmarks to version control
- Run benchmarks in CI to catch regressions

❌ **DON'T**:
- Don't optimize without measuring first
- Don't skip profiling step (you'll optimize wrong thing)
- Don't optimize multiple things at once (can't isolate impact)
- Don't trust intuition over data
- Don't keep optimizing after meeting requirements
- Don't benchmark on laptop with power saving enabled
- Don't forget to use `--release` mode

## Common pitfalls

1. **Pitfall**: Optimizing the wrong thing
   - **Symptom**: Code is faster but benchmark shows no improvement
   - **Fix**: Profile first, optimize hot path only

2. **Pitfall**: Making code worse
   - **Symptom**: "Optimization" makes benchmark slower
   - **Fix**: Always compare against baseline, revert if slower

3. **Pitfall**: Micro-optimizing cold paths
   - **Symptom**: Spending hours on code that runs once at startup
   - **Fix**: Profile to confirm hot path, ignore cold paths

4. **Pitfall**: Over-optimizing
   - **Symptom**: Code meets requirements but you keep "improving" it
   - **Fix**: Define "done" criteria upfront, stop when met

5. **Pitfall**: Ignoring statistical significance
   - **Symptom**: Celebrating 1% improvement that's within noise
   - **Fix**: Check Criterion's confidence intervals (p < 0.05)

6. **Pitfall**: Premature abstraction
   - **Symptom**: Creating "reusable" performance framework before needed
   - **Fix**: Solve specific problem first, abstract later if needed

## Related skills

- performance-profiling-rust - Set up profiling tools
- cache-line-optimization - Specific optimization technique
- latency-measurement - Measure sub-microsecond latencies
- incremental-validation - Test after each optimization

---

**Skill Version:** 1.0
**Last Updated:** 2025-01-06
