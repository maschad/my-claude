# Semantic Commits Guide

## Overview

This guide covers the semantic commit message format used across the organization. Semantic commits provide a consistent, machine-readable format that enables automated tooling and clear communication of changes.

---

## Commit Message Format

### Structure

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Components

**Type (Required):**
- Single word describing the change type
- Must be one of: feat, fix, docs, style, refactor, perf, test, chore
- Lowercase

**Scope (Optional):**
- Component or area affected
- Enclosed in parentheses
- Examples: `api`, `auth`, `ui`, `database`

**Subject (Required):**
- Brief description of the change
- Imperative mood ("add feature" not "added feature")
- No period at end
- Capitalize first letter
- 50 characters or less

**Body (Optional):**
- Detailed explanation of what and why
- Wrap at 72 characters
- Separate from subject with blank line
- Can include multiple paragraphs

**Footer (Optional):**
- Breaking changes
- Issue references
- Separate from body with blank line

---

## Commit Types

### `feat`

**Purpose:** New feature for users

**Examples:**
```
feat(auth): add OAuth2 support
feat(api): implement user search endpoint
feat(ui): add dark mode toggle
```

**When to use:**
- Adding new functionality
- Introducing new features
- User-facing changes

### `fix`

**Purpose:** Bug fix

**Examples:**
```
fix(api): resolve null pointer in user endpoint
fix(auth): correct token expiration handling
fix(ui): fix button alignment on mobile
```

**When to use:**
- Fixing bugs
- Resolving issues
- Correcting errors

### `docs`

**Purpose:** Documentation changes

**Examples:**
```
docs: update API documentation
docs(readme): add installation instructions
docs(api): document new endpoint parameters
```

**When to use:**
- Updating documentation
- Adding comments
- Changing README files

### `style`

**Purpose:** Code style changes (formatting, whitespace)

**Examples:**
```
style: format code with prettier
style(api): fix indentation
style: remove trailing whitespace
```

**When to use:**
- Formatting changes
- Whitespace fixes
- Code style adjustments
- No functional changes

### `refactor`

**Purpose:** Code restructuring without functional changes

**Examples:**
```
refactor(api): extract authentication logic
refactor: simplify error handling
refactor(db): reorganize database queries
```

**When to use:**
- Code restructuring
- Improving code structure
- No bug fixes or features

### `perf`

**Purpose:** Performance improvements

**Examples:**
```
perf(api): optimize database queries
perf: reduce bundle size
perf(cache): improve cache hit rate
```

**When to use:**
- Performance optimizations
- Speed improvements
- Resource usage reductions

### `test`

**Purpose:** Adding or updating tests

**Examples:**
```
test(api): add unit tests for user endpoint
test: increase coverage to 90%
test(auth): add integration tests
```

**When to use:**
- Adding tests
- Updating test cases
- Test infrastructure changes

### `chore`

**Purpose:** Maintenance tasks, build config, dependencies

**Examples:**
```
chore: update dependencies
chore(build): configure CI pipeline
chore: update .gitignore
```

**When to use:**
- Build system changes
- Dependency updates
- Configuration changes
- Tooling updates

---

## Scope Guidelines

### When to Use Scope

**Use scope when:**
- Change affects specific component
- Multiple components exist
- Scope adds clarity
- Organization requires it

**Don't use scope when:**
- Change affects entire codebase
- Scope is unclear
- Single component project

### Common Scopes

**By Component:**
- `api` - API endpoints
- `auth` - Authentication
- `ui` - User interface
- `db` - Database
- `config` - Configuration

**By Layer:**
- `frontend` - Frontend code
- `backend` - Backend code
- `shared` - Shared code

**By Feature:**
- `user` - User management
- `payment` - Payment processing
- `notification` - Notifications

---

## Subject Guidelines

### Imperative Mood

**Correct:**
- "add feature"
- "fix bug"
- "update documentation"
- "refactor code"

**Incorrect:**
- "added feature"
- "fixed bug"
- "updates documentation"
- "refactoring code"

### Length

- **Maximum:** 50 characters
- **Target:** 30-40 characters
- **Why:** Git UI truncates at 50 chars

### Capitalization

- **First letter:** Capitalize
- **Rest:** Lowercase (unless proper noun)
- **No period:** At end of subject

**Examples:**
- ✅ "Add OAuth2 support"
- ✅ "Fix null pointer exception"
- ❌ "add oauth2 support" (should capitalize)
- ❌ "Fix null pointer exception." (no period)

---

## Body Guidelines

### When to Include Body

**Include body for:**
- Complex changes requiring explanation
- Breaking changes
- Context about why change was made
- Multiple related changes

**Skip body for:**
- Simple, self-explanatory changes
- Obvious fixes
- Trivial updates

### Formatting

