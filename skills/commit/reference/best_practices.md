# Commit Best Practices

## Overview

This guide provides best practices for using the commit skill effectively, ensuring code quality and consistent commit messages across the organization.

---

## Workflow Best Practices

### 1. Run Quality Checks Before Committing

**Always run full workflow:**
- Build the project
- Run tests
- Run linters
- Format code
- Then commit

**Benefits:**
- Catch issues early
- Maintain code quality
- Prevent broken commits
- Ensure consistency

### 2. Commit Frequently

**Small, focused commits:**
- Commit logical units of work
- Don't accumulate many changes
- Easier to review and revert
- Clearer commit history

**Avoid:**
- Large commits with many unrelated changes
- Commits that mix features and fixes
- Accumulating changes over days

### 3. Write Clear Commit Messages

**Follow semantic commit format:**
- Use appropriate type
- Include scope when helpful
- Write clear subject
- Add body for complex changes

**Benefits:**
- Easier to understand history
- Better changelog generation
- Improved collaboration
- Automated tooling support

### 4. Test Before Committing

**Always run tests:**
- Ensure all tests pass
- Fix failing tests first
- Don't commit broken code
- Maintain test coverage

**Exception:**
- Only skip tests with explicit flag
- Document why tests were skipped
- Fix tests in follow-up commit

---

## Repository-Specific Practices

### Node.js/TypeScript Projects

**Typical Workflow:**
```bash
# 1. Build
npm run build

# 2. Test
npm test

# 3. Lint
npm run lint

# 4. Format
npm run format

# 5. Commit
git commit -m "feat(api): add user endpoint"
```

**Best Practices:**
- Use npm scripts for consistency
- Configure ESLint and Prettier
- Run type checking (TypeScript)
- Check bundle size if applicable

### Python Projects

**Typical Workflow:**
```bash
# 1. Build (usually skip)
# pip install -e .

# 2. Test
pytest

# 3. Lint
ruff check .

# 4. Format
ruff format .

# 5. Commit
git commit -m "feat(api): add user endpoint"
```

**Best Practices:**
- Use ruff (modern, fast)
- Configure type checking (mypy)
- Run tests with coverage
- Check for security issues

### Go Projects

**Typical Workflow:**
```bash
# 1. Build
go build ./...

# 2. Test
go test ./...

# 3. Lint
golangci-lint run

# 4. Format
gofmt -w .

# 5. Commit
git commit -m "feat(api): add user endpoint"
```

**Best Practices:**
- Use golangci-lint
- Run race detector in tests
- Check for common mistakes
- Maintain go.mod cleanliness

### Rust Projects

**Typical Workflow:**
```bash
# 1. Build
cargo build

# 2. Test
cargo test

# 3. Lint
cargo clippy

# 4. Format
cargo fmt

# 5. Commit
git commit -m "feat(api): add user endpoint"
```

**Best Practices:**
- Use clippy for linting
- Run tests with all features
- Check for unsafe code
- Maintain Cargo.toml

---

## Error Handling

### Build Failures

**What to do:**
1. Fix build errors immediately
2. Don't commit broken builds
3. Check for missing dependencies
4. Verify build configuration

**When to skip:**
- Only with explicit `--skip-build` flag
- Document why build was skipped
- Fix in follow-up commit

### Test Failures

**What to do:**
1. Fix failing tests
2. Don't commit with failing tests
3. Check for flaky tests
4. Update tests if behavior changed

**When to skip:**
- Only with explicit `--skip-tests` flag
- Document why tests were skipped
- Fix tests in follow-up commit

### Linter Errors

**What to do:**
1. Auto-fix when possible
2. Manually fix remaining issues
3. Don't commit with critical errors
4. Update linter config if needed

**When to skip:**
- Only for warnings (not errors)
- Document why linter was skipped
- Fix in follow-up commit

### Formatter Issues

**What to do:**
1. Always format code
2. Stage formatted files
3. Ensure consistency
4. Update formatter config if needed

**When to skip:**
- Never skip formatting
- Formatting is non-negotiable
- Ensures code consistency

---

## Commit Message Best Practices

### 1. Use Appropriate Type

**Choose correct type:**
- `feat` for new features
- `fix` for bug fixes
- `docs` for documentation
- `refactor` for code restructuring
- `perf` for performance
- `test` for tests
- `chore` for maintenance

**Avoid:**
- Using wrong type
- Mixing types in one commit
- Using `feat` for everything

