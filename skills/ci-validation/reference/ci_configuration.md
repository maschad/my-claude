# CI Configuration Guide

## Overview

This guide covers CI/CD configuration for the Arda ecosystem, including platform-specific setups, required checks, and best practices.

---

## Arda Ecosystem Requirements

### Required Quality Checks

**Build:**
- Project must build successfully
- Dependencies must install correctly
- Artifacts must be generated

**Tests:**
- Unit tests must pass
- Integration tests must pass
- Test coverage requirements (minimum 80%)
- No flaky tests

**Linting:**
- Code must pass linters
- No critical linting errors
- Auto-fixable issues resolved

**Formatting:**
- Code must be formatted
- Consistent formatting across codebase
- Formatting checks enforced

**Security:**
- Dependency scanning (Snyk, Dependabot)
- Vulnerability scanning
- Secret scanning
- SAST (Static Application Security Testing)

**Compliance:**
- License compliance checks
- Documentation generation
- Semantic commit validation
- Code coverage reporting

### Required Stages

**Build Stage:**
- Install dependencies
- Build project
- Generate artifacts

**Test Stage:**
- Run unit tests
- Run integration tests
- Generate coverage reports

**Quality Stage:**
- Run linters
- Check formatting
- Validate code quality

**Security Stage:**
- Scan dependencies
- Check vulnerabilities
- Scan for secrets

**Deploy Stage (if applicable):**
- Build deployment artifacts
- Deploy to staging
- Run smoke tests

---

## GitHub Actions Configuration

### Basic Workflow Structure

```yaml
name: CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
      - name: Install dependencies
        run: npm ci
      - name: Build
        run: npm run build
      - name: Test
        run: npm test
      - name: Lint
        run: npm run lint
      - name: Format check
        run: npm run format:check
```

### Arda Requirements Template

```yaml
name: Arda CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      # Setup
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'

      # Build
      - name: Install dependencies
        run: npm ci
      - name: Build
        run: npm run build

      # Test
      - name: Run tests
        run: npm test
      - name: Coverage
        run: npm run test:coverage
        continue-on-error: false

      # Quality
      - name: Lint
        run: npm run lint
      - name: Format check
        run: npm run format:check
      - name: Type check
        run: npm run type-check

      # Security
      - name: Security scan
        uses: snyk/actions/node@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
      - name: Dependency check
        uses: actions/dependency-review-action@v3

      # Compliance
      - name: License check
        run: npm run license-check
      - name: Coverage report
        uses: codecov/codecov-action@v3
        with:
          file: ./coverage/lcov.info
```

### Matrix Builds

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: [16, 18, 20]
        os: [ubuntu-latest, macos-latest, windows-latest]
    steps:
      - uses: actions/checkout@v4
      - name: Setup Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
      - name: Install and test
        run: |
          npm ci
          npm test
```

---

## GitLab CI Configuration

### Basic Pipeline Structure

```yaml
stages:
  - build
  - test
  - quality
  - security
  - deploy

variables:
  NODE_VERSION: "18"

build:
  stage: build
  image: node:${NODE_VERSION}
  script:
    - npm ci
    - npm run build
  artifacts:
    paths:
      - dist/
    expire_in: 1 hour

test:
  stage: test
  image: node:${NODE_VERSION}
  script:
    - npm ci
    - npm test
    - npm run test:coverage
  coverage: '/Lines\s*:\s*(\d+\.\d+)%/'
  artifacts:
    reports:
      coverage_report:
        coverage_format: cobertura
        path: coverage/cobertura-coverage.xml

lint:
  stage: quality
  image: node:${NODE_VERSION}
  script:
    - npm ci
    - npm run lint
    - npm run format:check

security:
  stage: security
  image: node:${NODE_VERSION}
  script:
    - npm audit --audit-level=moderate
  allow_failure: false
```

### Arda Requirements Template

```yaml
stages:
  - build
  - test
  - quality
  - security
  - compliance
  - deploy

