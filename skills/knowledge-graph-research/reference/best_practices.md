# Knowledge Graph Research Best Practices

## Overview

This guide provides best practices for effectively using knowledge graph research to analyze credit market documents, identify discourse gaps, and generate actionable insights.

---

## Workflow Patterns

### 1. Start with Document Collection

**Gather Diverse Sources:**
- Credit agreements and documentation
- Research reports and market commentary
- Earnings call transcripts
- Regulatory filings
- Internal analysis and memos

**Ensure Quality:**
- Use clean, OCR-corrected text
- Include context-rich documents
- Mix document types and perspectives
- Balance depth and breadth

### 2. Build Initial Knowledge Graph

**Initial Analysis:**
```python
# Build knowledge graph
graph = analyze_text_network(
    texts=documents,
    context_name="initial_analysis"
)

# Review structure
print(f"Modularity: {graph['modularity']}")
print(f"Clusters: {len(graph['clusters'])}")
print(f"Main topics: {graph['main_topics']}")
```

**Assess Quality:**
- Check modularity (should be 0.3-0.5 ideally)
- Review cluster structure
- Identify main themes
- Verify interpretability

### 3. Identify Discourse Gaps

**Gap Analysis:**
```python
# Find structural gaps
gaps = detect_discourse_gaps(
    texts=documents,
    context_name="gap_analysis"
)

# Review gaps
for gap in gaps['gaps']:
    print(f"Gap between: {gap['cluster_a']} and {gap['cluster_b']}")
    print(f"Bridge concept: {gap['suggested_bridges']}")
    print(f"Research questions: {gap['research_questions']}")
```

**Use Gaps:**
- Generate research questions
- Guide further document collection
- Identify blind spots
- Surface implicit assumptions

### 4. Generate Graph-Based Insights

**Strategic Questions:**
```python
# Ask structure-informed questions
insights = get_graph_based_insights(
    texts=documents,
    prompt="What hidden risks exist in this analysis?",
    mode="question",
    context_name="risk_analysis"
)

# Review insights
print(insights['insights'])
print(insights['main_topics'])
print(insights['gaps'])
```

**Iterate:**
- Refine questions based on initial results
- Explore different aspects of discourse
- Combine multiple queries
- Synthesize insights

### 5. Visualize and Present

**Create Visualizations:**
```python
# High-level overview
viz_entity = generate_knowledge_graph_visualization(
    texts=documents,
    extract_entities_only=True,
    context_name="overview"
)

# Detailed analysis
viz_concept = generate_knowledge_graph_visualization(
    texts=documents,
    extract_entities_only=False,
    context_name="detailed"
)
```

---

## Document Preparation

### Quality Requirements

**Text Quality:**
- Clean, OCR-corrected text
- Proper encoding (UTF-8)
- Preserve meaningful structure
- Remove excessive boilerplate

**Content Quality:**
- Context-rich documents
- Sufficient length (500-5000 words)
- Mix of document types
- Multiple perspectives

### Context Naming

**Use Structured Names:**
- Include date/version: `q4_2024`, `2024_01`
- Include focus: `covenants`, `risk`, `pricing`
- Include domain: `bsl`, `healthcare`, `syndicated`
- Examples: `bsl_covenants_q4_2024`

**Benefits:**
- Easy organization
- Track evolution
- Compare analyses
- Enable longitudinal tracking

---

## Interpretation Guidelines

### Modularity Interpretation

**High Modularity (>0.4):**
- Fragmented discourse
- Clear separate clusters
- May indicate specialization or silos
- Check if fragmentation is appropriate

**Low Modularity (<0.3):**
- Interconnected discussion
- Integrated themes
- Cohesive discourse
- May indicate comprehensive coverage

**Ideal Range (0.3-0.5):**
- Clear themes with integration
- Balanced structure
- Good for most analyses

### Cluster Analysis

**Isolated Clusters:**
- Specialized domains
- Potential blind spots
- Opportunities for connections
- May need further investigation

**Dense Clusters:**
- Well-understood topics
- Possible consensus
- Thoroughly discussed
- May indicate groupthink

**Sparse Clusters:**
- Emerging themes
- Fragmented understanding
- Need for synthesis
- May indicate incompleteness

### Gap Analysis

**Interpreting Gaps:**
- Gaps don't always mean problems
- Some specialization is appropriate
- Use gaps to guide research
- Generate questions from gaps

**Using Gaps:**
- Guide further document collection
- Identify blind spots
- Surface assumptions
- Generate research questions

---

## Integration Strategies

### With Document Semantic Search

**Workflow:**
1. Use graph analysis to identify key concepts
2. Feed concept clusters into semantic search
3. Validate graph insights with document retrieval
4. Cross-reference gaps with actual documentation

