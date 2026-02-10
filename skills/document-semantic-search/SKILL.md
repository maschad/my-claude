---
name: document-semantic-search
description: Semantic search across credit documentation using 4096-dimensional embeddings (Qwen3-Embedding-8B). Enables natural language queries to find relevant clauses, covenants, terms, and structures across assignments, credit agreements, fee letters, security agreements, and other credit documents. Use when searching credit documentation, researching precedents, extracting covenant structures, or analyzing collateral packages.
license: Complete terms in LICENSE.txt
---

# Document Semantic Search Skill

## Overview

This skill provides semantic search across credit documentation using 4096-dimensional embeddings (Qwen3-Embedding-8B). It enables natural language queries to find relevant clauses, covenants, terms, and structures across assignments, credit agreements, fee letters, security agreements, and other credit documents. The system understands document metadata (type, company, deal) and extracts structured information from complex legal documents.

---

# Process

## 🚀 High-Level Workflow

Using semantic search for credit documentation involves understanding the capabilities, crafting effective queries, and interpreting results:

### Phase 1: Understand Core Capabilities

#### 1.1 Semantic Document Search
- Natural language queries across credit document corpus
- 4096-dim vector embeddings for semantic similarity
- Configurable similarity thresholds and result limits
- Filtering by company, deal, or document metadata

#### 1.2 Document Type Recognition
Automatically identifies and categorizes:
- **Assignments**: Assignment and assumption agreements, novations
- **Covenant Documents**: Covenant categories, examples, precedents, compliance certificates
- **Credit Agreements**: Syndicated loans, bilateral facilities, revolving credit facilities, term loans
- **Collateral Documents**: Security agreements, pledge agreements, mortgages, UCC filings
- **Fee Letters**: Upfront fees, commitment fees, utilization fees, amendment fees
- **Legal Opinions**: Enforceability opinions, non-contravention opinions, bankruptcy opinions
- **Participations**: Risk participations, funded participations, sub-participations
- **Security Agreements**: General security agreements, intellectual property security, account control

#### 1.3 Covenant Extraction
Identifies and extracts:
- **Financial Covenants**: Leverage ratios, coverage ratios, liquidity tests, net worth requirements
- **Affirmative Covenants**: Reporting, compliance certificates, insurance, maintenance obligations
- **Negative Covenants**: Debt restrictions, lien limitations, dividend restrictions, M&A constraints
- **Covenant Baskets**: General baskets, grower baskets, starter baskets
- **EBITDA Adjustments**: Add-backs, pro forma adjustments, synergies, run-rate adjustments
- **Covenant Relief**: Amendment history, covenant suspension, equity cure rights

#### 1.4 Collateral Analysis
Extracts collateral information:
- **Collateral Types**: First lien, second lien, unsecured, ABL, cash flow
- **Asset Categories**: Equipment, inventory, receivables, real estate, intellectual property
- **Guarantees**: Parent guarantees, subsidiary guarantees, upstream/downstream/cross-stream
- **Perfection**: UCC filings, control agreements, mortgages, trademark/patent assignments
- **Release Provisions**: Release conditions, automatic releases, partial releases
- **Intercreditor Terms**: Priority, payment waterfalls, standstill provisions

#### 1.5 Metadata Extraction
Identifies key document attributes:
- **Parties**: Borrowers, lenders, agents, arrangers, guarantors
- **Deal Structure**: Facility types, tranches, commitments, maturities
- **Pricing**: Base rates, spreads, floors, grids, fee structures
- **Dates**: Closing date, maturity date, commitment termination, amendment dates
- **Governing Law**: Jurisdiction, venue, waiver of jury trial
- **Cross-References**: Related documents, incorporated terms, exhibit references

---

### Phase 2: Craft Effective Queries

**Load [📋 Query Optimization Guide](./reference/query_optimization.md) for comprehensive query crafting strategies.**

#### 2.1 Query Optimization Techniques

**Effective Queries:**
- ✅ "first lien leverage ratio covenant with 5.0x maximum and quarterly step-downs"
- ✅ "security agreement covering equipment and inventory with ABL borrowing base"
- ✅ "assignment and assumption with minimum $5MM assignment amount"
- ✅ "upfront fees between 50-100bps for syndicated credit facilities"

