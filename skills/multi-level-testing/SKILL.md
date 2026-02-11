---
name: multi-level-testing
description: Layer different test types (unit, property, concurrency, stress, benchmark) to catch different bug classes. Each level catches what others miss. Use for complex systems, concurrent/parallel code, or performance-critical applications.
---

# Multi-Level Testing

Layer different test types (unit, property, concurrency, stress, benchmark) to catch different bug classes. Each level catches what others miss.

## When to use

- Complex systems with multiple failure modes
- Concurrent/parallel code (race conditions, deadlocks)
- Performance-critical applications
- Safety-critical systems
- Long-lived projects (>1 year maintenance)
- Open source libraries

## When NOT to use

- Simple scripts (<500 lines)
- Throwaway prototypes
- When correctness is obvious (hello world)
- Pure I/O bound code with no logic

## Instructions

### Step 1: Understand the Testing Pyramid

```
           ┌─────────────┐
           │   Stress    │  Hours, rare bugs, CI overnight
           │   Tests     │
           ├─────────────┤
           │   Property  │  Minutes, invariants, CI
           │   Tests     │
           ├─────────────┤
           │ Concurrency │  Seconds, model checking, CI
           │  (Loom)     │
           ├─────────────┤
           │    Unit     │  Milliseconds, basic correctness
           │   Tests     │  Run constantly during development
           └─────────────┘
         ┌─────────────────┐
         │   Benchmarks    │  Separate: measure performance
         └─────────────────┘
```

**Key insight**: Each level catches different bug classes

### Step 2: Define Test Strategy Per Component

For each component, determine which test levels apply:

| Component Type | Unit | Property | Loom | Stress | Bench |
|----------------|------|----------|------|--------|-------|
| Core types | ✅ | ✅ | - | - | - |
| Lock-free structures | ✅ | ✅ | ✅ | ✅ | ✅ |
| Business logic | ✅ | ✅ | - | - | - |
| Hot path code | ✅ | - | - | - | ✅ |
| I/O operations | ✅ | - | - | ✅ | - |

### Step 3: Implement Each Test Level

#### Level 1: Unit Tests (Foundation)

**Purpose**: Verify basic correctness of individual functions

**Location**: `src/module.rs` (inline with code)

**Example**:
```rust
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_basic_operation() {
        let x = create();
        assert!(x.operation());
    }

    #[test]
    fn test_edge_cases() {
        // Empty input
        assert_eq!(process(&[]), vec![]);

        // Max size
        let large = vec![0u8; 1000000];
        assert!(process(&large).len() <= 1000000);

        // Invalid input
        assert!(process_validated(&[]).is_err());
    }

    #[test]
    fn test_error_handling() {
        let result = fallible_operation();
        match result {
            Ok(_) => { /* verify success case */ },
            Err(e) => { /* verify error is correct type */ }
        }
    }
}
```

**Run**: `cargo test --lib module::tests`

**When**: After every code change (seconds)

#### Level 2: Property Tests (Invariants)

**Purpose**: Verify properties hold for all inputs

**Location**: `tests/property_tests.rs`

**Dependencies**: `proptest = "1.0"`

**Example**:
```rust
use proptest::prelude::*;

proptest! {
    /// Property: No data loss (input count = output count)
    #[test]
    fn prop_no_loss(items in prop::collection::vec(0u64..1000, 1..100)) {
        let ring = RingBuffer::new();

        let mut pushed = 0;
        for item in &items {
            if ring.push(*item).is_ok() {
                pushed += 1;
            }
        }

        let mut popped = 0;
        while ring.pop().is_some() {
            popped += 1;
        }

        prop_assert_eq!(pushed, popped);
    }

    /// Property: FIFO order preserved
    #[test]
    fn prop_fifo_order(items in prop::collection::vec(0u64..1000, 1..100)) {
        let ring = RingBuffer::new();

        let mut expected = Vec::new();
        for item in &items {
            if ring.push(*item).is_ok() {
                expected.push(*item);
            }
        }

        let mut actual = Vec::new();
        while let Some(item) = ring.pop() {
            actual.push(item);
        }

        prop_assert_eq!(expected, actual);
    }
}
```

**Run**: `cargo test --test property_tests`

**When**: Before commit (minutes)

**What it catches**: Invariant violations across input space

#### Level 3: Concurrency Tests (Loom)

**Purpose**: Model check all thread interleavings

**Location**: `tests/loom_tests.rs`

**Dependencies**: `loom = "0.7"`

**Example**:
```rust
#[cfg(loom)]
mod loom_tests {
    use loom::sync::atomic::{AtomicU64, Ordering};
    use loom::sync::Arc;
    use loom::thread;

    #[test]
    fn test_spsc_ring() {
        loom::model(|| {
            let head = Arc::new(AtomicU64::new(0));
            let tail = Arc::new(AtomicU64::new(0));

            let h1 = Arc::clone(&head);
            let t1 = Arc::clone(&tail);

            // Producer
            let producer = thread::spawn(move || {
                let current_head = h1.load(Ordering::Relaxed);
                let current_tail = t1.load(Ordering::Acquire);

                if current_head.wrapping_sub(current_tail) < 4 {
                    h1.store(current_head + 1, Ordering::Release);
                }
            });

            let h2 = Arc::clone(&head);
            let t2 = Arc::clone(&tail);

            // Consumer
            let consumer = thread::spawn(move || {
                let current_tail = t2.load(Ordering::Relaxed);
                let current_head = h2.load(Ordering::Acquire);

                if current_tail != current_head {
                    t2.store(current_tail + 1, Ordering::Release);
                }
            });

            producer.join().unwrap();
            consumer.join().unwrap();

            // Verify invariants
            let final_head = head.load(Ordering::Relaxed);
            let final_tail = tail.load(Ordering::Relaxed);
            assert!(final_head >= final_tail);
        });
    }
}
```

