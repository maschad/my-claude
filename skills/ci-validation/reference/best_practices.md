# CI Validation Best Practices

## Overview

This guide provides best practices for CI validation in the Arda ecosystem, including validation workflows, local testing strategies, and integration patterns.

---

## Validation Workflow

### 1. Validate Before Committing

**Always validate locally:**
- Run CI checks locally
- Verify all checks pass
- Fix issues before committing
- Ensure CI will pass

**Benefits:**
- Faster feedback
- Fewer CI failures
- Better code quality
- Smoother workflow

### 2. Validate Configuration

**Check CI configuration:**
- Validate YAML syntax
- Verify required checks
- Check Arda requirements
- Ensure proper setup

**Tools:**
```bash
# GitHub Actions
yamllint .github/workflows/*.yml

# GitLab CI
gitlab-ci-lint .gitlab-ci.yml

# CircleCI
circleci config validate
```

### 3. Run Local CI

**Execute CI locally:**
- Use CI local execution tools
- Match CI environment
- Run all checks
- Verify results

**Tools:**
- `act` for GitHub Actions
- `gitlab-runner` for GitLab CI
- `circleci-cli` for CircleCI

### 4. Debug Failures

**When CI fails:**
- Reproduce locally
- Identify root cause
- Fix issues
- Verify fixes

---

## Local Testing Strategies

### Use CI Local Execution Tools

**GitHub Actions (act):**
```bash
# Install
brew install act  # macOS
# or download from GitHub

# List workflows
act -l

# Run workflow
act -W .github/workflows/ci.yml

# Run specific job
act -j test

# With secrets
act --secret-file .secrets
```

**GitLab CI (gitlab-runner):**
```bash
# Install
brew install gitlab-runner  # macOS

# Run job
gitlab-runner exec docker <job-name>

# With custom image
gitlab-runner exec docker --docker-image node:18 <job-name>
```

**CircleCI (circleci-cli):**
```bash
# Install
brew install circleci  # macOS

# Validate
circleci config validate

# Run locally
circleci local execute

# Specific job
circleci local execute --job <job-name>
```

### Match CI Environment

**Use Same Versions:**
- Same Node.js/Python/Go versions
- Same dependency versions
- Same tool versions
- Same environment

**Use Docker:**
```bash
# Match CI environment
docker run -it node:18 bash

# Install dependencies
npm ci

# Run checks
npm test
npm run lint
```

### Run Individual Steps

**Test Incrementally:**
- Build step
- Test step
- Lint step
- Format step
- Security step

**Benefits:**
- Faster feedback
- Easier debugging
- Better isolation
- Clearer failures

---

## CI Configuration Best Practices

### 1. Use Caching

**Enable Caching:**
- Dependency caching
- Build artifact caching
- Tool caching
- Custom caching

**Benefits:**
- Faster builds
- Reduced resource usage
- Better performance
- Cost savings

**Examples:**
```yaml
# Node.js
- uses: actions/setup-node@v4
  with:
    cache: 'npm'

# Python
- uses: actions/setup-python@v4
  with:
    cache: 'pip'
```

### 2. Run Jobs in Parallel

**Parallel Execution:**
- Independent jobs
- Faster CI runs
- Better resource utilization
- Clearer job separation

**Example:**
```yaml
jobs:
  test:
    # Test job
  lint:
    # Lint job
  format:
    # Format job
  # All run in parallel
```

### 3. Use Conditional Execution

**Skip Unnecessary Jobs:**
- Skip on certain branches
- Skip if files unchanged
- Skip if conditions not met
- Faster feedback

**Example:**
```yaml
jobs:
  deploy:
    if: github.ref == 'refs/heads/main'
    # Only run on main
```

### 4. Set Appropriate Timeouts

**Configure Timeouts:**
- Job timeouts
- Step timeouts
- Test timeouts
- Prevent hanging jobs

**Example:**
```yaml
jobs:
  test:
    timeout-minutes: 30
    steps:
      - run: npm test
        timeout-minutes: 10
```

### 5. Manage Artifacts

**Artifact Management:**
- Share between jobs
- Preserve build outputs
- Enable debugging
- Store test results

**Example:**
```yaml
- name: Upload artifacts
  uses: actions/upload-artifact@v3
  with:
    name: dist
    path: dist/
```

---

## Arda Ecosystem Requirements

### Required Checks