**Avoid overly broad or vague queries:**
- ❌ "covenants"
- ❌ "loan documents"
- ❌ "fees"

#### 2.2 Similarity Thresholds
- **0.5-0.6**: Broad search, may include tangentially related content
- **0.6-0.7**: Balanced search, good for exploratory research
- **0.7-0.8**: Focused search, high relevance expected
- **0.8+**: Very specific search, near-exact matches

#### 2.3 Result Limits
- **3-5 results**: Quick reference, specific precedent lookup
- **10-15 results**: Standard research, comprehensive coverage
- **20+ results**: Exhaustive search, building precedent library

#### 2.4 Multi-Query Strategies
Break complex research into focused queries:
```python
# Instead of:
"financial covenants, pricing, fees, and security for healthcare companies"

# Use multiple focused queries:
query1 = "financial covenants in healthcare credit agreements"
query2 = "pricing grids and interest rate spreads for healthcare borrowers"
query3 = "upfront fees and commitment fees in healthcare facilities"
query4 = "security agreements and collateral packages for healthcare companies"
```

---

### Phase 3: Execute Common Workflows

#### 3.1 Covenant Precedent Research

**Scenario:** Need to draft financial covenant package for healthcare borrower

**Workflow:**
```python
# Step 1: Find financial covenant examples
financial = semantic_search_credit_documents(
    query_text="financial covenants including leverage ratio, coverage ratio, and liquidity test",
    limit=10,
    min_similarity=0.6
)

# Step 2: Find EBITDA definition precedents
ebitda = semantic_search_credit_documents(
    query_text="EBITDA definition with add-backs for non-recurring charges and pro forma adjustments",
    limit=5,
    min_similarity=0.7
)

# Step 3: Find covenant basket structures
baskets = semantic_search_credit_documents(
    query_text="general debt baskets and grower baskets with builder mechanisms",
    limit=5,
    min_similarity=0.65
)

# Step 4: Find cure right provisions
cures = semantic_search_credit_documents(
    query_text="equity cure rights with limitations on frequency and amount",
    limit=3,
    min_similarity=0.7
)
```

#### 3.2 Collateral Package Analysis

**Scenario:** Evaluating security package for manufacturing company

**Workflow:**
```python
# Step 1: Review security agreement structure
security = semantic_search_credit_documents(
    query_text="security agreement covering all assets with standard exclusions",
    limit=5,
    min_similarity=0.6
)

# Step 2: Check guarantee requirements
guarantees = semantic_search_credit_documents(
    query_text="guarantee by subsidiaries with exceptions for immaterial subs and foreign subs",
    limit=5,
    min_similarity=0.65
)

# Step 3: Review perfection requirements
perfection = semantic_search_credit_documents(
    query_text="UCC-1 filings and control agreements for deposit accounts",
    limit=5,
    min_similarity=0.7
)

# Step 4: Check release provisions
releases = semantic_search_credit_documents(
    query_text="collateral release upon achievement of leverage ratio or investment grade rating",
    limit=3,
    min_similarity=0.7
)
```

#### 3.3 Fee Structure Benchmarking

**Scenario:** Negotiating fee letter for syndicated facility

**Workflow:**
```python
# Step 1: Benchmark upfront fees
upfront = semantic_search_credit_documents(
    query_text="upfront fees for syndicated credit facility with 50bps to 100bps range",
    limit=10,
    min_similarity=0.6
)

# Step 2: Review commitment fee structures
commitment = semantic_search_credit_documents(
    query_text="commitment fees on undrawn amounts with utilization grid",
    limit=5,
    min_similarity=0.65
)

# Step 3: Find amendment fee precedents
amendments = semantic_search_credit_documents(
    query_text="consent fees for amendments ranging from 10bps to 25bps",
    limit=5,
    min_similarity=0.6
)

# Step 4: Check administrative agent fees
admin_fees = semantic_search_credit_documents(
    query_text="administrative agent fees and fronting fees for letters of credit",
    limit=5,
    min_similarity=0.65
)
```

