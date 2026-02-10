---
name: ci-validation
description: Validates CI/CD configurations, runs CI checks locally, and debugs failures to ensure everything passes correctly in the Arda ecosystem. Use when validating CI pipelines, debugging CI failures, or ensuring CI passes before merging.
license: Complete terms in LICENSE.txt
---

# CI Validation Skill

## Overview

This skill provides comprehensive CI/CD validation and debugging capabilities for the Arda ecosystem. It detects CI configurations, validates pipeline definitions, runs CI checks locally, identifies failures, and provides debugging guidance to ensure all CI checks pass correctly.

---

# Process

## 🚀 High-Level Workflow

CI validation involves detecting CI systems, validating configurations, running checks locally, and debugging any failures:

### Phase 1: CI System Detection and Analysis

#### 1.1 Detect CI Platform

**Identify CI/CD Platform:**
- **GitHub Actions**: `.github/workflows/*.yml`, `.github/workflows/*.yaml`
- **GitLab CI**: `.gitlab-ci.yml`
- **CircleCI**: `.circleci/config.yml`
- **Jenkins**: `Jenkinsfile`, `Jenkinsfile.groovy`
- **Azure Pipelines**: `azure-pipelines.yml`
- **Travis CI**: `.travis.yml`
- **Bitbucket Pipelines**: `bitbucket-pipelines.yml`
- **Arda-Specific**: Custom Arda CI configurations

**Check for Multiple Systems:**
- Detect all CI systems in use
- Identify primary CI system
- Check for CI orchestration layers
- Verify Arda ecosystem requirements

#### 1.2 Analyze CI Configuration

**Parse Configuration Files:**
- Validate YAML/JSON syntax
- Check for required Arda standards
- Identify workflow stages
- Map dependencies between jobs
- Detect test, build, and deployment steps

**Arda Ecosystem Requirements:**
- Required checks (tests, linting, security)
- Required stages (build, test, deploy)
- Required notifications
- Compliance checks
- Quality gates

---

### Phase 2: Local CI Validation

**Load [📋 CI Configuration Guide](./reference/ci_configuration.md) for comprehensive CI setup strategies.**

#### 2.1 Validate Configuration Syntax

**Check Configuration Files:**
```bash
# GitHub Actions
yamllint .github/workflows/*.yml

# GitLab CI
gitlab-ci-lint .gitlab-ci.yml

# CircleCI
circleci config validate

# General YAML validation
yamllint <config-file>
```

**Validation Requirements:**
- Valid YAML/JSON syntax
- Required fields present
- Correct structure
- No syntax errors

#### 2.2 Run CI Checks Locally

**Simulate CI Environment:**
```bash
# GitHub Actions (using act)
act -j <job-name>

# GitLab CI (using gitlab-runner)
gitlab-runner exec docker <job-name>

# CircleCI (using circleci-cli)
circleci local execute

# Generic: Run individual steps
# Build, test, lint, format, etc.
```

**Local Execution:**
- Run build steps
- Execute test suites
- Run linters
- Check formatters
- Validate security scans
- Run compliance checks

#### 2.3 Verify Arda Standards

**Check Arda Requirements:**
- Required workflow stages present
- Required quality checks configured
- Required notifications configured
- Compliance checks enabled
- Security scans enabled
- Documentation checks

**Arda-Specific Validations:**
- Semantic commit validation
- Code coverage requirements
- Security scanning (Snyk, Dependabot)
- Documentation generation
- License compliance
- Dependency updates

---

### Phase 3: CI Failure Debugging

**Load [🐛 CI Debugging Guide](./reference/ci_debugging.md) for comprehensive debugging strategies.**

#### 3.1 Identify Failure Points

**Analyze CI Logs:**
- Parse CI output logs
- Identify failing jobs/steps
- Extract error messages
- Map failures to code changes
- Identify root causes

**Failure Categories:**
- **Build Failures**: Compilation errors, dependency issues
- **Test Failures**: Failing tests, flaky tests, timeout issues
- **Linter Failures**: Code quality issues, style violations
- **Security Failures**: Vulnerabilities, policy violations
- **Deployment Failures**: Infrastructure, configuration issues