### 2. Include Scope When Helpful

**Use scope for:**
- Multi-component projects
- Clear component boundaries
- Better organization

**Skip scope for:**
- Single-component projects
- Unclear boundaries
- Trivial changes

### 3. Write Clear Subject

**Good subjects:**
- "Add user authentication"
- "Fix null pointer in API"
- "Update documentation"

**Bad subjects:**
- "Fix bug"
- "Update stuff"
- "Changes"

### 4. Add Body for Complex Changes

**Include body for:**
- Complex implementations
- Breaking changes
- Multiple related changes
- Context needed

**Skip body for:**
- Simple, obvious changes
- Trivial updates
- Self-explanatory fixes

### 5. Reference Issues

**Always reference:**
- Related issues
- Pull requests
- Breaking changes
- Migration guides

**Format:**
```
Closes #123
Fixes #456
Refs #789
```

---

## Integration Practices

### Pre-Commit Hooks

**Respect existing hooks:**
- Run quality checks before hooks
- Don't bypass hooks unnecessarily
- Integrate with hook frameworks
- Support `--no-verify` flag

**Common frameworks:**
- Husky (Node.js)
- pre-commit (Python)
- git-hooks (generic)

### CI/CD Integration

**Ensure compatibility:**
- Same checks in CI as local
- Consistent tool versions
- Same configuration files
- Parallel execution when possible

**Benefits:**
- Catch issues early
- Consistent quality
- Faster feedback
- Better collaboration

### Git Workflow

**Branch strategy:**
- Commit to feature branches
- Use semantic commits
- Squash commits when merging
- Maintain clean history

**Pull requests:**
- Use semantic commits
- Reference issues
- Include context
- Follow review guidelines

---

## Common Pitfalls

### Pitfall 1: Skipping Quality Checks

**Problem:** Committing without running checks

**Solution:**
- Always run full workflow
- Use commit skill consistently
- Don't bypass checks
- Fix issues before committing

### Pitfall 2: Poor Commit Messages

**Problem:** Unclear or incorrect commit messages

**Solution:**
- Follow semantic format
- Be specific and clear
- Include context
- Reference issues

### Pitfall 3: Large Commits

**Problem:** Accumulating many changes

**Solution:**
- Commit frequently
- Small, focused commits
- Logical units of work
- Easier to review

### Pitfall 4: Ignoring Test Failures

**Problem:** Committing with failing tests

**Solution:**
- Fix tests first
- Don't skip tests
- Maintain test coverage
- Update tests when needed

### Pitfall 5: Inconsistent Formatting

**Problem:** Different formatting across files

**Solution:**
- Always run formatter
- Use consistent config
- Format before committing
- Check formatter config

---

## Troubleshooting

### Tools Not Found

**Problem:** Build/test/lint tools not installed

**Solution:**
- Install missing tools
- Check PATH configuration
- Use project-specific tools
- Provide installation instructions

### Configuration Issues

**Problem:** Tools not configured correctly

**Solution:**
- Check config files
- Verify tool versions
- Update configuration
- Document requirements

### Performance Issues

**Problem:** Quality checks take too long

**Solution:**
- Optimize check commands
- Use parallel execution
- Cache results when possible
- Skip unnecessary checks

### Inconsistent Results

**Problem:** Different results locally vs CI

**Solution:**
- Use same tool versions
- Same configuration files
- Same environment
- Document differences

---

## Quality Assurance

### Pre-Commit Checklist

- [ ] Code builds successfully
- [ ] All tests pass
- [ ] Linter passes (no errors)
- [ ] Code is formatted
- [ ] Commit message follows format
- [ ] Changes are staged
- [ ] No sensitive data committed

### Post-Commit Verification

- [ ] Commit was created successfully
- [ ] Commit message is correct
- [ ] All changes are committed
- [ ] Commit hash is available
- [ ] Ready to push

---

## Best Practices Summary

1. **Always run quality checks** before committing
2. **Commit frequently** with small, focused changes
3. **Write clear commit messages** following semantic format
4. **Test before committing** - don't commit broken code
5. **Format code consistently** - non-negotiable
6. **Fix issues immediately** - don't accumulate problems
7. **Use appropriate commit type** - be specific
8. **Include scope when helpful** - better organization
9. **Reference issues** - link to related work
10. **Maintain consistency** - same checks everywhere

---

**Last Updated:** 2025-01-06

