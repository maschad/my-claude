# Semantic Search Best Practices

## Overview

This guide provides best practices for effectively using semantic search across credit documentation. Following these practices improves search quality, reduces time to find precedents, and ensures comprehensive research.

---

## Search Workflow

### 1. Start Broad, Then Refine

**Initial Exploration:**
```python
# Begin with broad query to understand domain
results = semantic_search_credit_documents(
    query_text="financial covenants in credit agreements",
    limit=20,
    min_similarity=0.6
)
```

**Refine Based on Findings:**
```python
# Use insights to craft more specific query
results = semantic_search_credit_documents(
    query_text="leverage ratio covenant with step-downs and equity cure",
    limit=10,
    min_similarity=0.65
)
```

**Final Extraction:**
```python
# Extract specific language with high precision
results = semantic_search_credit_documents(
    query_text="first lien leverage ratio maximum 5.0x quarterly step-downs",
    limit=5,
    min_similarity=0.7
)
```

### 2. Use Multiple Focused Queries

**Instead of one complex query:**
```python
# Too broad - will return mixed results
query = "financial covenants, pricing, fees, and security"
```

**Break into focused queries:**
```python
# Query 1: Financial covenants
covenants = semantic_search_credit_documents(
    query_text="financial covenants in healthcare credit agreements",
    limit=10
)

# Query 2: Pricing
pricing = semantic_search_credit_documents(
    query_text="pricing grids and interest rate spreads",
    limit=10
)

# Query 3: Fees
fees = semantic_search_credit_documents(
    query_text="upfront fees and commitment fees",
    limit=10
)

# Query 4: Security
security = semantic_search_credit_documents(
    query_text="security agreements and collateral packages",
    limit=10
)
```

### 3. Cross-Reference Results

**Validate Findings:**
- Confirm patterns across multiple documents
- Compare similar provisions
- Identify market-standard vs. unusual terms
- Verify consistency of interpretations

**Example:**
```python
# Find leverage covenant examples
leverage = semantic_search_credit_documents(
    query_text="leverage ratio covenant",
    limit=10
)

# Find EBITDA definitions
ebitda = semantic_search_credit_documents(
    query_text="EBITDA definition with add-backs",
    limit=10
)

# Cross-reference to understand how leverage is calculated
```

---

## Query Crafting

### Use Domain Terminology

**Credit-Specific Terms:**
- ✅ "leverage ratio" not "debt ratio"
- ✅ "EBITDA add-backs" not "earnings adjustments"
- ✅ "covenant basket" not "permitted exceptions"
- ✅ "credit agreement" not "loan contract"
- ✅ "security agreement" not "collateral document"

### Include Quantitative Details

**When Relevant:**
- "leverage ratio with 5.0x maximum"
- "commitment fees between 25-50bps"
- "minimum assignment amount of $5MM"
- "standstill period of 180 days"

### Combine Related Concepts

**Effective Combinations:**
- "financial covenants with leverage ratio and coverage ratio"
- "security agreement covering accounts receivable and inventory"
- "participation agreement with voting rights and confidentiality"

---

## Similarity Threshold Management

### Threshold Guidelines

**0.5-0.6: Broad Exploration**
- Initial research
- Discovering related concepts
- When terminology is uncertain

**0.6-0.7: Standard Research**
- Most common use case
- Good balance of relevance and coverage
- Default for precedent research

**0.7-0.8: Focused Search**
- Specific clause extraction
- High precision needed
- Known concept location

**0.8+: Very Specific**
- Near-exact matches only
- Specific language extraction
- Use sparingly

### Adjusting Thresholds

**Increase when:**
- Too many irrelevant results
- Need higher precision
- Searching for very specific concepts

**Decrease when:**
- Too few results
- Need broader coverage
- Exploring new concepts

---

## Result Interpretation

### Context Matters

**Read Surrounding Text:**
- Don't rely solely on matched snippet
- Review full context around match
- Understand clause relationships
- Check cross-references

### Multiple Sources

**Confirm Patterns:**
- Validate findings across multiple documents
- Compare similar provisions
- Identify consistent patterns
- Note exceptions and variations

### Temporal Considerations

**Market Evolution:**
- Consider document date
- Recognize market evolution
- Understand historical context
- Note when precedents may be outdated

### Customization vs. Standard

**Recognize Variations:**
- Distinguish borrower-specific terms
- Identify market-standard provisions
- Note negotiated exceptions
- Understand deal-specific structures

---

## Metadata Filtering

### Use Filters Strategically

**Company Filter:**
```python
# Find documents for specific company
results = semantic_search_credit_documents(
    query_text="credit agreement",
    company_id="c0e5f278-20bd-4eec-95e3-76877126b4c9",
    limit=10
)
```

**Deal Filter:**
```python
# Find all documents in specific deal
results = semantic_search_credit_documents(
    query_text="security agreement",
    deal_id="550e8400-e29b-41d4-a716-446655440000",
    limit=10
)
```

**Combined Filtering:**
```python
# Narrow scope with multiple filters
results = semantic_search_credit_documents(
    query_text="financial covenants",
    company_id="c0e5f278-20bd-4eec-95e3-76877126b4c9",
    deal_id="550e8400-e29b-41d4-a716-446655440000",
    limit=10
)
```

