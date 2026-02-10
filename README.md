# My Skills

Skills I use with Claude: commit workflow, CI validation, preflight checks, MCP server development, document semantic search, and knowledge-graph research.

---

## Preflight

Run before starting implementation.

- **Rust**: `cargo check`, fix errors first
- **Docker**: `docker compose ps`, confirm containers healthy
- **Env**: Check `.env` for whitespace/formatting
- **Deps**: List version-pinned deps (e.g. `Cargo.toml`), verify API compatibility
- Report status before implementing

**Location**: `skills/preflight/`

---

## Commit

Full commit flow: build, test, lint, format, then semantic commits.

- Detect repo type (Node, Python, Go, Rust, Java, etc.)
- Run build, tests, linters, formatters
- Create commits following [Conventional Commits](https://www.conventionalcommits.org/)
- Reference: quality checks, semantic commits, best practices

**Location**: `skills/commit/`  
**Use when**: Committing code; you want quality gates and consistent message format.

---

## CI Validation

Validate and debug CI/CD so pipelines pass.

- Detect platform (GitHub Actions, GitLab, CircleCI, Jenkins, Azure, Travis, Bitbucket)
- Validate config syntax (e.g. yamllint, circleci config validate)
- Run CI checks locally where possible
- Debug failures and suggest fixes

**Location**: `skills/ci-validation/`  
**Use when**: Validating pipelines, debugging CI failures, or before merging.

---

## MCP Builder

Build MCP (Model Context Protocol) servers for LLMs and external services.

- Research MCP spec and framework docs (TypeScript/Python)
- Design tools (naming, context, errors)
- Implement in TypeScript (recommended) or Python (FastMCP)
- Evaluate with the included framework

**Location**: `skills/mcp-builder/`  
**Use when**: Building MCP servers to integrate APIs or services.  
**Reference**: Best practices, Node/TS guide, Python guide, evaluation.

---

## Document Semantic Search

Natural-language search over document collections using vector embeddings.

- Query by meaning (clauses, covenants, terms, structures)
- Filter by metadata (company, deal, document)
- Supports credit docs (agreements, fee letters, security agreements, etc.) and general doc sets
- Tune similarity threshold and result count

**Location**: `skills/document-semantic-search/`  
**Use when**: Searching docs, researching precedents, extracting covenant/collateral structures.  
**Reference**: Query optimization, document preparation, best practices.

---

## Knowledge Graph Research

Turn document sets into knowledge graphs and analyze discourse.

- Build text networks (concepts + relationships)
- Find discourse gaps and bridge concepts
- Cluster concepts and themes
- Graph-RAG and DOT export for visualization

**Location**: `skills/knowledge-graph-research/`  
**Use when**: Deep analysis of docs, due diligence, investment theses, market synthesis.  
**Reference**: Document preparation, graph analysis, best practices.

---

## Install & Commands

```bash
make install   # Install skills to Claude skills directory
make uninstall # Remove installed skills
make check     # Verify setup and installed skills
make list      # List skills and descriptions
make update    # Reinstall (update)
make help      # Help
```

Details: [SETUP.md](./SETUP.md).

---

## Repo Layout

```text
├── README.md
├── SETUP.md
├── Makefile
├── template/
│   └── SKILL.md
└── skills/
    ├── preflight/
    ├── commit/
    ├── ci-validation/
    ├── mcp-builder/
    ├── document-semantic-search/
    └── knowledge-graph-research/
```

Each skill has `SKILL.md` (and usually `reference/` and `LICENSE.txt`).
