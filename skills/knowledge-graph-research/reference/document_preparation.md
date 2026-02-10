# Document Preparation Guide

## Overview

This guide covers best practices for preparing documents for knowledge graph analysis. Proper document preparation significantly improves graph quality, cluster coherence, and gap detection accuracy.

---

## Document Selection

### Include Context-Rich Documents

**Credit Documentation:**
- Credit agreements and amendments
- Security agreements
- Intercreditor agreements
- Fee letters
- Assignment and assumption agreements
- Participation agreements

**Market Intelligence:**
- Research reports and market commentary
- Earnings call transcripts
- Industry analysis reports
- Regulatory filings (10-K, 10-Q risk factors)

**Internal Analysis:**
- Internal memos and analysis
- Due diligence reports
- Investment committee materials
- Risk assessments

### Mix Document Types

**Combine Different Perspectives:**
- Internal vs. external analysis
- Buy-side vs. sell-side research
- Legal vs. financial perspectives
- Historical vs. current documents

**Include Multiple Time Periods:**
- Track thematic evolution over time
- Identify emerging vs. declining themes
- Compare discourse structure across periods
- Enable longitudinal analysis

**Balance Depth and Breadth:**
- Include both detailed and summary documents
- Mix comprehensive and focused analyses
- Combine broad market commentary with specific deal analysis

---

## Text Quality Requirements

### Clean, Well-Formatted Text

**OCR Quality:**
- Use OCR-corrected text when needed
- Fix character recognition errors
- Ensure proper encoding (UTF-8)
- Verify special characters are correct

**Formatting:**
- Preserve meaningful structure (headings, sections)
- Remove excessive formatting artifacts
- Maintain paragraph structure
- Keep list formatting where relevant

**Boilerplate Handling:**
- Remove excessive legal boilerplate if it dominates
- Preserve substantive content
- Balance between filtering and preserving context
- Consider document type when deciding what to filter

### Document Length Considerations

**Optimal Length:**
- Target: 500-5000 words per document
- Very long documents (>10,000 words) may need chunking
- Very short documents (<200 words) may not generate meaningful graphs
- Balance between detail and manageability

**Chunking Strategy:**
- Chunk at logical boundaries (sections, articles)
- Preserve context around key concepts
- Maintain document metadata
- Consider document type when chunking

---

## Context Naming Strategy

### Naming Conventions

**Use Descriptive, Structured Names:**
- Include date/version for tracking evolution
- Include document type or analysis focus
- Use consistent naming patterns
- Enable easy organization and retrieval

**Examples:**
- `bsl_covenants_q4_2024`
- `healthcare_risk_analysis_2024`
- `syndicated_loan_covenants_q4_2024`
- `market_sentiment_weekly_2024_01`
- `comprehensive_deal_structure_2024`

### Naming Patterns

**Format: `{domain}_{focus}_{timeframe}_{version}`**

**Components:**
- `domain`: Sector, market, or document type (e.g., `bsl`, `healthcare`, `covenants`)
- `focus`: Analysis focus (e.g., `risk`, `covenants`, `pricing`)
- `timeframe`: Time period (e.g., `q4_2024`, `2024_01`, `weekly_2024`)
- `version`: Optional version identifier

**Benefits:**
- Easy to track evolution over time
- Enables comparison across periods
- Organizes multiple analyses
- Supports longitudinal tracking

---

## Multi-Source Synthesis

### Combining Document Types

**Internal + External:**
```python
# Mix internal analysis with external research
all_sources = internal_memos + sell_side_research + news_articles

comprehensive_graph = analyze_text_network(
    texts=all_sources,
    context_name="multi_source_synthesis"
)
```

**Legal + Financial:**
- Combine credit agreements with financial analysis
- Mix covenant documentation with market commentary
- Include both structured and unstructured content

**Historical + Current:**
- Track thematic evolution
- Compare discourse structure across time
- Identify emerging vs. declining themes

### Synthesis Best Practices

**Balance Sources:**
- Don't let one source type dominate
- Ensure diverse perspectives
- Include both detailed and summary documents
- Mix comprehensive and focused analyses