### When to Use Metadata Filters

**Use filters when:**
- Researching specific company or deal
- Comparing across similar deals
- Building company-specific precedent set
- Narrowing large result sets

**Don't use filters when:**
- Exploring market-wide patterns
- Building general precedent library
- Comparing across sectors
- Initial broad research

---

## Workflow Patterns

### Covenant Package Construction

**Step 1: Find Financial Covenants**
```python
financial = semantic_search_credit_documents(
    query_text="financial covenants including leverage ratio, coverage ratio, and liquidity test",
    limit=10,
    min_similarity=0.6
)
```

**Step 2: Find EBITDA Definitions**
```python
ebitda = semantic_search_credit_documents(
    query_text="EBITDA definition with add-backs for non-recurring charges",
    limit=5,
    min_similarity=0.7
)
```

**Step 3: Find Covenant Baskets**
```python
baskets = semantic_search_credit_documents(
    query_text="general debt baskets and grower baskets",
    limit=5,
    min_similarity=0.65
)
```

**Step 4: Find Cure Rights**
```python
cures = semantic_search_credit_documents(
    query_text="equity cure rights with limitations",
    limit=3,
    min_similarity=0.7
)
```

### Security Package Analysis

**Step 1: Review Security Structure**
```python
security = semantic_search_credit_documents(
    query_text="security agreement covering all assets",
    limit=5,
    min_similarity=0.6
)
```

**Step 2: Check Guarantees**
```python
guarantees = semantic_search_credit_documents(
    query_text="guarantee by subsidiaries with exceptions",
    limit=5,
    min_similarity=0.65
)
```

**Step 3: Review Perfection**
```python
perfection = semantic_search_credit_documents(
    query_text="UCC-1 filings and control agreements",
    limit=5,
    min_similarity=0.7
)
```

### Fee Benchmarking

**Step 1: Benchmark Upfront Fees**
```python
upfront = semantic_search_credit_documents(
    query_text="upfront fees for syndicated credit facility 50-100bps",
    limit=10,
    min_similarity=0.6
)
```

**Step 2: Review Commitment Fees**
```python
commitment = semantic_search_credit_documents(
    query_text="commitment fees on undrawn amounts",
    limit=5,
    min_similarity=0.65
)
```

---

## Common Pitfalls

### Pitfall 1: Overly Broad Queries

**Problem:** Query too generic, returns irrelevant results

**Solution:** Add specificity and domain terminology

### Pitfall 2: Ignoring Context

**Problem:** Relying only on matched snippet

**Solution:** Read surrounding text and full context

### Pitfall 3: Single Source Validation

**Problem:** Using only one precedent

**Solution:** Compare across multiple documents

### Pitfall 4: Wrong Threshold

**Problem:** Using default threshold for all queries

**Solution:** Adjust based on query specificity and results

### Pitfall 5: Not Using Filters

**Problem:** Overwhelming results when specific company/deal needed

**Solution:** Use metadata filters to narrow scope

---

## Integration Strategies

### With Knowledge Graph

**Combine Semantic Search with Graph Analysis:**
```python
# Step 1: Semantic search
covenant_docs = semantic_search_credit_documents(
    query_text="financial maintenance covenants",
    limit=20
)

# Step 2: Extract text
texts = [chunk['content'] for chunk in covenant_docs]

# Step 3: Build knowledge graph
from knowledge_graph_skill import analyze_text_network
graph = analyze_text_network(
    texts=texts,
    context_name="covenant_structures"
)

# Step 4: Identify gaps
gaps = detect_discourse_gaps(
    texts=texts,
    context_name="covenant_gaps"
)
```

### With SEC Intelligence

**Combine Document Search with Financial Data:**
```python
# Find credit agreement
agreements = semantic_search_credit_documents(
    query_text="credit agreement",
    company_id=company_uuid
)

# Get SEC financials
from sec_skill import get_sec_company_financials
financials = get_sec_company_financials(
    company_identifier="TICKER",
    metrics=["Assets", "Liabilities", "Revenue"]
)

# Compare covenant levels to actuals
```

---

## Quality Assurance

### Verify Results

**Check Relevance:**
- Are results actually relevant?
- Do they address the query?
- Is context appropriate?

**Validate Accuracy:**
- Cross-reference with source documents
- Verify interpretations
- Check for OCR errors

**Assess Completeness:**
- Are key precedents included?
- Is coverage comprehensive?
- Are important variations captured?

### Document Sources

**Track Precedent Sources:**
- Document which documents were used
- Note document types and dates
- Record company/deal information
- Maintain source citations

---

## Best Practices Summary

1. **Start Broad, Refine Gradually**: Begin with exploratory queries
2. **Use Multiple Queries**: Break complex research into focused queries
3. **Cross-Reference**: Validate findings across multiple sources
4. **Read Context**: Don't rely solely on matched snippets
5. **Adjust Thresholds**: Tune similarity based on results
6. **Use Filters**: Narrow scope with metadata when appropriate
7. **Document Sources**: Track precedent sources for later reference
8. **Validate Patterns**: Confirm findings across multiple documents
9. **Consider Evolution**: Recognize market changes over time
10. **Integrate Tools**: Combine with knowledge graph and SEC data

---

**Last Updated:** 2025-01-06

