# Query Optimization Guide

## Overview

This guide provides detailed strategies for crafting effective semantic search queries across credit documentation. Well-optimized queries significantly improve search relevance and reduce the time needed to find relevant precedents.

---

## Core Principles

### 1. Specificity Over Generality

**Good queries are specific and use domain terminology:**
- ✅ "first lien leverage ratio covenant with 5.0x maximum and quarterly step-downs"
- ✅ "security agreement covering equipment and inventory with ABL borrowing base"
- ✅ "assignment and assumption with minimum $5MM assignment amount"
- ✅ "upfront fees between 50-100bps for syndicated credit facilities"

**Avoid overly broad or vague queries:**
- ❌ "covenants"
- ❌ "loan documents"
- ❌ "fees"
- ❌ "security"

### 2. Use Domain-Specific Terminology

Credit documentation has precise terminology. Use it:

**Covenant Terms:**
- "leverage ratio" not "debt ratio"
- "EBITDA add-backs" not "earnings adjustments"
- "covenant basket" not "permitted exceptions"
- "equity cure" not "cure mechanism"

**Document Types:**
- "credit agreement" not "loan contract"
- "security agreement" not "collateral document"
- "assignment and assumption" not "loan transfer"
- "participation agreement" not "loan participation"

**Structural Terms:**
- "first lien" not "senior debt"
- "revolving credit facility" not "credit line"
- "administrative agent" not "agent bank"

### 3. Include Quantitative Details

When relevant, include specific numbers or ranges:
- "leverage ratio with 5.0x maximum"
- "commitment fees between 25-50bps"
- "minimum assignment amount of $5MM"
- "standstill period of 180 days"

### 4. Combine Multiple Concepts

Effective queries often combine related concepts:
- "financial covenants with leverage ratio and coverage ratio"
- "security agreement covering accounts receivable and inventory"
- "participation agreement with voting rights and confidentiality"

---

## Similarity Threshold Guidelines

### Threshold Selection

**0.5-0.6: Broad Search**
- Use for exploratory research
- May include tangentially related content
- Good for discovering related concepts
- Use when you're unsure of exact terminology

**0.6-0.7: Balanced Search**
- Default for most research tasks
- Good balance of relevance and coverage
- Recommended for standard precedent research
- Works well for multi-concept queries

**0.7-0.8: Focused Search**
- High relevance expected
- Use when you know the exact concept
- Good for extracting specific clause language
- Recommended for final precedent extraction

**0.8+: Very Specific Search**
- Near-exact matches only
- Use for finding specific language
- May miss related variations
- Use sparingly for very precise needs

### Adjusting Thresholds

**Increase threshold (0.6 → 0.7) when:**
- Getting too many irrelevant results
- Need higher precision
- Searching for very specific concepts
- Results are too broad

**Decrease threshold (0.7 → 0.6) when:**
- Getting too few results
- Need broader coverage
- Exploring new concepts
- Initial search returns empty

---

## Result Limit Guidelines

### Limit Selection

**3-5 Results: Quick Reference**
- Specific precedent lookup
- Known document location
- Quick fact-checking
- Single clause extraction

**10-15 Results: Standard Research**
- Comprehensive coverage
- Building precedent set
- Comparing multiple examples
- Most common use case

**20+ Results: Exhaustive Search**
- Building precedent library
- Comprehensive market research
- Statistical analysis
- Complete document review

### When to Increase Limits

- Building comprehensive precedent sets
- Statistical analysis of market terms
- Comparing many examples
- Creating precedent libraries

### When to Decrease Limits

- Quick reference lookups
- Specific clause extraction
- Known document searches
- Context window constraints

---

## Multi-Query Strategies

### Breaking Complex Queries

**Instead of one complex query:**
```
"financial covenants, pricing, fees, and security for healthcare companies"
```

**Use multiple focused queries:**
```python
# Query 1: Financial covenants
query1 = "financial covenants in healthcare credit agreements"

# Query 2: Pricing structures
query2 = "pricing grids and interest rate spreads for healthcare borrowers"

# Query 3: Fee structures
query3 = "upfront fees and commitment fees in healthcare facilities"

# Query 4: Security packages
query4 = "security agreements and collateral packages for healthcare companies"
```

### Sequential Query Refinement

**Step 1: Broad exploration**
```python
# Start broad to understand the domain
results = semantic_search_credit_documents(
    query_text="financial covenants in credit agreements",
    limit=20,
    min_similarity=0.6
)
```