variables:
  NODE_VERSION: "18"

# Build stage
build:
  stage: build
  image: node:${NODE_VERSION}
  script:
    - npm ci
    - npm run build
  artifacts:
    paths:
      - dist/
    expire_in: 1 hour
  only:
    - merge_requests
    - main
    - develop

# Test stage
test:
  stage: test
  image: node:${NODE_VERSION}
  script:
    - npm ci
    - npm test
    - npm run test:coverage
  coverage: '/Lines\s*:\s*(\d+\.\d+)%/'
  artifacts:
    reports:
      coverage_report:
        coverage_format: cobertura
        path: coverage/cobertura-coverage.xml
  only:
    - merge_requests
    - main
    - develop

# Quality stage
lint:
  stage: quality
  image: node:${NODE_VERSION}
  script:
    - npm ci
    - npm run lint
  allow_failure: false

format:
  stage: quality
  image: node:${NODE_VERSION}
  script:
    - npm ci
    - npm run format:check
  allow_failure: false

# Security stage
security-scan:
  stage: security
  image: node:${NODE_VERSION}
  script:
    - npm audit --audit-level=moderate
  allow_failure: false

snyk-scan:
  stage: security
  image: snyk/snyk:node
  script:
    - snyk test --severity-threshold=high
  allow_failure: false
  only:
    - merge_requests
    - main

# Compliance stage
license-check:
  stage: compliance
  image: node:${NODE_VERSION}
  script:
    - npm run license-check
  allow_failure: false
```

---

## CircleCI Configuration

### Basic Configuration

```yaml
version: 2.1

orbs:
  node: circleci/node@5.0.0

jobs:
  build:
    executor: node/default
    steps:
      - checkout
      - node/install-packages
      - run:
          name: Build
          command: npm run build
      - run:
          name: Test
          command: npm test
      - run:
          name: Lint
          command: npm run lint

workflows:
  build-and-test:
    jobs:
      - build
```

### Arda Requirements Template

```yaml
version: 2.1

orbs:
  node: circleci/node@5.0.0
  codecov: codecov/codecov@3.2.0

jobs:
  build:
    executor: node/default
    steps:
      - checkout
      - node/install-packages
      - run:
          name: Build
          command: npm run build
      - persist_to_workspace:
          root: ~/project
          paths:
            - dist

  test:
    executor: node/default
    steps:
      - checkout
      - node/install-packages
      - run:
          name: Test
          command: npm test
      - run:
          name: Coverage
          command: npm run test:coverage
      - codecov/upload

  lint:
    executor: node/default
    steps:
      - checkout
      - node/install-packages
      - run:
          name: Lint
          command: npm run lint

  format:
    executor: node/default
    steps:
      - checkout
      - node/install-packages
      - run:
          name: Format check
          command: npm run format:check

  security:
    executor: node/default
    steps:
      - checkout
      - node/install-packages
      - run:
          name: Security audit
          command: npm audit --audit-level=moderate

workflows:
  build-and-test:
    jobs:
      - build
      - test:
          requires:
            - build
      - lint:
          requires:
            - build
      - format:
          requires:
            - build
      - security:
          requires:
            - build
```

---

## Platform-Specific Patterns

### Node.js/TypeScript Projects

**Common Steps:**
```yaml
- name: Setup Node.js
  uses: actions/setup-node@v4
  with:
    node-version: '18'
    cache: 'npm'

- name: Install dependencies
  run: npm ci

- name: Build
  run: npm run build

- name: Test
  run: npm test

- name: Lint
  run: npm run lint

- name: Type check
  run: npm run type-check
```

### Python Projects

**Common Steps:**
```yaml
- name: Setup Python
  uses: actions/setup-python@v4
  with:
    python-version: '3.11'
    cache: 'pip'

- name: Install dependencies
  run: |
    pip install -r requirements.txt
    pip install -r requirements-dev.txt

- name: Test
  run: pytest

- name: Lint
  run: ruff check .

- name: Format check
  run: ruff format --check .