**Run**: `cargo test --test loom_tests`

**When**: Before commit (seconds to minutes)

**What it catches**: Race conditions, memory ordering bugs, deadlocks

#### Level 4: Stress Tests (Long-Running)

**Purpose**: Find rare bugs that only appear under sustained load

**Location**: `tests/stress_tests.rs`

**Example**:
```rust
#[test]
#[ignore]  // Run explicitly with --ignored
fn stress_test_long_run() {
    let ring = Arc::new(RingBuffer::<u64, 4096>::new());
    let stop = Arc::new(AtomicBool::new(false));

    let s1 = Arc::clone(&stop);
    let r1 = Arc::clone(&ring);
    let producer = thread::spawn(move || {
        let mut id = 0;
        while !s1.load(Ordering::Relaxed) {
            if r1.push(id).is_ok() {
                id += 1;
            }
        }
        id  // Return count
    });

    let s2 = Arc::clone(&stop);
    let r2 = Arc::clone(&ring);
    let consumer = thread::spawn(move || {
        let mut count = 0;
        while !s2.load(Ordering::Relaxed) {
            if r2.pop().is_some() {
                count += 1;
            }
        }
        // Drain remaining
        while r2.pop().is_some() {
            count += 1;
        }
        count  // Return count
    });

    // Run for 1 hour
    thread::sleep(Duration::from_secs(3600));
    stop.store(true, Ordering::Relaxed);

    let produced = producer.join().unwrap();
    let consumed = consumer.join().unwrap();

    assert_eq!(produced, consumed, "Data loss detected!");
}
```

**Run**: `cargo test --release -- --ignored --nocapture`

**When**: CI overnight, before release

**What it catches**: Memory leaks, rare race conditions, resource exhaustion

#### Level 5: Benchmarks (Performance)

**Purpose**: Measure performance, detect regressions

**Location**: `benches/module_bench.rs`

**Dependencies**: `criterion = "0.5"`

**Example**:
```rust
use criterion::{black_box, criterion_group, criterion_main, Criterion};

fn bench_ring_buffer(c: &mut Criterion) {
    c.bench_function("ring_push_pop", |b| {
        let ring = RingBuffer::<u64, 4096>::new();

        b.iter(|| {
            ring.push(black_box(12345)).unwrap();
            black_box(ring.pop().unwrap());
        });
    });
}

fn bench_orderbook_update(c: &mut Criterion) {
    c.bench_function("orderbook_update", |b| {
        let book = OrderBook::new();
        let mut price = 1000000;

        b.iter(|| {
            price += 1;
            book.update_bid(black_box(price), black_box(100), 0).unwrap();
        });
    });
}

criterion_group!(benches, bench_ring_buffer, bench_orderbook_update);
criterion_main!(benches);
```

**Run**: `cargo bench`

**When**: Before commit (for hot path changes), weekly baseline

**What it measures**: P50/P99 latency, throughput, regressions

### Step 4: Create Test Execution Strategy

**During development (every save):**
```bash
cargo test --lib module::tests  # <1 second
```

**Before commit (every commit):**
```bash
cargo test                       # All unit + property tests
cargo test --test loom_tests    # Concurrency model checking
cargo clippy                     # Linting
cargo fmt --check                # Formatting
```

**Before PR (every PR):**
```bash
cargo test --release            # Optimized builds
cargo bench -- --quick          # Quick benchmark check
```

**CI pipeline (every push):**
```bash
cargo test --all-targets        # All tests
cargo bench                     # Full benchmarks
cargo test -- --ignored         # Stress tests (shorter version)
```

**Nightly/weekly:**
```bash
cargo test --release -- --ignored --nocapture  # Long stress tests
```

## Best Practices

### ✅ Do

- **Start with unit tests** - Foundation for all others
- **Add property tests for complex logic** - Verify invariants
- **Use Loom for lock-free code** - Catch subtle races
- **Run stress tests before release** - Find rare bugs
- **Benchmark on every change** - Detect regressions early
- **Automate everything** - CI runs all tests
- **Document what each test verifies** - Clear purpose

### ❌ Don't

- **Don't only unit test** - Misses higher-level bugs
- **Don't skip concurrency testing** - Race conditions are subtle
- **Don't ignore slow tests** - Run them somewhere (CI)
- **Don't test implementation details** - Test behavior
- **Don't forget negative tests** - Test error cases
- **Don't make tests flaky** - Fix or remove

## Measuring Success

### Test Coverage Matrix

| Component | Unit | Property | Loom | Stress | Bench | Status |
|-----------|------|----------|------|--------|-------|--------|
| Ring Buffer | 6/6 | 2/2 | 1/1 | 1/1 | 1/1 | ✅ |
| Order Book | 5/5 | 1/1 | 1/1 | 1/1 | 2/2 | ✅ |
| Bundle | 4/4 | 1/1 | - | - | 1/1 | ✅ |

### Success Indicators:
- ✅ All test levels passing
- ✅ Fast feedback loop (<1s for unit tests)
- ✅ CI catches bugs before merge
- ✅ No production bugs in tested code paths
- ✅ Performance targets consistently met

## Related skills

- incremental-validation - Run tests after each phase
- plan-first-development - Plan test strategy per phase
- parallel-subagent-orchestration - Sub-agents run tests in parallel

---

**Skill Version:** 1.0
**Last Updated:** 2025-01-06