#### 3.2 Debug Build Failures

**Common Build Issues:**
- Missing dependencies
- Version conflicts
- Environment variables
- Build tool configuration
- Platform-specific issues

**Debugging Steps:**
1. Check dependency versions
2. Verify environment setup
3. Test build locally
4. Compare with working builds
5. Check for recent changes

#### 3.3 Debug Test Failures

**Common Test Issues:**
- Failing assertions
- Flaky tests
- Timeout issues
- Environment differences
- Test data issues

**Debugging Steps:**
1. Run tests locally
2. Check test logs
3. Identify failing tests
4. Reproduce failures
5. Fix or skip appropriately

#### 3.4 Debug Linter Failures

**Common Linter Issues:**
- Code style violations
- Quality issues
- Security warnings
- Configuration problems

**Debugging Steps:**
1. Run linter locally
2. Fix auto-fixable issues
3. Address critical issues
4. Update linter config if needed
5. Verify fixes

---

### Phase 4: Fix and Validate

#### 4.1 Apply Fixes

**Fix Identified Issues:**
- Update code to fix failures
- Update configuration files
- Fix dependency issues
- Resolve environment problems
- Update CI configuration

#### 4.2 Re-run Validation

**Verify Fixes:**
- Run CI checks locally again
- Validate configuration
- Test fixes
- Ensure all checks pass
- Verify Arda standards

#### 4.3 Provide Summary

**Validation Summary:**
- All checks passed
- Issues fixed
- Configuration valid
- Ready for merge/deploy
- Next steps

---

# Reference

## CI Platform Detection

### GitHub Actions

**Detection:**
- Check for `.github/workflows/` directory
- Look for `.yml` or `.yaml` files

**Configuration:**
- Workflow files in `.github/workflows/`
- Uses YAML format
- Supports matrix builds
- Integrates with GitHub ecosystem

**Local Testing:**
```bash
# Using act
act -j <job-name>
act -l  # List workflows
act -W .github/workflows/<workflow>.yml
```

### GitLab CI

**Detection:**
- Check for `.gitlab-ci.yml` in root

**Configuration:**
- Single YAML file
- Stage-based pipelines
- Supports Docker, Kubernetes

**Local Testing:**
```bash
# Using gitlab-runner
gitlab-runner exec docker <job-name>
gitlab-runner exec shell <job-name>
```

### CircleCI

**Detection:**
- Check for `.circleci/config.yml`

**Configuration:**
- YAML configuration
- Orb-based workflows
- Supports Docker, machine executors

**Local Testing:**
```bash
# Using circleci-cli
circleci config validate
circleci local execute
circleci local execute --job <job-name>
```

### Jenkins

**Detection:**
- Check for `Jenkinsfile` or `Jenkinsfile.groovy`

**Configuration:**
- Groovy-based DSL
- Declarative or scripted pipelines
- Extensive plugin ecosystem

**Local Testing:**
```bash
# Using Jenkins CLI
jenkins-cli build <job-name>
# Or run Jenkinsfile locally with Jenkinsfile-runner
```

### Azure Pipelines

**Detection:**
- Check for `azure-pipelines.yml`

**Configuration:**
- YAML-based
- Multi-stage pipelines
- Azure-specific integrations

**Local Testing:**
```bash
# Using Azure DevOps CLI
az pipelines run --name <pipeline-name>
```

## Arda Ecosystem Requirements

### Required Checks

**Quality Checks:**
- Unit tests
- Integration tests
- Linting
- Code formatting
- Type checking (if applicable)

**Security Checks:**
- Dependency scanning
- Vulnerability scanning
- Secret scanning
- SAST (Static Application Security Testing)

**Compliance Checks:**
- License compliance
- Documentation checks
- Code coverage requirements
- Semantic commit validation

### Required Stages

**Build Stage:**
- Compile/build project
- Install dependencies
- Prepare artifacts

**Test Stage:**
- Run unit tests
- Run integration tests
- Generate coverage reports

**Quality Stage:**
- Run linters
- Check code formatting
- Validate code quality

