# CI Debugging Guide

## Overview

This guide provides comprehensive strategies for debugging CI failures in the Arda ecosystem, including failure identification, root cause analysis, and resolution techniques.

---

## Failure Identification

### Parse CI Logs

**Key Information to Extract:**
- Failing job/stage name
- Error messages
- Stack traces
- Exit codes
- Timing information
- Environment details

**Log Analysis:**
```bash
# GitHub Actions
gh run view <run-id> --log

# GitLab CI
# View in GitLab UI or download logs

# CircleCI
circleci build <build-number>
```

### Identify Failure Categories

**Build Failures:**
- Compilation errors
- Missing dependencies
- Version conflicts
- Configuration issues

**Test Failures:**
- Failing assertions
- Timeout errors
- Flaky tests
- Environment differences

**Linter Failures:**
- Code style violations
- Quality issues
- Security warnings
- Configuration problems

**Security Failures:**
- Vulnerable dependencies
- Secret leaks
- Policy violations
- Compliance issues

**Deployment Failures:**
- Infrastructure issues
- Configuration errors
- Permission problems
- Network issues

---

## Debugging Build Failures

### Common Build Issues

**Missing Dependencies:**
```
Error: Cannot find module 'xyz'
```

**Solutions:**
- Check `package.json` / `requirements.txt`
- Verify dependency installation step
- Check for lock file issues
- Ensure dependencies are in correct file

**Version Conflicts:**
```
Error: Conflicting versions of 'xyz'
```

**Solutions:**
- Check dependency versions
- Update lock files
- Resolve version conflicts
- Use dependency resolution tools

**Environment Variables:**
```
Error: Environment variable 'XYZ' is not set
```

**Solutions:**
- Check CI secrets configuration
- Verify environment variable names
- Ensure secrets are set correctly
- Check for typos in variable names

**Build Tool Configuration:**
```
Error: Build configuration invalid
```

**Solutions:**
- Validate build configuration
- Check for syntax errors
- Verify build tool version
- Compare with working configuration

### Debugging Steps

**1. Reproduce Locally:**
```bash
# Use same environment
docker run -it node:18 bash

# Install dependencies
npm ci

# Run build
npm run build
```

**2. Check Dependencies:**
```bash
# Node.js
npm ls
npm outdated

# Python
pip list
pip check

# Go
go list -m all
go mod verify
```

**3. Compare with Working Build:**
- Check last successful build
- Compare configurations
- Identify changes
- Find root cause

**4. Test Incrementally:**
- Build individual components
- Test specific parts
- Isolate failures
- Narrow down issues

---

## Debugging Test Failures

### Common Test Issues

**Failing Assertions:**
```
Expected: <expected>
Received: <actual>
```

**Solutions:**
- Review test expectations
- Check test data
- Verify test setup
- Update tests if behavior changed

**Flaky Tests:**
```
Test sometimes passes, sometimes fails
```

**Solutions:**
- Identify timing issues
- Check for race conditions
- Fix test isolation
- Add retries if appropriate

**Timeout Errors:**
```
Test exceeded timeout of 5000ms
```

**Solutions:**
- Increase timeout if needed
- Optimize slow tests
- Check for infinite loops
- Review test complexity

**Environment Differences:**
```
Test passes locally but fails in CI
```

**Solutions:**
- Compare environments
- Check environment variables
- Verify test data
- Use same test environment

### Debugging Steps

**1. Run Tests Locally:**
```bash
# Run specific test
npm test -- test-name

# Run with verbose output
npm test -- --verbose

# Run with debug output
DEBUG=* npm test
```

**2. Check Test Logs:**
- Review test output
- Check for error messages
- Look for stack traces
- Identify failing tests

**3. Reproduce Failures:**
- Run failing tests in isolation
- Use same test data
- Match CI environment
- Verify reproduction

**4. Fix Tests:**
- Update test expectations
- Fix test setup
- Address flaky tests
- Optimize slow tests

---

## Debugging Linter Failures

### Common Linter Issues

**Code Style Violations:**
```
Error: Missing semicolon
```

**Solutions:**
- Auto-fix when possible
- Manually fix remaining issues
- Update linter configuration
- Suppress false positives appropriately

**Quality Issues:**
```
Error: Function too complex
```

**Solutions:**
- Refactor code
- Reduce complexity
- Update linter rules
- Document exceptions

**Security Warnings:**
```
Warning: Potential XSS vulnerability
```

**Solutions:**
- Fix security issues
- Update dependencies
- Use secure patterns
- Document false positives

**Configuration Problems:**
```
Error: Linter configuration invalid
```

**Solutions:**
- Validate configuration
- Check for syntax errors
- Verify linter version
- Update configuration

### Debugging Steps

**1. Run Linter Locally:**
```bash
# Run linter
npm run lint

# Auto-fix issues
npm run lint -- --fix

# Check specific file
npx eslint src/file.ts
```

**2. Fix Issues:**
- Auto-fix fixable issues
- Manually fix remaining issues
- Update linter config if needed
- Verify fixes

**3. Update Configuration:**
- Adjust linter rules
- Add exceptions
- Update ignore patterns
- Document changes

---

## Debugging Security Failures

### Common Security Issues

**Vulnerable Dependencies:**
```
Vulnerability found in package 'xyz'
```

**Solutions:**
- Update vulnerable packages
- Use security patches
- Replace insecure packages
- Document exceptions

**Secret Leaks:**
```
Secret detected in code
```

