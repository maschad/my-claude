---
name: documentation-while-fresh
description: Document decisions, challenges, and solutions immediately after completing each phase. Captures context that would be lost later, creates invaluable reference for future work. Use for complex projects with non-obvious design decisions or any project taking more than 1 week.
---

# Documentation While Fresh

Document decisions, challenges, and solutions immediately after completing each phase. Captures context that would be lost later, creates invaluable reference for future work.

## When to use

- Complex projects with non-obvious design decisions
- Systems with subtle bugs or tricky solutions
- Projects that will be maintained long-term
- When onboarding others to codebase
- Any project taking >1 week
- Open source projects

## When NOT to use

- Throwaway prototypes
- Well-understood patterns (standard CRUD app)
- Solo projects you'll never revisit
- When requirements are still in flux

## Instructions

### Step 1: Create CLAUDE.md at Project Start

Initialize your development log:

```markdown
# [Project Name] Development Log

## Project Overview
[2-3 sentences: what you're building and why]

## Development Timeline

### Phase 1: [Component Name]
[Will be filled after completing phase]

## Key Patterns Developed
[Will accumulate patterns as discovered]

## Challenges & Solutions
[Will record problems and fixes]

## Performance Results
[Will record measurements]

## Lessons Learned
[Will reflect at end]

## Reusable Components
[Will identify reusable parts]

## Future Improvements
[Will note TODOs and ideas]

## References
[Links to docs, papers, resources used]
```

### Step 2: Document After Each Phase

**CRITICAL TIMING:** Update CLAUDE.md immediately after completing phase, before starting next phase.

**Why:** Context is fresh, details are vivid, emotions are real

**Template for each phase:**

```markdown
### Phase N: [Component Name]

**Objective**: What were we building?

**Approach**: How did we build it?
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Key Decisions**:
- **Decision 1**: [What we chose]
  - Why: [Rationale]
  - Alternative considered: [What we didn't choose]
  - Trade-off: [What we gained vs lost]

**Challenges & Solutions**:
- **Challenge**: [Problem encountered]
  - Symptom: [How it manifested]
  - Root cause: [Why it happened]
  - Solution: [How we fixed it]
  - Time to fix: [X minutes/hours]
  - Lesson: [What we learned]

**Validation Results**:
- Tests: ✅/❌ [X/Y passing]
- Performance: [Measured vs target]
- Issues found: [Count and brief description]
```

### Step 3: Capture "Why" Not Just "What"

**Bad documentation (what):**
```markdown
Used Release/Acquire memory ordering.
```

**Good documentation (why):**
```markdown
**Decision**: Use Release/Acquire memory ordering instead of SeqCst

**Why**: ARM64 has weaker memory model than x86. SeqCst adds unnecessary barriers on ARM, hurting performance. Release/Acquire provides sufficient synchronization for SPSC pattern while being optimally compiled on both architectures.

**Alternative considered**: SeqCst (sequential consistency)
- Pro: Simpler to reason about
- Con: 20-30% slower on ARM64
- Con: Unnecessary barriers

**Trade-off**: Slightly more complex reasoning about memory model, but significantly better performance on target platform (ARM64).
```

### Step 4: Document Challenges in Detail

**Template:**
```markdown
**Challenge**: [Brief 1-sentence description]

**Context**: [What we were trying to do when it happened]

**Symptom**: [How the bug manifested]
```
Compiler error: "attempt to compute 0_usize - 1_usize"
Tests failing with wrong output
Performance 10x slower than expected
```

**Root Cause**: [Why it happened]
```
Rust's default struct layout added unexpected padding
CAS loop had no backoff, causing contention
Array index calculated after increment instead of before
```

**Solution**: [How we fixed it]
```
Reordered struct fields, added explicit padding
Added exponential backoff to CAS loop
Moved bounds check before array access
```

**Time to Fix**: [Actual time spent]

**Lesson Learned**: [Generalized insight]
```
Always use repr(C) for predictable layout
Unbounded CAS loops livelock under contention
Check bounds before access, not after
```

**How to Prevent**: [Future proofing]
```
Add compile-time size assertions
Add MAX_RETRIES to all CAS loops
Add debug assertions for array access
```
```

### Step 5: Extract Patterns as You Go

When you solve a problem well, immediately add to "Key Patterns":

