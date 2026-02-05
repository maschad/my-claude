// .claude/skills/preflight/SKILL.md
# Preflight Check
1. If Rust project: run `cargo check` and fix all errors before proceeding
2. If Docker involved: run `docker compose ps` and verify all containers are healthy
3. Check .env files for whitespace/formatting issues
4. List any version-pinned dependencies in Cargo.toml and verify API compatibility
5. Report status before starting implementation