#### 3.4 Legal Opinion Requirements

**Scenario:** Determining scope of legal opinions needed

**Workflow:**
1. Query: "legal opinion requirements in credit agreements with enforceability and non-contravention"
2. Review standard opinion deliverables
3. Identify customary assumptions and qualifications
4. Compare opinion scope across jurisdictions
5. Extract specific opinion language and riders

#### 3.5 Amendment Precedents

**Scenario:** Negotiating covenant modification

**Workflow:**
1. Query: "amendment agreements modifying financial covenants with pricing adjustments"
2. Review typical amendment structures
3. Compare consent fee levels
4. Identify negotiated covenant relief mechanisms
5. Extract amendment execution provisions

#### 3.6 Participation Structures

**Scenario:** Structuring risk participation agreement

**Workflow:**
```python
# Step 1: Review assignment mechanics
assignments = semantic_search_credit_documents(
    query_text="assignment and assumption agreement with minimum assignment amounts and consent requirements",
    limit=5,
    min_similarity=0.7
)

# Step 2: Compare participation structures
participations = semantic_search_credit_documents(
    query_text="participation agreement with voting rights restrictions and confidentiality obligations",
    limit=5,
    min_similarity=0.7
)

# Step 3: Check information rights
info_rights = semantic_search_credit_documents(
    query_text="information rights for participants versus assignees with sharing restrictions",
    limit=3,
    min_similarity=0.7
)
```

#### 3.7 Intercreditor Research

**Scenario:** Analyzing intercreditor relationships

**Workflow:**
```python
# Step 1: Find intercreditor agreement templates
intercreditor = semantic_search_credit_documents(
    query_text="intercreditor agreement between first lien and second lien lenders with payment waterfall",
    limit=5,
    min_similarity=0.7
)

# Step 2: Review standstill provisions
standstill = semantic_search_credit_documents(
    query_text="standstill period for junior lenders with 180 day restriction on enforcement",
    limit=3,
    min_similarity=0.7
)

# Step 3: Check lien priorities
priorities = semantic_search_credit_documents(
    query_text="lien priority and subordination terms with automatic release provisions",
    limit=5,
    min_similarity=0.65
)
```

---

### Phase 4: Interpret and Apply Results

#### 4.1 Result Interpretation Best Practices
- **Context Matters**: Read surrounding text, not just matched snippet
- **Multiple Sources**: Confirm patterns across multiple documents
- **Evolution**: Consider date of precedent and market evolution
- **Customization**: Recognize borrower-specific vs. market-standard terms

#### 4.2 Search Workflow
1. **Start Broad**: Begin with higher-level queries to scope the domain
2. **Refine Focus**: Use initial results to craft more specific queries
3. **Cross-Reference**: Validate findings across multiple documents
4. **Extract and Compare**: Pull specific clauses for side-by-side comparison
5. **Document Sources**: Track precedent sources for later reference

#### 4.3 Troubleshooting

**Low-Quality Results:**
- Increase `min_similarity` threshold (try 0.7+)
- Make query more specific with technical terms
- Use metadata filters to narrow scope
- Break complex query into focused sub-queries

**No Results Found:**
- Decrease `min_similarity` threshold (try 0.5)
- Broaden query with more general terms
- Check if documents exist for that category
- Verify metadata filters aren't too restrictive

**Too Many Results:**
- Increase `min_similarity` to filter lower-quality matches
- Add more specificity to query
- Use metadata filters (company, deal, document type)
- Reduce `limit` parameter

**Inconsistent Results:**
- Embedding search is probabilistic, slight variations expected
- Use consistent terminology across queries
- Review and improve source document quality
- Consider metadata filtering for deterministic results

---

# Reference

## Key Functions

### `semantic_search_credit_documents(query_text, limit, min_similarity, company_id, deal_id)`
**Purpose:** Natural language search across credit document embeddings

**Parameters:**
- `query_text`: Natural language query (e.g., "leverage covenant with step-downs")
- `limit`: Maximum results to return (default: 10)
- `min_similarity`: Similarity threshold 0-1 (default: 0.5)
- `company_id`: Optional UUID to filter by company
- `deal_id`: Optional UUID to filter by deal