- **Wrap at 72 characters**
- **Separate paragraphs with blank lines**
- **Use bullet points for lists**
- **Explain what and why**

**Example:**
```
feat(api): add pagination to user list endpoint

Implement cursor-based pagination to improve performance
for large user lists. This replaces offset-based pagination
which was causing performance issues with large datasets.

- Add cursor parameter to endpoint
- Update response to include next_cursor
- Maintain backward compatibility
```

---

## Footer Guidelines

### Breaking Changes

**Format:**
```
BREAKING CHANGE: <description>
```

**Example:**
```
feat(api): change user endpoint response format

BREAKING CHANGE: User endpoint now returns nested user object
instead of flat structure. Update clients to access user.name
instead of user_name.
```

### Issue References

**Format:**
```
Closes #123
Fixes #456
Refs #789
```

**Example:**
```
fix(api): resolve authentication token issue

Fixes #123
Closes #456
```

---

## Examples

### Simple Feature

```
feat(auth): add password reset functionality
```

### Feature with Body

```
feat(api): implement user search endpoint

Add new /users/search endpoint that supports filtering
by name, email, and role. Includes pagination support
and rate limiting.

Closes #123
```

### Bug Fix

```
fix(ui): correct button alignment on mobile devices

Button was misaligned on screens smaller than 768px.
Updated CSS to use flexbox for proper alignment.

Fixes #456
```

### Breaking Change

```
feat(api): change authentication token format

BREAKING CHANGE: Authentication tokens now use JWT format
instead of opaque strings. Clients must update to handle
JWT tokens and validate signatures.

Migration guide: docs/migration/jwt-tokens.md
```

### Documentation

```
docs: update API documentation

Add examples for all endpoints and update parameter
descriptions. Include error response formats.
```

### Refactor

```
refactor(api): extract authentication middleware

Move authentication logic from route handlers to
dedicated middleware. Improves code organization
and reusability.
```

### Performance

```
perf(db): optimize user query performance

Add database indexes on frequently queried columns.
Reduces query time from 500ms to 50ms for user lookups.
```

### Test

```
test(api): add integration tests for user endpoints

Increase test coverage from 60% to 85% for user API.
Includes tests for success and error cases.
```

### Chore

```
chore: update dependencies to latest versions

Update all npm packages to latest stable versions.
Resolves security vulnerabilities in lodash.
```

---

## Best Practices

### 1. Be Specific

**Good:**
```
fix(api): resolve null pointer in user endpoint
```

**Bad:**
```
fix: fix bug
```

### 2. Use Imperative Mood

**Good:**
```
feat: add user authentication
```

**Bad:**
```
feat: added user authentication
```

### 3. Keep Subject Concise

**Good:**
```
feat(auth): add OAuth2 support
```

**Bad:**
```
feat(auth): add OAuth2 support with Google and GitHub providers including token refresh
```

### 4. Explain Why in Body

**Good:**
```
refactor(api): extract authentication logic

Move authentication to middleware to improve code
organization and enable reuse across endpoints.
```

**Bad:**
```
refactor(api): extract authentication logic
```

### 5. Reference Issues

**Good:**
```
fix(ui): correct button alignment

Fixes #456
```

**Bad:**
```
fix(ui): correct button alignment
```

### 6. Use Appropriate Type

**Good:**
```
chore: update dependencies
```

**Bad:**
```
feat: update dependencies
```

---

## Common Mistakes

### Mistake 1: Wrong Type

**Wrong:**
```
feat: fix bug in authentication
```

**Correct:**
```
fix(auth): resolve authentication bug
```

### Mistake 2: Past Tense

**Wrong:**
```
feat: added new feature
```

**Correct:**
```
feat: add new feature
```

### Mistake 3: Too Long Subject

**Wrong:**
```
feat(api): implement comprehensive user search endpoint with filtering, pagination, and sorting capabilities
```

**Correct:**
```
feat(api): implement user search endpoint

Add filtering, pagination, and sorting capabilities
to user search functionality.
```

### Mistake 4: Missing Period in Body

**Wrong:**
```
feat(api): add endpoint

This adds a new endpoint.
```

**Correct:**
```
feat(api): add endpoint

This adds a new endpoint.
```

### Mistake 5: Period in Subject

**Wrong:**
```
feat(api): add new endpoint.
```

**Correct:**
```
feat(api): add new endpoint
```

---

## Validation Rules

### Required Checks

1. **Type exists:** Must be valid type (feat, fix, etc.)
2. **Subject length:** 50 characters or less
3. **Subject format:** Imperative mood, capitalized
4. **Body wrapping:** 72 characters per line
5. **Breaking change format:** If present, must follow format

### Automated Validation

Tools can validate:
- Commit message format
- Type correctness
- Subject length
- Body formatting
- Breaking change format

---

**Last Updated:** 2025-01-06