```

### Go Projects

**Common Steps:**
```yaml
- name: Setup Go
  uses: actions/setup-go@v4
  with:
    go-version: '1.21'

- name: Build
  run: go build ./...

- name: Test
  run: go test ./...

- name: Lint
  run: golangci-lint run

- name: Format check
  run: |
    gofmt -l . | grep -q . && exit 1 || exit 0
```

### Rust Projects

**Common Steps:**
```yaml
- name: Setup Rust
  uses: actions-rs/toolchain@v1
  with:
    toolchain: stable

- name: Build
  run: cargo build

- name: Test
  run: cargo test

- name: Lint
  run: cargo clippy -- -D warnings

- name: Format check
  run: cargo fmt -- --check
```

---

## Security Configuration

### Dependency Scanning

**GitHub Actions (Snyk):**
```yaml
- name: Run Snyk to check for vulnerabilities
  uses: snyk/actions/node@master
  env:
    SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
  with:
    args: --severity-threshold=high
```

**GitLab CI (Snyk):**
```yaml
snyk-scan:
  stage: security
  image: snyk/snyk:node
  script:
    - snyk test --severity-threshold=high
  only:
    - merge_requests
```

### Secret Scanning

**GitHub Actions:**
```yaml
- name: Secret scanning
  uses: trufflesecurity/trufflehog@main
  with:
    path: ./
    base: ${{ github.event.repository.default_branch }}
    head: HEAD
```

### SAST (Static Application Security Testing)

**GitHub Actions (CodeQL):**
```yaml
- name: Initialize CodeQL
  uses: github/codeql-action/init@v2
  with:
    languages: javascript

- name: Perform CodeQL Analysis
  uses: github/codeql-action/analyze@v2
```

---

## Best Practices

### 1. Use Caching

**Benefits:**
- Faster builds
- Reduced resource usage
- Better performance

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

# Go
- uses: actions/cache@v3
  with:
    path: ~/go/pkg/mod
    key: ${{ runner.os }}-go-${{ hashFiles('**/go.sum') }}
```

### 2. Parallel Jobs

**Benefits:**
- Faster CI runs
- Better resource utilization
- Independent job execution

**Example:**
```yaml
jobs:
  test:
    # ... test job
  lint:
    # ... lint job
  format:
    # ... format job
  # All run in parallel
```

### 3. Conditional Execution

**Benefits:**
- Skip unnecessary jobs
- Faster feedback
- Resource efficiency

**Example:**
```yaml
jobs:
  deploy:
    if: github.ref == 'refs/heads/main'
    # Only run on main branch
```

### 4. Artifact Management

**Benefits:**
- Share artifacts between jobs
- Preserve build outputs
- Enable debugging

**Example:**
```yaml
- name: Upload artifacts
  uses: actions/upload-artifact@v3
  with:
    name: dist
    path: dist/
```

### 5. Failure Notifications

**Benefits:**
- Immediate feedback
- Better collaboration
- Faster issue resolution

**Example:**
```yaml
- name: Notify on failure
  if: failure()
  uses: 8398a7/action-slack@v3
  with:
    status: ${{ job.status }}
    text: 'CI failed'
```

---

## Validation Checklist

### Configuration Validation

- [ ] YAML syntax is valid
- [ ] Required stages present
- [ ] Required checks configured
- [ ] Dependencies correct
- [ ] Secrets configured
- [ ] Artifacts configured
- [ ] Notifications configured

### Arda Requirements

- [ ] Build stage configured
- [ ] Test stage configured
- [ ] Quality checks configured
- [ ] Security scans configured
- [ ] Compliance checks configured
- [ ] Coverage reporting configured
- [ ] Semantic commit validation

### Best Practices

- [ ] Caching enabled
- [ ] Parallel jobs used
- [ ] Conditional execution
- [ ] Artifact management
- [ ] Failure notifications
- [ ] Timeout configured
- [ ] Resource limits set

---

**Last Updated:** 2025-01-06