**Returns:**
- Document chunks with similarity scores
- Full context around matched text
- Metadata (document type, company, deal)
- Source document identifiers

**Example:**
```python
# Find leverage covenant examples
results = semantic_search_credit_documents(
    query_text="first lien leverage ratio covenant with 5.0x maximum and quarterly step-downs",
    limit=5,
    min_similarity=0.7
)

# Results include:
# - Matched text with surrounding context
# - Similarity scores (0.7-1.0)
# - Document type (credit_agreement, covenant_example)
# - Company and deal identifiers
# - Chunk position in source document
```

### `search_credit_documents_by_metadata(company_id, deal_id, document_id, limit)`
**Purpose:** Filter documents by metadata without semantic search

**Parameters:**
- `company_id`: Company UUID (optional)
- `deal_id`: Deal UUID (optional)
- `document_id`: Document UUID (optional)
- `limit`: Maximum results (default: 20)

**Returns:**
- All chunks matching metadata filters
- Useful for retrieving complete documents
- No similarity scoring

**Example:**
```python
# Get all documents for a specific deal
deal_docs = search_credit_documents_by_metadata(
    deal_id="550e8400-e29b-41d4-a716-446655440000",
    limit=100
)

# Get all documents for a specific company
company_docs = search_credit_documents_by_metadata(
    company_id="c0e5f278-20bd-4eec-95e3-76877126b4c9",
    limit=50
)

# Get specific document
doc = search_credit_documents_by_metadata(
    document_id="7f3d8f29-1b4e-4c8a-9a2e-5e6f7a8b9c0d"
)
```

### `search_arda_knowledge(query, node_types, limit, min_similarity)`
**Purpose:** Search Arda's internal knowledge base (211 markdown documents)

**Parameters:**
- `query`: Natural language query
- `node_types`: Filter by ["concept", "section", "document", "entity"]
- `limit`: Maximum results (default: 10)
- `min_similarity`: Similarity threshold (default: 0.6)

**Returns:**
- Relevant knowledge base content
- Arda product documentation
- Process guides and best practices
- Team information and responsibilities

**Example:**
```python
# Search Arda product documentation
results = search_arda_knowledge(
    query="How does Arda Execute handle settlement workflows?",
    node_types=["concept", "section"],
    limit=5,
    min_similarity=0.7
)

# Find team responsibilities
team_info = search_arda_knowledge(
    query="Who is responsible for covenant monitoring?",
    limit=3
)
```

### `get_arda_document(file_path)`
**Purpose:** Retrieve specific Arda documentation by path

**Parameters:**
- `file_path`: Document path (e.g., "Arda Global HQ/Product/Execute/Overview.md")

**Returns:**
- Full document content
- Document metadata
- Category and structure information

**Example:**
```python
# Get specific product documentation
doc = get_arda_document(
    "Arda Global HQ/Product/Execute/Overview.md"
)

# Get technical specifications
tech_doc = get_arda_document(
    "Arda Global HQ/Technical/API/Authentication.md"
)
```

### `list_arda_documents(category, limit)`
**Purpose:** Browse Arda documentation by category

**Parameters:**
- `category`: Filter by category ("Product", "Team", "Technical", etc.)
- `limit`: Maximum results (default: 50)

**Returns:**
- List of available documents
- Document titles and paths
- Category organization

**Example:**
```python
# List all product documentation
product_docs = list_arda_documents(
    category="Product",
    limit=20
)

# List all documents
all_docs = list_arda_documents()
```

### `get_document_embeddings_stats()`
**Purpose:** Get statistics about document embedding collection

**Parameters:** None

**Returns:**
- Total number of documents
- Vector dimensions (4096)
- Collection metadata
- Sample data structure

**Example:**
```python
# Check corpus statistics
stats = get_document_embeddings_stats()

# Returns:
# {
#   "total_documents": 1247,
#   "vector_dimensions": 4096,
#   "embedding_model": "Qwen3-Embedding-8B",
#   "sample_structure": {...}
# }
```

---

## Document Type Metadata Schema

