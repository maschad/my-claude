---
name: commit
description: Comprehensive commit workflow that builds projects, runs tests, linters, and formatters, then creates semantic commits following organizational standards. Use when committing code changes to ensure quality, consistency, and proper commit message formatting.
license: Complete terms in LICENSE.txt
---

# Commit Skill

## Overview

This skill provides a comprehensive commit workflow that ensures code quality before committing. It automatically detects the repository type, builds the project, runs tests, executes linters and formatters, and then creates properly formatted semantic commits following organizational standards.

---

# Process

## 🚀 High-Level Workflow

The commit process involves detecting the repository type, running quality checks, and creating semantic commits:

### Phase 1: Repository Detection and Analysis

#### 1.1 Detect Repository Type

**Identify Project Type:**
- **Node.js/TypeScript**: `package.json`, `tsconfig.json`, `yarn.lock`, `package-lock.json`
- **Python**: `requirements.txt`, `pyproject.toml`, `setup.py`, `Pipfile`
- **Go**: `go.mod`, `go.sum`
- **Rust**: `Cargo.toml`, `Cargo.lock`
- **Java/Maven**: `pom.xml`
- **Java/Gradle**: `build.gradle`, `build.gradle.kts`
- **Ruby**: `Gemfile`, `Rakefile`
- **Other**: Detect from common files and structure

**Check for Build Tools:**
- Build scripts in `package.json`
- Makefiles
- Build configuration files
- CI/CD configuration hints

#### 1.2 Identify Quality Tools

**Test Frameworks:**
- Jest, Mocha, Vitest (Node.js)
- pytest, unittest (Python)
- go test (Go)
- cargo test (Rust)
- JUnit, TestNG (Java)

**Linters:**
- ESLint, TSLint (JavaScript/TypeScript)
- pylint, flake8, ruff (Python)
- golangci-lint (Go)
- clippy (Rust)
- Checkstyle, PMD (Java)

**Formatters:**
- Prettier (JavaScript/TypeScript)
- Black, autopep8 (Python)
- gofmt (Go)
- rustfmt (Rust)
- Google Java Format (Java)

---

### Phase 2: Pre-Commit Quality Checks

**Load [📋 Quality Checks Guide](./reference/quality_checks.md) for comprehensive quality check strategies.**

#### 2.1 Build the Project

**Node.js/TypeScript:**
```bash
# Check for build script
npm run build
# or
yarn build
# or
pnpm build
```

**Python:**
```bash
# Check if build is needed (usually not for pure Python)
python setup.py build
# or
pip install -e .
```

**Go:**
```bash
go build ./...
```

**Rust:**
```bash
cargo build
```

**General:**
- Check for Makefile targets
- Look for build scripts
- Verify build succeeds before proceeding

#### 2.2 Run Tests

**Execute Test Suites:**
```bash
# Node.js
npm test
# or
yarn test
# or
pnpm test

# Python
pytest
# or
python -m pytest
# or
python -m unittest

# Go
go test ./...

# Rust
cargo test
```

**Test Requirements:**
- All tests must pass
- Handle test failures appropriately
- Skip if no tests exist (with notification)
- Support test coverage requirements if configured

#### 2.3 Run Linters

**Execute Linters:**
```bash
# ESLint
npm run lint
# or
npx eslint .

# Python
pylint .
# or
flake8 .
# or
ruff check .

# Go
golangci-lint run

# Rust
cargo clippy
```

**Linter Requirements:**
- Fix auto-fixable issues
- Report non-fixable issues
- Fail commit if critical issues exist
- Support linter configuration files

#### 2.4 Run Formatters

**Execute Formatters:**
```bash
# Prettier
npm run format
# or
npx prettier --write .

# Python Black
black .
# or
ruff format .

# Go
gofmt -w .

# Rust
cargo fmt
```

**Formatter Requirements:**
- Auto-format code
- Stage formatted files
- Ensure consistent formatting
- Support formatter configuration

---

### Phase 3: Create Semantic Commit

**Load [📝 Semantic Commits Guide](./reference/semantic_commits.md) for complete commit message standards.**

#### 3.1 Analyze Changes

**Detect Change Types:**
- Review staged files
- Identify affected areas (features, fixes, docs, etc.)
- Determine appropriate commit type
- Group related changes

**Change Categories:**
- **Features**: New functionality
- **Fixes**: Bug fixes
- **Documentation**: Doc changes
- **Style**: Formatting, whitespace
- **Refactor**: Code restructuring
- **Performance**: Performance improvements
- **Tests**: Test additions/changes
- **Chores**: Build, config, dependencies

#### 3.2 Compose Commit Message

**Semantic Commit Format:**
```
<type>(<scope>): <subject>

<body>

<footer>
```

**Components:**
- **Type**: feat, fix, docs, style, refactor, perf, test, chore
- **Scope**: Optional, component/area affected
- **Subject**: Brief description (50 chars or less)
- **Body**: Detailed explanation (wrap at 72 chars)
- **Footer**: Breaking changes, issue references

**Message Requirements:**
- Use imperative mood ("add feature" not "added feature")
- Capitalize subject line
- No period at end of subject
- Separate body from subject with blank line
- Reference issues in footer

#### 3.3 Execute Commit

**Create Commit:**
```bash
git commit -m "type(scope): subject" -m "body" -m "footer"
```

**Verification:**
- Verify commit message format
- Confirm all changes are committed
- Check commit was successful
- Display commit summary

---