**Security Stage:**
- Scan dependencies
- Check for vulnerabilities
- Scan for secrets

**Deploy Stage (if applicable):**
- Build deployment artifacts
- Deploy to staging
- Run smoke tests

### Required Notifications

**Status Notifications:**
- Success/failure notifications
- Slack/Teams integration
- Email notifications
- Status badges

## Local CI Execution

### GitHub Actions (act)

**Installation:**
```bash
# macOS
brew install act

# Linux
curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
```

**Usage:**
```bash
# List workflows
act -l

# Run specific workflow
act -W .github/workflows/ci.yml

# Run specific job
act -j test

# Run with secrets
act --secret-file .secrets

# Run with environment variables
act -e .env
```

### GitLab CI (gitlab-runner)

**Installation:**
```bash
# macOS
brew install gitlab-runner

# Linux
curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
sudo apt-get install gitlab-runner
```

**Usage:**
```bash
# Validate config
gitlab-runner exec docker --docker-privileged validate

# Run specific job
gitlab-runner exec docker <job-name>

# Run with custom image
gitlab-runner exec docker --docker-image node:18 <job-name>
```

### CircleCI (circleci-cli)

**Installation:**
```bash
# macOS
brew install circleci

# Linux
curl -fLSs https://raw.githubusercontent.com/CircleCI-Public/circleci-cli/main/install.sh | sudo bash
```

**Usage:**
```bash
# Validate config
circleci config validate

# Process config
circleci config process .circleci/config.yml

# Run locally
circleci local execute

# Run specific job
circleci local execute --job <job-name>
```

## Common CI Failures

### Build Failures

**Symptoms:**
- Compilation errors
- Missing dependencies
- Version conflicts
- Environment issues

**Solutions:**
- Check dependency versions
- Verify build environment
- Update build configuration
- Check for breaking changes

### Test Failures

**Symptoms:**
- Failing assertions
- Timeout errors
- Flaky tests
- Environment differences

**Solutions:**
- Run tests locally
- Fix failing tests
- Address flaky tests
- Update test configuration

### Linter Failures

**Symptoms:**
- Code style violations
- Quality issues
- Security warnings

**Solutions:**
- Fix auto-fixable issues
- Address critical issues
- Update linter configuration
- Suppress false positives appropriately

### Security Failures

**Symptoms:**
- Vulnerable dependencies
- Secret leaks
- Policy violations

**Solutions:**
- Update dependencies
- Remove secrets
- Fix policy violations
- Update security policies

## Debugging Strategies

### 1. Reproduce Locally

**Steps:**
1. Run CI steps locally
2. Use same environment
3. Use same dependencies
4. Compare results

### 2. Check Logs

**Analysis:**
- Parse CI logs
- Identify error messages
- Check stack traces
- Look for patterns

### 3. Compare with Working Builds

**Comparison:**
- Check last successful build
- Compare configurations
- Identify changes
- Find root cause

### 4. Isolate Issues

**Isolation:**
- Run individual steps
- Test specific components
- Narrow down failures
- Identify dependencies

### 5. Fix and Verify

**Verification:**
- Apply fixes
- Re-run locally
- Verify fixes work
- Check CI passes

---

# Reference Files

## 📚 Documentation Library

Load these resources as needed during CI validation:

### Core Guides (Load First)
- [📋 CI Configuration Guide](./reference/ci_configuration.md) - Comprehensive guide on CI setup including:
  - Platform-specific configurations
  - Arda ecosystem requirements
  - Best practices and patterns
  - Common configurations

- [🐛 CI Debugging Guide](./reference/ci_debugging.md) - Complete debugging strategies including:
  - Failure identification
  - Debugging techniques
  - Common issues and solutions
  - Troubleshooting workflows

- [✅ Best Practices Guide](./reference/best_practices.md) - Best practices for CI validation including:
  - Validation workflows
  - Local testing strategies
  - Debugging approaches
  - Integration patterns

---

**Skill Version:** 1.0
**Last Updated:** 2025-01-06
**Maintained By:** Arda Development Team
**Dependencies:** CI platform tools (act, gitlab-runner, circleci-cli), yamllint