### Assignment Documents
```json
{
  "document_type": "assignment",
  "assignment_type": "assignment_and_assumption",
  "parties": {
    "assignor": "Original Lender",
    "assignee": "New Lender",
    "borrower": "Company Name",
    "administrative_agent": "Agent Bank"
  },
  "assignment_amount": 5000000,
  "purchase_price": 4950000,
  "effective_date": "2024-03-15",
  "consent_required": true
}
```

### Credit Agreement
```json
{
  "document_type": "credit_agreement",
  "agreement_type": "syndicated_credit_facility",
  "borrower": "Company Name",
  "facilities": [
    {
      "type": "revolving",
      "commitment": 100000000,
      "maturity": "2029-03-15"
    },
    {
      "type": "term_loan",
      "principal": 200000000,
      "maturity": "2030-03-15"
    }
  ],
  "financial_covenants": ["leverage_ratio", "coverage_ratio"],
  "governing_law": "New York"
}
```

### Security Agreement
```json
{
  "document_type": "security_agreement",
  "security_type": "general_security_agreement",
  "grantor": "Company Name",
  "secured_party": "Administrative Agent",
  "collateral_types": [
    "equipment",
    "inventory",
    "accounts_receivable",
    "intellectual_property"
  ],
  "lien_priority": "first_lien",
  "perfection_method": ["ucc_filing", "control_agreement"]
}
```

### Fee Letter
```json
{
  "document_type": "fee_letter",
  "borrower": "Company Name",
  "administrative_agent": "Agent Bank",
  "fees": {
    "upfront_fee": {
      "amount_bps": 75,
      "calculation_base": "total_commitments"
    },
    "commitment_fee": {
      "amount_bps": 30,
      "calculation_base": "undrawn_commitments"
    },
    "administrative_agent_fee": {
      "amount": 50000,
      "frequency": "annual"
    }
  }
}
```

### Covenant Document
```json
{
  "document_type": "covenant_category",
  "covenant_type": "financial_covenant",
  "covenant_name": "first_lien_leverage_ratio",
  "test_type": "maintenance",
  "test_frequency": "quarterly",
  "maximum_ratio": 5.0,
  "step_downs": [
    {"date": "2025-12-31", "ratio": 4.75},
    {"date": "2026-12-31", "ratio": 4.50}
  ],
  "cure_rights": true
}
```

---

## Covenant Taxonomy

### Financial Covenants

#### Leverage Ratios
- **Total Leverage**: Total Debt / EBITDA
- **First Lien Leverage**: First Lien Debt / EBITDA
- **Senior Secured Leverage**: Senior Secured Debt / EBITDA
- **Net Leverage**: (Total Debt - Unrestricted Cash) / EBITDA
- **Secured Leverage**: Secured Debt / EBITDA

#### Coverage Ratios
- **Interest Coverage**: EBITDA / Interest Expense
- **Fixed Charge Coverage**: (EBITDA - CapEx - Taxes) / (Interest + Scheduled Principal)
- **Debt Service Coverage**: (EBITDA - CapEx) / (Interest + Principal)

#### Liquidity Tests
- **Minimum Liquidity**: Cash + Revolver Availability ≥ Threshold
- **Minimum EBITDA**: EBITDA ≥ Threshold
- **Minimum Revenue**: Revenue ≥ Threshold

#### Balance Sheet Tests
- **Minimum Net Worth**: Tangible Net Worth ≥ Threshold
- **Maximum CapEx**: Capital Expenditures ≤ Threshold
- **Minimum Current Ratio**: Current Assets / Current Liabilities ≥ Threshold

### Negative Covenants

#### Debt Restrictions
- **Maximum Total Debt**: Cap on aggregate indebtedness
- **Debt Baskets**: Permitted debt categories and amounts
- **Ratio-Based Debt**: Incurrence-based debt tied to leverage ratios
- **Grower Baskets**: Baskets that increase over time

#### Lien Restrictions
- **Negative Pledge**: General prohibition on liens
- **Permitted Liens**: Specific lien categories allowed
- **Equal and Ratable**: Requirement to share security

