# Quality Checks Guide

## Overview

This guide covers how to detect repository types and execute appropriate quality checks (build, test, lint, format) before committing code changes.

---

## Repository Detection

### Detection Strategy

**Priority Order:**
1. Check for language-specific files
2. Check for build configuration files
3. Check for test framework files
4. Check for linter/formatter config files
5. Fall back to Makefile or common patterns

### Language Detection

**Node.js/TypeScript:**
- `package.json` (primary indicator)
- `tsconfig.json` (TypeScript)
- `yarn.lock` or `package-lock.json`
- `pnpm-lock.yaml`

**Python:**
- `requirements.txt`
- `pyproject.toml`
- `setup.py`
- `Pipfile`
- `poetry.lock`

**Go:**
- `go.mod`
- `go.sum`

**Rust:**
- `Cargo.toml`
- `Cargo.lock`

**Java:**
- `pom.xml` (Maven)
- `build.gradle` or `build.gradle.kts` (Gradle)
- `build.xml` (Ant)

**Ruby:**
- `Gemfile`
- `Rakefile`

**Other:**
- `Makefile` (generic build)
- `.github/workflows/` (CI hints)
- Language-specific patterns

---

## Build Commands

### Node.js/TypeScript

**Detection:**
- Check for `package.json`
- Look for `build` script in `package.json`

**Commands:**
```bash
# npm
npm run build

# yarn
yarn build

# pnpm
pnpm build

# TypeScript directly
tsc --build
```

**Configuration:**
- Check `package.json` scripts
- Look for `build` script
- Fall back to `tsc` if TypeScript detected

### Python

**Detection:**
- Check for `setup.py`, `pyproject.toml`, or `requirements.txt`
- Most Python projects don't need build step

**Commands:**
```bash
# If setup.py exists
python setup.py build

# Development install
pip install -e .

# Usually skip (pure Python)
# No build needed
```

**Configuration:**
- Skip build for pure Python projects
- Only build if `setup.py` or build config exists

### Go

**Detection:**
- Check for `go.mod`

**Commands:**
```bash
# Build all packages
go build ./...

# Build specific package
go build -o bin/app ./cmd/app

# Build with tags
go build -tags production ./...
```

**Configuration:**
- Default to `go build ./...`
- Check for custom build scripts

### Rust

**Detection:**
- Check for `Cargo.toml`

**Commands:**
```bash
# Debug build
cargo build

# Release build
cargo build --release

# Build specific package
cargo build -p package-name
```

**Configuration:**
- Default to `cargo build`
- Check for workspace configuration

### Java (Maven)

**Detection:**
- Check for `pom.xml`

**Commands:**
```bash
# Build
mvn compile

# Package
mvn package

# Skip tests
mvn package -DskipTests
```

### Java (Gradle)

**Detection:**
- Check for `build.gradle` or `build.gradle.kts`

**Commands:**
```bash
# Build
./gradlew build

# Compile
./gradlew compileJava

# Skip tests
./gradlew build -x test
```

### Generic (Makefile)

**Detection:**
- Check for `Makefile`

**Commands:**
```bash
# Build
make build

# Or default target
make
```

---

## Test Commands

### Node.js/TypeScript

**Detection:**
- Check `package.json` for test script
- Look for test framework files

**Commands:**
```bash
# npm
npm test

# yarn
yarn test

# pnpm
pnpm test

# Specific test suites
npm run test:unit
npm run test:integration

# Jest directly
npx jest

# Mocha
npx mocha

# Vitest
npx vitest
```

**Configuration:**
- Check `package.json` scripts
- Look for `test`, `test:unit`, `test:integration`
- Detect framework from dependencies

### Python

**Detection:**
- Check for `pytest.ini`, `setup.py`, or test files

**Commands:**
```bash
# pytest
pytest
python -m pytest

# unittest
python -m unittest

# tox
tox

# With coverage
pytest --cov

# Specific test file
pytest tests/test_user.py
```

**Configuration:**
- Default to `pytest` if available
- Fall back to `unittest`
- Check for test configuration files

### Go

**Detection:**
- Tests are part of Go standard library

**Commands:**
```bash
# All tests
go test ./...

# Verbose
go test -v ./...

# With race detector
go test -race ./...

# Specific package
go test ./pkg/user

# Coverage
go test -cover ./...
```

**Configuration:**
- Default to `go test ./...`
- Support common flags

### Rust

**Detection:**
- Tests are part of Rust standard library

**Commands:**
```bash
# All tests
cargo test

# Specific test
cargo test test_name

# With features
cargo test --all-features

# Release mode
cargo test --release
```

**Configuration:**
- Default to `cargo test`
- Check for test configuration

### Java (Maven)

**Commands:**
```bash
# Run tests
mvn test

# Skip tests
mvn test -DskipTests
```

### Java (Gradle)

**Commands:**
```bash
# Run tests
./gradlew test

# Specific test
./gradlew test --tests TestClassName
```

---

## Linter Commands

### Node.js/TypeScript

**Detection:**
- Check for ESLint, TSLint config files
- Check `package.json` for lint script

**Commands:**
```bash
# npm script
npm run lint

# ESLint
npx eslint .

# TSLint
npx tslint -p tsconfig.json

# With auto-fix
npx eslint --fix .
```

**Configuration:**
- Check for `.eslintrc.*`, `eslint.config.js`
- Check `package.json` scripts
- Support auto-fix flag

### Python

**Detection:**
- Check for linter config files

**Commands:**
```bash
# ruff (modern, fast)
ruff check .

# flake8
flake8 .

# pylint
pylint .

# mypy (type checking)
mypy .

# With auto-fix
ruff check --fix .
```