### Phase 4: Post-Commit Verification

#### 4.1 Verify Commit

**Check Commit:**
- Verify commit was created
- Confirm message format is correct
- Display commit hash
- Show commit summary

#### 4.2 Provide Summary

**Commit Summary:**
- Commit hash
- Commit message
- Files changed
- Quality checks passed
- Next steps (push, etc.)

---

# Reference

## Workflow Examples

### Node.js/TypeScript Project

```bash
# 1. Detect: package.json exists
# 2. Build: npm run build
# 3. Test: npm test
# 4. Lint: npm run lint
# 5. Format: npm run format
# 6. Commit: git commit with semantic message
```

### Python Project

```bash
# 1. Detect: requirements.txt or pyproject.toml
# 2. Build: (usually skip for pure Python)
# 3. Test: pytest
# 4. Lint: ruff check . or flake8 .
# 5. Format: ruff format . or black .
# 6. Commit: git commit with semantic message
```

### Go Project

```bash
# 1. Detect: go.mod exists
# 2. Build: go build ./...
# 3. Test: go test ./...
# 4. Lint: golangci-lint run
# 5. Format: gofmt -w .
# 6. Commit: git commit with semantic message
```

## Repository Detection

### Detection Strategy

**Priority Order:**
1. Check for language-specific files (package.json, go.mod, etc.)
2. Check for build configuration files
3. Check for test framework files
4. Check for linter/formatter config files
5. Fall back to Makefile or common patterns

**Common Files:**
- `package.json` → Node.js
- `go.mod` → Go
- `Cargo.toml` → Rust
- `requirements.txt` / `pyproject.toml` → Python
- `pom.xml` → Maven (Java)
- `build.gradle` → Gradle (Java)
- `Gemfile` → Ruby

## Quality Check Patterns

### Build Commands by Type

**Node.js:**
- `npm run build`
- `yarn build`
- `pnpm build`
- `tsc --build` (TypeScript)

**Python:**
- Usually skip (pure Python doesn't need build)
- `python setup.py build` (if setup.py exists)
- `pip install -e .` (development install)

**Go:**
- `go build ./...`
- `go build -o bin/app ./cmd/app`

**Rust:**
- `cargo build`
- `cargo build --release`

### Test Commands by Type

**Node.js:**
- `npm test`
- `yarn test`
- `pnpm test`
- `npm run test:unit`
- `npm run test:integration`

**Python:**
- `pytest`
- `python -m pytest`
- `python -m unittest`
- `tox`

**Go:**
- `go test ./...`
- `go test -v ./...`
- `go test -race ./...`

**Rust:**
- `cargo test`
- `cargo test --all-features`

### Linter Commands by Type

**Node.js:**
- `npm run lint`
- `npx eslint .`
- `npx tslint .`

**Python:**
- `ruff check .`
- `flake8 .`
- `pylint .`
- `mypy .`

**Go:**
- `golangci-lint run`
- `golint ./...`
- `staticcheck ./...`

**Rust:**
- `cargo clippy`
- `cargo clippy -- -D warnings`

### Formatter Commands by Type

**Node.js:**
- `npm run format`
- `npx prettier --write .`
- `npx eslint --fix .`

**Python:**
- `ruff format .`
- `black .`
- `autopep8 --in-place --recursive .`

**Go:**
- `gofmt -w .`
- `goimports -w .`

**Rust:**
- `cargo fmt`

## Error Handling

### Build Failures

**Strategy:**
- Display build errors
- Do not proceed with commit
- Suggest fixes
- Allow override with flag (if appropriate)

### Test Failures

**Strategy:**
- Display failing tests
- Do not proceed with commit
- Show test output
- Allow override only for specific cases

### Linter Errors

**Strategy:**
- Auto-fix fixable issues
- Report non-fixable issues
- Fail commit if critical issues
- Show linter output

### Formatter Issues

**Strategy:**
- Auto-format all files
- Stage formatted files
- Continue with commit
- Show what was formatted

## Integration with Git

### Pre-Commit Hooks

**Check for Existing Hooks:**
- Respect existing pre-commit hooks
- Run quality checks before hooks
- Integrate with hook frameworks (husky, pre-commit)

### Staging Area

**Handle Staging:**
- Check for staged files
- Stage formatted files automatically
- Verify changes before commit
- Handle empty staging area

### Commit Options

**Git Options:**
- Support `--no-verify` flag (skip hooks)
- Support `--amend` flag
- Support `--no-edit` flag
- Handle merge commits appropriately

---

# Reference Files

## 📚 Documentation Library

Load these resources as needed during commit operations:

### Core Guides (Load First)
- [📝 Semantic Commits Guide](./reference/semantic_commits.md) - Complete guide on semantic commit message format including:
  - Commit type specifications
  - Scope and subject guidelines
  - Body and footer formatting
  - Examples and best practices

- [📋 Quality Checks Guide](./reference/quality_checks.md) - Comprehensive guide on running quality checks including:
  - Repository detection strategies
  - Build, test, lint, and format patterns
  - Error handling and recovery
  - Tool configuration

- [✅ Best Practices Guide](./reference/best_practices.md) - Complete best practices for commit workflow including:
  - Workflow patterns
  - Error handling strategies
  - Integration with CI/CD
  - Troubleshooting

---

**Skill Version:** 1.0
**Last Updated:** 2025-01-06
**Maintained By:** Arda Development Team
**Dependencies:** Git, project-specific build/test/lint/format tools