#### Restricted Payments
- **Dividend Restrictions**: Limitations on dividends and distributions
- **Ratio-Based Payments**: Payments tied to leverage tests
- **Builder Baskets**: Baskets built from retained cash flow

#### M&A Restrictions
- **Acquisition Limitations**: Caps on acquisition spending
- **Asset Sale Restrictions**: Limitations on dispositions
- **Permitted Acquisitions**: Specific acquisition criteria

### Affirmative Covenants
- **Financial Reporting**: Quarterly/annual financials, compliance certificates
- **Notice Requirements**: Event of default notices, material change notices
- **Insurance**: Property, liability, business interruption coverage
- **Maintenance**: Property maintenance, corporate existence
- **Compliance**: Legal compliance, environmental compliance

---

## Collateral Type Taxonomy

### Asset-Based Collateral
- **Accounts Receivable**: Trade receivables, contract rights
- **Inventory**: Raw materials, work-in-process, finished goods
- **Equipment**: Machinery, vehicles, furniture, fixtures
- **Real Estate**: Owned properties, leasehold interests

### Cash Flow Collateral
- **All Assets**: Blanket lien on all present and future assets
- **Intellectual Property**: Patents, trademarks, copyrights, trade secrets
- **Equity Interests**: Stock pledges, membership interests
- **Contract Rights**: Material contracts, licenses

### Perfection Methods
- **UCC-1 Filings**: State-level financing statements
- **Control Agreements**: Deposit accounts, securities accounts
- **Mortgages**: Real property liens
- **IP Assignments**: USPTO, Copyright Office recordings
- **Stock Pledges**: Certificated and uncertificated securities

---

## Output Structure

### Semantic Search Results
```json
{
  "results": [
    {
      "chunk_id": "uuid",
      "content": "Section 7.11 Financial Covenants. The Borrower shall not permit...",
      "similarity_score": 0.83,
      "metadata": {
        "document_id": "uuid",
        "document_type": "credit_agreement",
        "company_id": "uuid",
        "company_name": "Healthcare Corp",
        "deal_id": "uuid",
        "deal_name": "2024 Refinancing",
        "chunk_position": 142,
        "total_chunks": 250
      },
      "context": {
        "preceding_text": "...",
        "following_text": "..."
      }
    }
  ],
  "query": "financial covenants with leverage ratio",
  "total_results": 15,
  "search_time_ms": 45
}
```

### Metadata Search Results
```json
{
  "results": [
    {
      "chunk_id": "uuid",
      "content": "Full chunk text...",
      "metadata": {
        "document_id": "uuid",
        "document_type": "security_agreement",
        "company_id": "uuid",
        "deal_id": "uuid",
        "chunk_position": 23,
        "total_chunks": 89
      }
    }
  ],
  "filters_applied": {
    "company_id": "c0e5f278-20bd-4eec-95e3-76877126b4c9",
    "deal_id": null,
    "document_id": null
  },
  "total_results": 89
}
```

---

## Integration with Other Skills

### With Knowledge Graph Research
```python
# Step 1: Semantic search for covenant precedents
covenant_docs = semantic_search_credit_documents(
    query_text="financial maintenance covenants",
    limit=20
)

# Step 2: Extract text from results
texts = [chunk['content'] for chunk in covenant_docs]

# Step 3: Build knowledge graph
from knowledge_graph_skill import analyze_text_network
graph = analyze_text_network(
    texts=texts,
    context_name="covenant_structures"
)

# Step 4: Identify gaps in covenant coverage
gaps = detect_discourse_gaps(
    texts=texts,
    context_name="covenant_gaps"
)
```

### With SEC Intelligence
```python
# Find credit agreement for a company
agreements = semantic_search_credit_documents(
    query_text="credit agreement",
    company_id=company_uuid
)

# Get SEC financials for the same company
from sec_skill import get_sec_company_financials
financials = get_sec_company_financials(
    company_identifier="TICKER",
    metrics=["Assets", "Liabilities", "Revenue"]
)

# Compare covenant levels to actual financials
```