**Example:**
```python
# Step 1: Build graph
graph = analyze_text_network(documents, "analysis")

# Step 2: Extract key concepts
key_concepts = [cluster['theme'] for cluster in graph['clusters']]

# Step 3: Semantic search for each concept
from document_search import semantic_search_credit_documents
for concept in key_concepts:
    results = semantic_search_credit_documents(
        query_text=concept,
        limit=10
    )
```

### With SEC Intelligence

**Workflow:**
1. Retrieve SEC filings
2. Extract risk factors and MD&A
3. Build knowledge graph
4. Track thematic evolution

**Example:**
```python
# Get SEC filings
from sec_skill import get_latest_sec_10k
sec_doc = get_latest_sec_10k("TICKER")

# Analyze discourse
graph = analyze_text_network(
    texts=[sec_doc['risk_factors']],
    context_name="risk_analysis"
)

# Identify gaps
gaps = detect_discourse_gaps(
    texts=[sec_doc['risk_factors']],
    context_name="risk_gaps"
)
```

### With Counterparty Network

**Workflow:**
1. Map conceptual relationships
2. Identify sector themes
3. Track discourse evolution
4. Find gaps in coverage

---

## Advanced Techniques

### Longitudinal Analysis

**Track Evolution:**
```python
# Quarter 1
q1_graph = analyze_text_network(q1_docs, "q1_2024")

# Quarter 2
q2_graph = analyze_text_network(q2_docs, "q2_2024")

# Compare
print(f"Q1 Modularity: {q1_graph['modularity']}")
print(f"Q2 Modularity: {q2_graph['modularity']}")

# Track cluster evolution
# Compare main topics, cluster themes, bridge concepts
```

### Multi-Source Synthesis

**Combine Sources:**
```python
# Mix internal and external
all_sources = internal_memos + sell_side_research + news_articles

comprehensive_graph = analyze_text_network(
    texts=all_sources,
    context_name="multi_source_synthesis"
)
```

### Iterative Refinement

**Use Gaps to Guide Research:**
```python
# Initial analysis
gaps = detect_discourse_gaps(texts=docs, context_name="initial")

# Focus research on gaps
# ... gather more documents on identified gaps ...

# Re-analyze
refined = analyze_text_network(
    texts=docs + gap_focused_docs,
    context_name="refined"
)
```

---

## Common Pitfalls

### Pitfall 1: Poor Document Quality

**Problem:** Low-quality documents produce meaningless graphs

**Solution:**
- Use clean, OCR-corrected text
- Include context-rich documents
- Ensure sufficient length
- Mix document types

### Pitfall 2: Source Bias

**Problem:** One source type dominates graph

**Solution:**
- Balance source types
- Include diverse perspectives
- Mix internal and external sources
- Ensure representation

### Pitfall 3: Over-Interpreting Gaps

**Problem:** Treating all gaps as problems

**Solution:**
- Recognize appropriate specialization
- Use gaps to guide research, not as definitive problems
- Consider context and domain knowledge
- Validate gaps with additional analysis

### Pitfall 4: Ignoring Context

**Problem:** Interpreting graphs without domain knowledge

**Solution:**
- Always interpret with domain expertise
- Consider document context
- Validate insights with traditional reading
- Use graphs as hypothesis generators

### Pitfall 5: Single Analysis

**Problem:** Not iterating or refining

**Solution:**
- Use gaps to guide further research
- Iterate with additional documents
- Compare across time periods
- Synthesize multiple analyses

---

## Quality Assurance

### Pre-Analysis Checks

**Document Quality:**
- [ ] Text is clean and OCR-corrected
- [ ] Documents are context-rich
- [ ] Sufficient length for analysis
- [ ] Mix of document types included

**Naming:**
- [ ] Context names are descriptive
- [ ] Names follow consistent pattern
- [ ] Include date/version
- [ ] Names enable organization

### Post-Analysis Verification

**Graph Quality:**
- [ ] Modularity in reasonable range (0.3-0.5)
- [ ] Clusters are interpretable
- [ ] Bridge concepts are meaningful
- [ ] Gap analysis makes sense

**Source Attribution:**
- [ ] Track document contributions
- [ ] Verify source diversity
- [ ] Check for source bias
- [ ] Validate insights

---

## Best Practices Summary

1. **Start with Quality Documents**: Use clean, context-rich documents
2. **Mix Document Types**: Include diverse perspectives and sources
3. **Use Structured Naming**: Enable organization and tracking
4. **Interpret with Context**: Always use domain knowledge
5. **Iterate and Refine**: Use gaps to guide further research
6. **Validate Insights**: Cross-reference with traditional analysis
7. **Track Evolution**: Use longitudinal analysis for trends
8. **Integrate Tools**: Combine with semantic search and SEC data
9. **Visualize Appropriately**: Choose entity vs. concept graphs
10. **Generate Questions**: Use gaps to create research questions

---

**Last Updated:** 2025-01-06