**Configuration:**
- Prefer `ruff` (modern, fast)
- Fall back to `flake8` or `pylint`
- Check for config files

### Go

**Detection:**
- Check for `golangci-lint` config

**Commands:**
```bash
# golangci-lint (recommended)
golangci-lint run

# golint (deprecated)
golint ./...

# staticcheck
staticcheck ./...

# With auto-fix
golangci-lint run --fix
```

**Configuration:**
- Prefer `golangci-lint`
- Check for `.golangci.yml` config

### Rust

**Commands:**
```bash
# clippy
cargo clippy

# With warnings as errors
cargo clippy -- -D warnings

# Auto-fix
cargo clippy --fix
```

**Configuration:**
- Default to `cargo clippy`
- Check for clippy config

### Java

**Commands:**
```bash
# Checkstyle
mvn checkstyle:check

# PMD
mvn pmd:check

# SpotBugs
mvn spotbugs:check
```

---

## Formatter Commands

### Node.js/TypeScript

**Detection:**
- Check for Prettier config
- Check `package.json` for format script

**Commands:**
```bash
# npm script
npm run format

# Prettier
npx prettier --write .

# ESLint auto-fix
npx eslint --fix .
```

**Configuration:**
- Check for `.prettierrc`, `prettier.config.js`
- Check `package.json` scripts
- Support file patterns

### Python

**Detection:**
- Check for formatter config files

**Commands:**
```bash
# ruff format (modern, fast)
ruff format .

# black
black .

# autopep8
autopep8 --in-place --recursive .
```

**Configuration:**
- Prefer `ruff format` or `black`
- Check for config files
- Support file patterns

### Go

**Commands:**
```bash
# gofmt
gofmt -w .

# goimports (gofmt + imports)
goimports -w .
```

**Configuration:**
- Default to `gofmt -w .`
- Can use `goimports` for import management

### Rust

**Commands:**
```bash
# rustfmt
cargo fmt
```

**Configuration:**
- Default to `cargo fmt`
- Check for `rustfmt.toml` config

### Java

**Commands:**
```bash
# Google Java Format
java -jar google-java-format.jar -r .

# Spotless (Gradle)
./gradlew spotlessApply
```

---

## Error Handling

### Build Failures

**Strategy:**
1. Display build errors clearly
2. Do not proceed with commit
3. Suggest fixes if possible
4. Allow override with flag (if appropriate)

**Example:**
```
✗ Build failed: TypeScript compilation errors
  src/user.ts:15:5 - error TS2322: Type 'string' is not assignable to type 'number'

  Fix the errors above and try again.
  Or use --skip-build to skip build step.
```

### Test Failures

**Strategy:**
1. Display failing tests
2. Show test output
3. Do not proceed with commit
4. Allow override only for specific cases

**Example:**
```
✗ Tests failed: 2 tests failed, 15 passed

  FAIL  tests/user.test.ts
    × User creation
      Expected: success
      Received: error

  Fix failing tests and try again.
  Or use --skip-tests to skip test step.
```

### Linter Errors

**Strategy:**
1. Auto-fix fixable issues
2. Report non-fixable issues
3. Fail commit if critical issues
4. Show linter output

**Example:**
```
⚠ Linter found 3 issues (2 auto-fixed, 1 requires manual fix)

  ✓ Fixed: Missing semicolon (auto-fixed)
  ✓ Fixed: Trailing whitespace (auto-fixed)
  ✗ Error: Unused variable 'user' (line 42)

  Fix the error above and try again.
```

### Formatter Issues

**Strategy:**
1. Auto-format all files
2. Stage formatted files
3. Continue with commit
4. Show what was formatted

**Example:**
```
✓ Formatted 5 files:
  - src/user.ts
  - src/auth.ts
  - tests/user.test.ts
  - tests/auth.test.ts
  - src/utils.ts

  Formatted files have been staged.
```

---

## Configuration Detection

### Package Managers

**Node.js:**
- Check for `package-lock.json` (npm)
- Check for `yarn.lock` (yarn)
- Check for `pnpm-lock.yaml` (pnpm)

**Python:**
- Check for `requirements.txt` (pip)
- Check for `Pipfile` (pipenv)
- Check for `pyproject.toml` (poetry)

### Config Files

**ESLint:**
- `.eslintrc.js`, `.eslintrc.json`, `.eslintrc.yml`
- `eslint.config.js`
- `package.json` (eslintConfig)

**Prettier:**
- `.prettierrc`, `.prettierrc.json`, `.prettierrc.yml`
- `prettier.config.js`
- `package.json` (prettier)

**Python:**
- `pyproject.toml` (ruff, black, etc.)
- `.ruff.toml`, `.ruff.toml`
- `setup.cfg` (flake8)

**Go:**
- `.golangci.yml`
- `golangci.yaml`

---

## Best Practices

### 1. Detect Before Running

- Always detect repository type first
- Check for tool availability
- Verify configuration exists
- Skip if not applicable

### 2. Provide Clear Feedback

- Show what's being checked
- Display progress
- Report results clearly
- Suggest fixes

### 3. Handle Missing Tools

- Check if tools are installed
- Provide installation instructions
- Skip gracefully if missing
- Warn but don't fail

### 4. Support Overrides

- Allow skipping specific checks
- Support `--skip-build`, `--skip-tests`, etc.
- Respect `--no-verify` flag
- Document override options

### 5. Auto-Fix When Possible

- Auto-fix linter issues
- Auto-format code
- Stage fixed files
- Continue with commit

---

**Last Updated:** 2025-01-06