**Maintain Context:**
- Preserve source metadata when possible
- Track which documents contribute to which clusters
- Enable source attribution in results

---

## Quality Control

### Pre-Analysis Checklist

**Document Quality:**
- [ ] Text is clean and OCR-corrected
- [ ] Special characters are correct
- [ ] Encoding is UTF-8
- [ ] No corrupted text

**Content Quality:**
- [ ] Documents are context-rich (not just raw data)
- [ ] Sufficient length for meaningful analysis
- [ ] Mix of document types included
- [ ] Multiple perspectives represented

**Naming:**
- [ ] Context names are descriptive
- [ ] Names follow consistent pattern
- [ ] Include date/version for tracking
- [ ] Names enable easy organization

### Post-Analysis Verification

**Graph Quality:**
- Check modularity scores (should be 0.3-0.5 ideally)
- Verify clusters are interpretable
- Confirm bridge concepts are meaningful
- Validate gap analysis makes sense

**Source Attribution:**
- Track which documents contribute to clusters
- Verify source diversity in results
- Check for source bias in graph structure

---

## Common Issues and Solutions

### Issue 1: Boilerplate Dominance

**Problem:** Legal boilerplate dominates graph, obscuring substantive content

**Solution:**
- Filter excessive boilerplate
- Focus on substantive sections
- Consider document type when filtering
- Balance between filtering and preserving context

### Issue 2: Insufficient Context

**Problem:** Documents lack context, resulting in sparse graphs

**Solution:**
- Include context-rich documents
- Add explanatory text where needed
- Combine with related documents
- Ensure sufficient document length

### Issue 3: Source Bias

**Problem:** One source type dominates the graph

**Solution:**
- Balance source types
- Include diverse perspectives
- Mix internal and external sources
- Ensure representation across document types

### Issue 4: Fragmented Results

**Problem:** Many tiny clusters, no clear structure

**Solution:**
- Increase document length
- Include more context-rich documents
- Reduce number of very short documents
- Focus on coherent document sets

### Issue 5: Overly Dense Graphs

**Problem:** Graph is too dense, difficult to interpret

**Solution:**
- Use entity-only extraction for overview
- Focus on specific document subsets
- Increase min_cluster_size parameter
- Consider chunking very long documents

---

## Document Type-Specific Guidelines

### Credit Agreements

**Key Sections:**
- Financial covenants
- Negative covenants
- Affirmative covenants
- Defined terms
- Pricing and fees

**Preparation:**
- Preserve section structure
- Include defined terms context
- Maintain cross-references
- Keep related provisions together

### Research Reports

**Key Sections:**
- Executive summary
- Market analysis
- Risk factors
- Investment thesis
- Recommendations

**Preparation:**
- Include full report text
- Preserve section structure
- Maintain context around key themes
- Keep related analysis together

### Earnings Call Transcripts

**Key Sections:**
- Management discussion
- Q&A sections
- Forward-looking statements
- Risk discussions

**Preparation:**
- Include full transcript
- Preserve speaker context
- Maintain question-answer pairs
- Keep related discussions together

---

## Best Practices Summary

1. **Context-Rich Documents**: Include documents with substantial context
2. **Mix Document Types**: Combine different perspectives and sources
3. **Clean Text**: Use OCR-corrected, well-formatted text
4. **Optimal Length**: Target 500-5000 words per document
5. **Descriptive Names**: Use structured, consistent context names
6. **Source Balance**: Ensure diverse perspectives
7. **Quality Control**: Verify document quality before analysis
8. **Post-Analysis Review**: Check graph quality and source attribution
9. **Iterative Refinement**: Use gaps to guide further document collection
10. **Documentation**: Track which documents contribute to which insights

---

## Integration with Other Skills

### With Document Semantic Search

**Workflow:**
1. Use semantic search to find relevant documents
2. Extract document text for graph analysis
3. Build knowledge graph from search results
4. Use graph insights to refine semantic search queries

### With SEC Intelligence

**Workflow:**
1. Retrieve SEC filings (10-K, 10-Q)
2. Extract risk factors and MD&A sections
3. Build knowledge graph from filings
4. Track thematic evolution across quarters

---

**Last Updated:** 2025-01-06