**Solutions:**
- Remove secrets from code
- Use environment variables
- Use secret management
- Rotate exposed secrets

**Policy Violations:**
```
Policy violation: Unapproved license
```

**Solutions:**
- Review license policies
- Replace non-compliant packages
- Request policy exceptions
- Update policies if needed

### Debugging Steps

**1. Review Security Reports:**
- Check vulnerability details
- Review severity levels
- Identify affected packages
- Check for fixes available

**2. Update Dependencies:**
```bash
# Update packages
npm update

# Check for security updates
npm audit fix

# Review updates
npm outdated
```

**3. Fix Issues:**
- Update vulnerable packages
- Remove secrets
- Fix policy violations
- Document exceptions

---

## Debugging Deployment Failures

### Common Deployment Issues

**Infrastructure Issues:**
```
Error: Cannot connect to deployment target
```

**Solutions:**
- Check network connectivity
- Verify infrastructure status
- Check firewall rules
- Verify credentials

**Configuration Errors:**
```
Error: Invalid deployment configuration
```

**Solutions:**
- Validate configuration
- Check for syntax errors
- Verify configuration values
- Compare with working config

**Permission Problems:**
```
Error: Permission denied
```

**Solutions:**
- Check permissions
- Verify credentials
- Update access controls
- Review IAM policies

### Debugging Steps

**1. Check Deployment Logs:**
- Review deployment output
- Check for error messages
- Verify deployment steps
- Identify failure point

**2. Test Deployment:**
- Test deployment locally
- Use staging environment
- Verify configuration
- Test incrementally

**3. Fix Issues:**
- Update configuration
- Fix permissions
- Resolve infrastructure issues
- Verify fixes

---

## Systematic Debugging Approach

### 1. Reproduce Locally

**Steps:**
1. Use same environment as CI
2. Install same dependencies
3. Run same commands
4. Compare results

**Tools:**
- Docker for environment matching
- CI local execution tools (act, gitlab-runner)
- Same dependency versions

### 2. Isolate the Problem

**Steps:**
1. Run individual steps
2. Test specific components
3. Narrow down failures
4. Identify root cause

**Techniques:**
- Binary search
- Incremental testing
- Component isolation
- Dependency analysis

### 3. Compare with Working Builds

**Steps:**
1. Check last successful build
2. Compare configurations
3. Identify changes
4. Find differences

**Tools:**
- Git diff
- Configuration comparison
- Dependency comparison
- Environment comparison

### 4. Check Recent Changes

**Steps:**
1. Review recent commits
2. Check configuration changes
3. Review dependency updates
4. Identify breaking changes

**Commands:**
```bash
# Check recent commits
git log --oneline -10

# Check file changes
git diff HEAD~1

# Check dependency changes
git diff HEAD~1 package.json
```

### 5. Verify Fixes

**Steps:**
1. Apply fixes
2. Test locally
3. Verify fixes work
4. Check CI passes

**Validation:**
- Run CI checks locally
- Verify all tests pass
- Check linters pass
- Confirm security scans pass

---

## Common Debugging Patterns

### Pattern 1: Environment Mismatch

**Symptoms:**
- Works locally, fails in CI
- Different behavior in CI

**Solutions:**
- Use same environment
- Match dependency versions
- Check environment variables
- Verify configuration

### Pattern 2: Timing Issues

**Symptoms:**
- Intermittent failures
- Race conditions
- Timeout errors

**Solutions:**
- Add delays if needed
- Fix race conditions
- Increase timeouts
- Improve test isolation

### Pattern 3: Dependency Issues

**Symptoms:**
- Missing dependencies
- Version conflicts
- Lock file issues

**Solutions:**
- Update lock files
- Resolve conflicts
- Check dependency sources
- Verify installations

### Pattern 4: Configuration Drift

**Symptoms:**
- Configuration errors
- Missing settings
- Incorrect values

**Solutions:**
- Validate configuration
- Compare with working config
- Update configuration
- Document changes

---

## Debugging Tools

### Local CI Execution

**GitHub Actions (act):**
```bash
# List workflows
act -l

# Run workflow
act -W .github/workflows/ci.yml

# Run specific job
act -j test

# Debug mode
act -v
```

**GitLab CI (gitlab-runner):**
```bash
# Run job locally
gitlab-runner exec docker <job-name>

# Debug mode
gitlab-runner exec docker --docker-privileged <job-name>
```

**CircleCI (circleci-cli):**
```bash
# Validate config
circleci config validate

# Run locally
circleci local execute

# Debug mode
circleci local execute --job <job-name> -v
```

### Log Analysis

**Extract Key Information:**
- Error messages
- Stack traces
- Exit codes
- Timing data
- Environment details

**Tools:**
- `grep` for error patterns
- `jq` for JSON logs
- `awk` for text processing
- CI platform APIs

---

## Best Practices

### 1. Reproduce First

- Always reproduce locally
- Use same environment
- Match CI conditions
- Verify reproduction

### 2. Isolate Issues

- Run individual steps
- Test specific components
- Narrow down failures
- Identify root causes

### 3. Compare and Contrast

- Compare with working builds
- Check recent changes
- Identify differences
- Find root causes

### 4. Fix Systematically

- Apply fixes incrementally
- Test each fix
- Verify fixes work
- Document changes

### 5. Prevent Recurrence

- Add tests for issues
- Update documentation
- Improve error messages
- Enhance monitoring

---

**Last Updated:** 2025-01-06