### With Counterparty Network
```python
# Find participation agreements
participations = semantic_search_credit_documents(
    query_text="participation agreement with risk participation structure"
)

# Map counterparty relationships
from counterparty_skill import create_company_exposure
# Create exposure relationships based on participation agreements
```

---

## Advanced Features

### Fuzzy Matching
The embedding model handles variations:
- "leverage ratio" matches "total leverage ratio", "consolidated leverage ratio"
- "EBITDA" matches "Adjusted EBITDA", "Consolidated EBITDA"
- Handles synonyms: "borrower" and "obligor", "lender" and "bank"

### Contextual Understanding
Queries understand context and relationships:
- "springing covenant" → understands it applies only when revolver is drawn
- "equity cure" → understands relationship to covenant defaults
- "grower basket" → understands builder/growth mechanisms

### Multi-Lingual Support
While primary corpus is English, the embedding model can handle:
- Latin legal phrases (in pari passu, pari passu, pro rata)
- Financial acronyms (EBITDA, CapEx, GAAP, IFRS)
- Cross-border terminology

---

## Limitations & Considerations

### Embedding Limitations
- 4096-dim embeddings are high-quality but not perfect
- Very rare or highly technical terms may not embed well
- OCR errors in source documents affect search quality
- Context window of embedding model affects very long passages

### Metadata Dependency
- Search quality depends on accurate document tagging
- Missing or incorrect metadata limits filtering effectiveness
- Company/deal linkage requires proper UUID assignment

### Legal Considerations
- Semantic search finds similar language, not legal advice
- Always review full document context and cross-references
- Consult legal counsel for interpretation and application
- Precedents may not be appropriate for specific situations

### Corpus Coverage
- Results limited to documents in the corpus
- New or innovative structures may have limited precedents
- Market evolution means older precedents may be outdated
- Geographic/jurisdictional coverage varies

---

## Best Practices

### Document Preparation
When adding documents to the corpus:
- Use clean, OCR-corrected text
- Preserve structural formatting (headings, sections)
- Include complete documents, not excerpts
- Tag with accurate metadata (company, deal, document type)
- Chunk at logical boundaries (sections, articles, clauses)

### Metadata Consistency
Maintain consistent metadata across documents:
- **Document Types**: Use standardized taxonomy
- **Company IDs**: Link to knowledge graph entities
- **Deal IDs**: Track related documents by transaction
- **Dates**: Capture execution date, effective date, maturity

---

## Future Enhancements

### Planned Features
- Named entity extraction for parties, dates, amounts
- Automatic covenant categorization and tagging
- Cross-document comparison and diff generation
- Temporal analysis of covenant evolution
- Automated precedent summarization

### Integration Roadmap
- Direct SurrealDB storage of document relationships
- Real-time document ingestion and embedding
- Hybrid search (semantic + keyword + metadata)
- Custom embedding fine-tuning for legal documents
- Multi-modal search (text + tabular data)

---

# Reference Files

## 📚 Documentation Library

Load these resources as needed during semantic search operations:

### Core Guides (Load First)
- [📋 Query Optimization Guide](./reference/query_optimization.md) - Comprehensive guide on crafting effective semantic search queries including:
  - Query specificity and domain terminology
  - Similarity threshold selection
  - Multi-query strategies
  - Common query patterns by use case
  - Advanced query techniques

- [📄 Document Preparation Guide](./reference/document_preparation.md) - Best practices for preparing credit documents for semantic search including:
  - Document quality requirements
  - Metadata tagging standards
  - Document chunking strategies
  - Quality control checklists
  - Common issues and solutions

- [✅ Best Practices Guide](./reference/best_practices.md) - Complete best practices for using semantic search including:
  - Search workflow patterns
  - Result interpretation guidelines
  - Metadata filtering strategies
  - Integration with other skills
  - Quality assurance techniques

---

**Skill Version:** 1.0
**Last Updated:** 2025-01-06
**Maintained By:** Arda Insights Team
**Dependencies:** IRL Vector DB (Qwen3-Embedding-8B), ONTO-RA, arda-insights MCP server
**Embedding Model:** Qwen3-Embedding-8B (4096 dimensions)
**Vector Database:** IRL (Integration Ready Layer)
