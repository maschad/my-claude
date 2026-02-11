---
name: parallel-subagent-orchestration
description: Launch multiple specialized Claude agents simultaneously to maximize productivity. Achieves 3-5x speedup on independent tasks like benchmarking, documentation, and analysis. Use when you have multiple independent tasks that each take more than 1 minute.
---

# Parallel Sub-Agent Orchestration

Launch multiple specialized Claude agents simultaneously to maximize productivity. Achieves 3-5x speedup on independent tasks like benchmarking, documentation, and analysis.

## When to use

- Multiple independent tasks that can run concurrently
- Each task takes >1 minute to complete (worthwhile parallelism)
- Tasks produce concrete deliverables (files, reports, code)
- You need specialized agents (Explore for codebase analysis, general-purpose for benchmarks)
- Time-sensitive projects where speed matters

## When NOT to use

- Tasks have sequential dependencies (Task B needs Task A's output)
- Quick operations (<30 seconds) - overhead not worth it
- Single task that can't be split
- When you need to iterate based on results (exploratory work)

## Instructions

### Step 1: Identify Parallelizable Tasks

Good candidates:
- ✅ Running benchmarks + writing docs + security audit (all independent)
- ✅ Analyzing 3 different codebases simultaneously
- ✅ Creating examples + running tests + generating reports
- ✅ Exploring multiple architecture options in parallel

Bad candidates:
- ❌ Read file → analyze → write report (sequential dependency)
- ❌ Five trivial operations (<10 seconds each)
- ❌ Interactive tasks needing user input between steps

### Step 2: Choose Agent Types

**Available agents:**

| Agent Type | Best For | Max Concurrent |
|------------|----------|----------------|
| `Explore` | Codebase analysis, file searches | 2-3 |
| `general-purpose` | Benchmarks, examples, audits, docs | 3-4 |
| `Bash` | Git operations, command execution | 1-2 |
| `Plan` | Architecture design, planning | 1 |

**Selection guide:**
- Codebase analysis? → Explore agent
  - "Analyze module dependencies"
  - "Find all unsafe code"
  - "Map data flow through pipeline"

- Running commands? → general-purpose agent
  - "Run benchmarks and create report"
  - "Generate usage examples"
  - "Perform security audit"

### Step 3: Craft Clear, Independent Prompts

Each prompt must:
1. Be **self-contained** (no references to other agents)
2. Specify **concrete deliverable** (file path, format)
3. Include **success criteria** (what done looks like)
4. Provide **context** if agent needs background

### Step 4: Launch Agents in Single Message

**CRITICAL:** Use one message with multiple Task tool calls for true parallelism.

Wait for all agents to complete, then review results.

### Step 5: Synthesize Results

After agents complete:
1. Read all generated files
2. Check for conflicts or contradictions
3. Integrate findings into summary
4. Identify any gaps that need follow-up

## Examples

### Example 1: Validating a Project

**Scenario:** Need to validate codebase architecture, performance, examples, and security

**Agents launched (4 in parallel):**

1. **Explore Agent** - Codebase architecture analysis
   - Analyzed 7 modules, mapped dependencies
   - Identified 9 unsafe blocks
   - Found hot paths (ring buffer, orderbook, TSC)
   - Output: Inline architecture analysis (48KB)

2. **General-Purpose Agent** - Run benchmarks
   - Executed 3 benchmark suites
   - Found bug in bundle.rs (array bounds check)
   - Results: Exceeded all targets by 12-69x
   - Output: BENCHMARKS.md (9.5KB)

3. **General-Purpose Agent** - Generate examples
   - Created 5 production-ready examples
   - Each with runnable code + explanations
   - Output: examples/README.md (20KB)

4. **General-Purpose Agent** - Security audit
   - Validated all 9 unsafe blocks
   - Checked atomic ordering
   - Safety score: 9.5/10
   - Output: SAFETY_AUDIT.md (25KB)

**Results:**
- Total time: ~7 minutes (parallel)
- Sequential would take: ~25+ minutes
- **Speedup: 3.5x**
- Bonus: Benchmark agent found real bug!

### Example 2: Analyzing Multiple Codebases

**Scenario:** Compare 3 different queue implementations

**Agents launched (3 in parallel):**

Agent 1: Analyze crossbeam-queue
Agent 2: Analyze tokio mpsc
Agent 3: Analyze custom lock-free queue

Each agent produces:
- API surface analysis
- Memory ordering used
- Performance characteristics
- Trade-offs

Result: Comparison table in 10 minutes vs 30+ minutes sequential

### Example 3: Documentation Sprint

**Scenario:** Need README, API docs, examples, and architecture docs

**Agents launched (4 in parallel):**

Agent 1: Write README.md (getting started, install, basic usage)
Agent 2: Generate API documentation from code
Agent 3: Create examples/ directory with 5 examples
Agent 4: Write ARCHITECTURE.md (system design, data flow)

Result: Complete documentation suite in 15 minutes

## Best Practices

### ✅ Do

- **Launch 3-5 agents max** - More causes context switching overhead
- **Make prompts independent** - No cross-references between agents
- **Specify file paths** - Clear deliverables
- **Check results immediately** - Agents might misunderstand
- **Use Explore for codebase tasks** - Specialized for code analysis
- **One message, multiple tasks** - True parallelism

### ❌ Don't

- **Don't create dependencies** - Agent A shouldn't need Agent B's output
- **Don't overload** - >5 agents gets chaotic
- **Don't use for trivial tasks** - <30 second operations not worth it
- **Don't forget to synthesize** - Review all outputs together
- **Don't launch sequentially** - Multiple separate messages = no parallelism

## Common Pitfalls

### Pitfall 1: Sequential messages
**Wrong:**
```
Message 1: Task tool call for Agent 1
[wait for result]
Message 2: Task tool call for Agent 2
[wait for result]
```

**Correct:**
```
Message 1: Task tool calls for Agent 1, 2, 3, 4 (all in one message)
[all run in parallel]
```

### Pitfall 2: Creating dependencies
**Wrong:**
```
Agent 1: Analyze codebase and save to /tmp/analysis.txt
Agent 2: Read /tmp/analysis.txt and write report
```
- Agent 2 depends on Agent 1 completing first
- This is sequential, not parallel!

**Correct:**
```
Agent 1: Analyze codebase and write ANALYSIS.md
Agent 2: Run benchmarks and write BENCHMARKS.md
(No dependency between them)
```

### Pitfall 3: Vague prompts
**Wrong:**
```
"Look at the code and tell me about performance"
```
- What code? Where?
- What aspects of performance?
- What deliverable?

**Correct:**
```
"Run all benchmarks in benches/ directory:
1. Execute each with cargo bench
2. Extract P50/P99 latencies
3. Compare against targets in README
4. Create BENCHMARKS.md with results table"
```

## Measuring Success

### Indicators it worked:
- ✅ All agents completed successfully
- ✅ Time saved vs sequential (calculate speedup)
- ✅ Deliverables are high quality
- ✅ No contradictions between agents
- ✅ Found insights you would have missed (bonus!)

### Indicators it failed:
- ❌ Agents blocked waiting for each other
- ❌ Had to redo work due to vague prompts
- ❌ Results conflicted and needed reconciliation
- ❌ Spent more time managing agents than working

## Advanced Patterns

### Pattern 1: Explore + Implement
```
Agent 1 (Explore): Analyze existing authentication system
Agent 2 (Explore): Find all security vulnerabilities
Agent 3 (general-purpose): Draft secure auth implementation plan

Then (after review): Implement based on findings
```

### Pattern 2: Test Coverage Expansion
```
Agent 1: Create unit tests for module A
Agent 2: Create unit tests for module B
Agent 3: Create integration tests
Agent 4: Create property tests

Result: Full test suite in fraction of time
```

### Pattern 3: Multi-Platform Validation
```
Agent 1: Build and test on Linux
Agent 2: Build and test on macOS
Agent 3: Build and test on Windows
Agent 4: Run cross-compilation tests

(Note: Requires appropriate build environments)
```

## Integration with Workflows

### With Code Review
Before submitting PR:
```
Agent 1: Run all tests + generate coverage report
Agent 2: Run linters + format checks
Agent 3: Run benchmarks + compare to main
Agent 4: Generate changelog from commits

Results ready in minutes instead of running sequentially
```

### With CI/CD
Parallel agents can pre-validate before pushing:
```
Agent 1: Security scan
Agent 2: Performance regression check
Agent 3: Documentation check
Agent 4: License compliance

Push only if all pass
```

## Related skills

- plan-first-development - Plan what agents should do
- incremental-validation - Use agents for validation steps
- documentation-while-fresh - Agents generate documentation

---

**Skill Version:** 1.0
**Last Updated:** 2025-01-06