```markdown
## Key Patterns Developed

### Pattern 1: Cache-Line Padded Atomics

**Problem**: False sharing between producer and consumer head/tail

**Solution**:
```rust
#[repr(C, align(64))]
struct CachePadded<T> {
    value: T,
}
```

**When to use**: Any atomic shared between threads

**Performance impact**: 10-100x improvement in contended scenarios

**References**: ring.rs:15-18
```

### Step 6: Record Performance Measurements

Don't just say "it's fast", record numbers:

```markdown
## Performance Results

### Ring Buffer (Phase 2)
- **Target**: <50ns per push/pop
- **Measured**: 4.04ns mean (P50)
- **Result**: ✅ 12.5x better than target
- **Outliers**: 4% mild outliers (cache effects)
- **Methodology**: Criterion benchmarks, 1M samples

### Order Book (Phase 3)
- **Target**: <200ns per update
- **Measured**: 2.89-3.50ns mean
- **Result**: ✅ 57-69x better than target
- **CAS retry rate**: <1% (low contention)
```

## Best Practices

### ✅ Do

- **Document immediately** - Right after completing phase, not later
- **Capture emotions** - "This was frustrating because..."
- **Record time spent** - Helps estimate future work
- **Include code snippets** - Show actual implementation
- **Link to files** - Reference specific line numbers
- **Record dead ends** - What didn't work and why
- **Note resources used** - Papers, docs, blog posts

### ❌ Don't

- **Don't defer** - "I'll document it all at the end" = never happens
- **Don't just copy code** - Explain the "why"
- **Don't sanitize failures** - Record real struggles
- **Don't skip measurements** - "Fast" isn't documentation
- **Don't write for yourself only** - Write for future you + others

## Common Pitfalls

### Pitfall 1: Deferring documentation

**Problem:**
```
Week 1: Build Phase 1-3
Week 2: Build Phase 4-7
Week 3: "Now I'll document everything"
Week 3 reality: Can't remember why chose X over Y
```

**Solution:**
```
After Phase 1: Document (15 minutes)
After Phase 2: Document (15 minutes)
...
Week 3: Documentation already complete!
```

### Pitfall 2: Documentation without context

**Bad:**
```markdown
Fixed bug in bundle.rs
```

**Good:**
```markdown
**Bug**: Array index out of bounds in BundleBuilder::add()

**Symptom**: Panic when adding 16th transaction

**Root cause**: Checked flush condition AFTER incrementing count,
so count reached 16 before checking if >= BUNDLE_MAX (16)

**Solution**: Moved flush check BEFORE array access

**Discovered by**: Benchmark sub-agent during performance testing

**Prevention**: Added debug assertions for index bounds
```

### Pitfall 3: Only documenting successes

**Problem**: Documentation shows clean path, hides all failures

**Solution**: Document failed approaches:
```markdown
**Approaches Tried**:

❌ Attempt 1: SeqCst memory ordering
- Result: 30% slower on ARM64
- Reason failed: Unnecessary memory barriers

❌ Attempt 2: Spinlock for synchronization
- Result: 100x slower, violated lock-free requirement
- Reason failed: Blocking is unacceptable in HFT

✅ Attempt 3: Release/Acquire CAS
- Result: Optimal performance on both ARM and x86
- Why it worked: Minimal synchronization, correct for weak memory model
```

## Integration with Other Skills

### With Plan-First Development
```
Plan defines: WHAT to build
Documentation captures: WHY decisions were made
```

Example:
- Plan says: "Use Release/Acquire ordering"
- Documentation says: "Chose Release/Acquire because ARM64's weak memory model requires explicit barriers, but SeqCst would add unnecessary overhead..."

### With Incremental Validation
```
Validation: Proves it works
Documentation: Explains how it works
```

Example:
- Validation: ✅ Tests pass, P99 < 50ns
- Documentation: "Achieved 4ns by using cache-line padding to prevent false sharing..."

## Measuring Success

### Indicators it's working:
- ✅ Can onboard new developer in 1 hour (read CLAUDE.md)
- ✅ Can revisit project after 6 months and understand decisions
- ✅ Extracted reusable patterns for future projects
- ✅ Documentation took <5% of total project time
- ✅ Others reference your docs as example

### Indicators it's failing:
- ❌ "Why did I do it this way?" after 1 week
- ❌ Can't explain design decisions
- ❌ Repeated mistakes in future projects
- ❌ Documentation became burden (took too long)

## Related skills

- plan-first-development - Plan provides structure for documentation
- incremental-validation - Validation results go into docs
- parallel-subagent-orchestration - Sub-agents generate complementary docs

---

**Skill Version:** 1.0
**Last Updated:** 2025-01-06