**Step 2: Refine based on findings**
```python
# Use insights from step 1 to refine
results = semantic_search_credit_documents(
    query_text="leverage ratio covenant with step-downs and equity cure",
    limit=10,
    min_similarity=0.7
)
```

**Step 3: Extract specific language**
```python
# Final extraction with high precision
results = semantic_search_credit_documents(
    query_text="first lien leverage ratio maximum 5.0x with quarterly step-downs to 4.5x",
    limit=5,
    min_similarity=0.75
)
```

---

## Query Patterns by Use Case

### Covenant Research

**Pattern: [Covenant Type] + [Test Type] + [Specific Details]**
```
"financial maintenance covenant with leverage ratio test"
"negative covenant restricting debt with permitted baskets"
"affirmative covenant requiring compliance certificates"
```

### Collateral Analysis

**Pattern: [Document Type] + [Asset Types] + [Structure]**
```
"security agreement covering accounts receivable and inventory"
"pledge agreement for equity interests with voting rights"
"control agreement for deposit accounts with blocked account"
```

### Fee Benchmarking

**Pattern: [Fee Type] + [Range/Amount] + [Context]**
```
"upfront fees between 50-100bps for syndicated facilities"
"commitment fees on undrawn amounts with utilization grid"
"administrative agent fees ranging from $25k to $50k annually"
```

### Amendment Research

**Pattern: [Amendment Type] + [Modified Terms] + [Context]**
```
"amendment modifying financial covenants with pricing adjustment"
"amendment suspending covenants with equity cure provisions"
"amendment extending maturity with consent fees"
```

---

## Common Query Mistakes

### Mistake 1: Too Generic
**Bad:** "covenants"
**Good:** "financial maintenance covenants with leverage ratio and coverage ratio tests"

### Mistake 2: Missing Context
**Bad:** "fees"
**Good:** "upfront fees and commitment fees for syndicated credit facilities"

### Mistake 3: Using Non-Standard Terms
**Bad:** "loan contract with debt restrictions"
**Good:** "credit agreement with negative covenants restricting debt"

### Mistake 4: Overly Complex Single Query
**Bad:** "financial covenants, pricing, fees, security, and guarantees for healthcare companies"
**Good:** Break into 5 separate focused queries

### Mistake 5: Ignoring Similarity Thresholds
**Bad:** Always using default 0.5
**Good:** Adjust based on query specificity and result quality

---

## Advanced Techniques

### Synonym Expansion

The embedding model handles synonyms, but you can be explicit:
- "borrower" or "obligor"
- "lender" or "bank" or "creditor"
- "guarantee" or "guaranty"

### Temporal Context

Include time-based context when relevant:
- "recent credit agreements" (though results depend on corpus)
- "amendment agreements from 2023"
- "pre-2020 covenant structures"

### Comparative Queries

Compare structures across documents:
- "leverage ratio covenants compared across healthcare and technology sectors"
- "fee structures in bilateral vs syndicated facilities"

### Exclusion Patterns

While not directly supported, you can refine queries:
- Instead of "covenants excluding financial covenants"
- Use "negative covenants and affirmative covenants"

---

## Query Testing Workflow

### 1. Start with Broad Query
```python
results = semantic_search_credit_documents(
    query_text="financial covenants",
    limit=10,
    min_similarity=0.6
)
```

### 2. Review Results
- Check relevance of top results
- Identify common patterns
- Note terminology used in results

### 3. Refine Query
```python
results = semantic_search_credit_documents(
    query_text="leverage ratio financial covenant with step-downs",
    limit=10,
    min_similarity=0.65
)
```

### 4. Adjust Threshold
- If too many irrelevant: increase threshold
- If too few results: decrease threshold

### 5. Extract Final Results
```python
results = semantic_search_credit_documents(
    query_text="first lien leverage ratio maximum 5.0x with quarterly step-downs",
    limit=5,
    min_similarity=0.7
)
```

---

## Best Practices Summary

1. **Be Specific**: Use precise domain terminology
2. **Include Details**: Add quantitative information when relevant
3. **Start Broad**: Begin with exploratory queries, then refine
4. **Use Multiple Queries**: Break complex research into focused queries
5. **Adjust Thresholds**: Tune similarity based on result quality
6. **Review Results**: Use initial results to improve subsequent queries
7. **Test Iteratively**: Refine queries based on what you learn
8. **Combine Concepts**: Link related concepts in single queries
9. **Use Metadata Filters**: Narrow scope with company_id or deal_id when available
10. **Document Successful Patterns**: Track what works for future reference

---

**Last Updated:** 2025-01-06