**Quality Checks:**
- Build must pass
- Tests must pass
- Linters must pass
- Formatters must pass

**Security Checks:**
- Dependency scanning
- Vulnerability scanning
- Secret scanning
- SAST scanning

**Compliance Checks:**
- License compliance
- Documentation checks
- Coverage requirements
- Semantic commit validation

### Required Stages

**Build Stage:**
- Install dependencies
- Build project
- Generate artifacts

**Test Stage:**
- Run unit tests
- Run integration tests
- Generate coverage

**Quality Stage:**
- Run linters
- Check formatting
- Validate quality

**Security Stage:**
- Scan dependencies
- Check vulnerabilities
- Scan for secrets

**Deploy Stage (if applicable):**
- Build artifacts
- Deploy to staging
- Run smoke tests

---

## Debugging Best Practices

### 1. Reproduce Locally

**Always reproduce:**
- Use same environment
- Match CI conditions
- Run same commands
- Compare results

**Benefits:**
- Faster debugging
- Better understanding
- Easier fixes
- Verified solutions

### 2. Isolate Issues

**Narrow down:**
- Run individual steps
- Test specific components
- Isolate failures
- Identify root causes

**Techniques:**
- Binary search
- Incremental testing
- Component isolation
- Dependency analysis

### 3. Compare with Working Builds

**Compare:**
- Last successful build
- Configurations
- Dependencies
- Environments

**Benefits:**
- Identify changes
- Find differences
- Discover root causes
- Understand issues

### 4. Fix Systematically

**Apply fixes:**
- Incrementally
- Test each fix
- Verify fixes work
- Document changes

**Benefits:**
- Clearer fixes
- Better understanding
- Verified solutions
- Prevented regressions

---

## Integration Patterns

### Pre-Commit Integration

**Run CI checks before commit:**
- Use pre-commit hooks
- Run quality checks
- Validate configuration
- Ensure CI will pass

**Tools:**
- Husky (Node.js)
- pre-commit (Python)
- git-hooks (generic)

### CI/CD Integration

**Ensure compatibility:**
- Same checks in CI and local
- Consistent tool versions
- Same configuration files
- Parallel execution

**Benefits:**
- Consistent quality
- Faster feedback
- Better collaboration
- Fewer surprises

### Monitoring Integration

**Monitor CI health:**
- Track success rates
- Monitor build times
- Alert on failures
- Track trends

**Benefits:**
- Early detection
- Proactive fixes
- Better visibility
- Improved reliability

---

## Common Pitfalls

### Pitfall 1: Not Testing Locally

**Problem:** Committing without local validation

**Solution:**
- Always run CI checks locally
- Use CI local execution tools
- Verify all checks pass
- Fix issues before committing

### Pitfall 2: Environment Mismatches

**Problem:** Different behavior locally vs CI

**Solution:**
- Use same environment
- Match dependency versions
- Check environment variables
- Verify configuration

### Pitfall 3: Ignoring CI Failures

**Problem:** Not fixing CI failures promptly

**Solution:**
- Fix failures immediately
- Don't accumulate issues
- Debug systematically
- Prevent recurrence

### Pitfall 4: Inconsistent Configurations

**Problem:** Different configs in different places

**Solution:**
- Use same configuration
- Centralize configs
- Version control configs
- Document changes

### Pitfall 5: Missing Required Checks

**Problem:** Not including all Arda requirements

**Solution:**
- Use Arda templates
- Validate requirements
- Check configuration
- Update as needed

---

## Quality Assurance

### Pre-Merge Checklist

- [ ] CI configuration valid
- [ ] All required checks present
- [ ] CI runs locally successfully
- [ ] All checks pass
- [ ] Security scans pass
- [ ] Compliance checks pass
- [ ] Documentation updated

### Post-Merge Verification

- [ ] CI passes in production
- [ ] All jobs succeed
- [ ] Artifacts generated
- [ ] Notifications sent
- [ ] Deployment successful (if applicable)

---

## Best Practices Summary

1. **Validate locally** before committing
2. **Use CI local execution tools** for testing
3. **Match CI environment** when debugging
4. **Run all checks** consistently
5. **Fix failures immediately** - don't accumulate
6. **Use caching** for performance
7. **Run jobs in parallel** when possible
8. **Set appropriate timeouts** to prevent hangs
9. **Manage artifacts** for debugging
10. **Monitor CI health** proactively

---

**Last Updated:** 2025-01-06

