# Graph Analysis Guide

## Overview

This guide provides comprehensive strategies for interpreting knowledge graphs, understanding network metrics, and extracting actionable insights from discourse structure analysis.

---

## Core Metrics

### Modularity

**Definition:** Measures how well the graph is divided into distinct communities/clusters.

**Interpretation:**
- **High modularity (>0.4)**: Fragmented discourse with clear, separate clusters
- **Low modularity (<0.3)**: Interconnected, cohesive discussion with integrated themes
- **Ideal range (0.3-0.5)**: Clear themes with some integration between them

**Use Cases:**
- Assess discourse fragmentation
- Identify siloed vs. integrated discussions
- Track thematic evolution over time

**Example:**
```python
graph = analyze_text_network(texts, "analysis")
modularity = graph['modularity']  # 0.38

# Interpretation: Well-structured discourse with clear themes
# and reasonable integration between clusters
```

### Betweenness Centrality

**Definition:** Measures how often a concept appears on shortest paths between other concepts.

**Interpretation:**
- **High betweenness**: Bridge concepts connecting different parts of discourse
- **Low betweenness**: Peripheral or specialized concepts
- **Critical nodes**: High betweenness = integration points

**Use Cases:**
- Identify bridge concepts
- Find integration points between themes
- Discover critical concepts for understanding

**Example:**
```python
# Find concepts with high betweenness
bridge_concepts = [
    node for node in graph['nodes']
    if node['betweenness'] > 0.3
]

# These concepts connect different thematic clusters
```

### Cluster Coherence

**Definition:** How well concepts within a cluster are related.

**Interpretation:**
- **High coherence**: Tightly related concepts, clear theme
- **Low coherence**: Loose connections, unclear theme
- **Cluster size**: Larger clusters may have lower coherence

**Use Cases:**
- Assess cluster quality
- Identify well-defined vs. vague themes
- Guide cluster interpretation

---

## Cluster Interpretation

### Isolated Clusters

**Characteristics:**
- Few connections to other clusters
- High internal connectivity
- Low betweenness to other clusters

**Interpretation:**
- Specialized domains requiring expert knowledge
- Potential blind spots or incomplete analysis
- Opportunities for novel connections
- May indicate siloed thinking

**Action Items:**
- Investigate why cluster is isolated
- Look for bridge concepts that could connect
- Consider if isolation is appropriate or problematic
- Generate research questions about connections

### Dense Clusters

**Characteristics:**
- High internal connectivity
- Many concepts within cluster
- Strong thematic coherence

**Interpretation:**
- Well-understood, thoroughly discussed topics
- Possible groupthink or conventional wisdom
- Areas where consensus exists
- May indicate over-discussed topics

**Action Items:**
- Verify if consensus is appropriate
- Check for alternative perspectives
- Look for gaps within dense clusters
- Consider if density indicates thoroughness or bias

### Sparse Clusters

**Characteristics:**
- Low internal connectivity
- Few concepts within cluster
- Weak thematic coherence

**Interpretation:**
- Emerging or underdeveloped themes
- Fragmented understanding
- Need for synthesis or integration
- May indicate incomplete analysis

**Action Items:**
- Gather more documents on sparse themes
- Look for related concepts in other clusters
- Consider if sparsity indicates novelty or incompleteness
- Generate research questions to fill gaps

---

## Gap Analysis

### Identifying Discourse Gaps

**What Are Gaps:**
- Clusters with low inter-connectivity
- Missing connections between related themes
- Isolated concepts or themes
- Structural blind spots in discourse

**Gap Types:**
1. **Thematic Gaps**: Related themes that aren't connected
2. **Conceptual Gaps**: Missing links between concepts
3. **Temporal Gaps**: Themes not connected across time periods
4. **Source Gaps**: Missing perspectives or document types

### Interpreting Gaps

**Gaps Don't Always Mean Problems:**
- Sometimes specialization is appropriate
- Some themes are legitimately separate
- Not all concepts need to be connected

**When Gaps Are Problematic:**
- Related themes should be connected but aren't
- Missing connections indicate blind spots
- Isolated clusters suggest incomplete analysis
- Gaps reveal assumptions in discourse structure

### Using Gap Analysis

**Research Questions:**
- Generate questions based on gap structure
- Identify areas needing further investigation
- Discover what's NOT being discussed
- Find opportunities for novel connections

**Due Diligence:**
- Use gaps to guide investigation
- Identify areas requiring additional analysis
- Surface implicit assumptions
- Generate comprehensive question lists

**Example:**
```python
gaps = detect_discourse_gaps(texts, "analysis")

# For each gap:
for gap in gaps['gaps']:
    print(f"Cluster {gap['cluster_a']} and {gap['cluster_b']} are disconnected")
    print(f"Bridge concept: {gap['suggested_bridges']}")
    print(f"Research question: {gap['research_questions']}")
```

---

## Quality Indicators

### Good Graph Characteristics

**Modularity:**
- Between 0.3-0.5 (clear themes, some integration)
- Not too high (>0.6 = siloed)
- Not too low (<0.2 = no structure)

**Cluster Structure:**
- Multiple clusters of similar size
- Balanced coverage across themes
- Interpretable cluster themes
- Reasonable cluster sizes (not too many tiny clusters)

**Bridge Concepts:**
- Clear bridge concepts connecting major themes
- High betweenness nodes are meaningful
- Integration points are interpretable

**Overall Structure:**
- Clear thematic organization
- Meaningful relationships between concepts
- Interpretable discourse structure
- Actionable insights emerge

### Warning Signs

**Single Dominant Cluster:**
- Problem: Overly general or unfocused
- Solution: Include more diverse documents or focus analysis

**Many Tiny Clusters:**
- Problem: Fragmented, noisy data
- Solution: Increase min_cluster_size or improve document quality

**No Clear Structure:**
- Problem: Poor source quality or insufficient context
- Solution: Improve document selection and preparation

**Modularity >0.6:**
- Problem: Siloed, disconnected discourse
- Solution: Include more integrative documents or bridge concepts

**Modularity <0.2:**
- Problem: No clear thematic structure
- Solution: Improve document selection or focus analysis

---

## Advanced Interpretation

### Longitudinal Analysis

**Track Evolution:**
- Compare modularity over time
- Track cluster emergence and decline
- Monitor bridge concept evolution
- Identify thematic shifts

**Example:**
```python
# Quarter 1
q1_graph = analyze_text_network(q1_docs, "q1_2024")
q1_modularity = q1_graph['modularity']  # 0.35

# Quarter 2
q2_graph = analyze_text_network(q2_docs, "q2_2024")
q2_modularity = q2_graph['modularity']  # 0.42

# Interpretation: Discourse becoming more fragmented
# May indicate emerging themes or increasing specialization
```

### Multi-Source Comparison

**Compare Perspectives:**
- Internal vs. external analysis
- Buy-side vs. sell-side research
- Legal vs. financial perspectives
- Historical vs. current documents

**Identify Differences:**
- Compare cluster structures
- Find perspective-specific themes
- Identify consensus vs. disagreement
- Discover unique insights from each source

### Bridge Concept Analysis

**Identify Critical Concepts:**
- High betweenness = integration points
- Bridge concepts connect themes
- Critical for understanding whole discourse
- Potential areas for innovation

**Use Bridge Concepts:**
- Focus research on bridge concepts
- Understand how themes connect
- Identify opportunities for novel connections
- Generate strategic questions

---

## Graph-RAG Interpretation

### Understanding Graph-Based Insights

**Structure-Informed Responses:**
- AI uses graph topology, not just text
- Responses account for concept relationships
- Insights grounded in discourse structure
- More comprehensive than semantic search alone

**Key Components:**
- Main topics from graph structure
- Thematic clusters and relationships
- Discourse gaps relevant to query
- Graph modularity and metrics

### Using Graph-RAG Effectively

**Craft Effective Prompts:**
- Ask questions that benefit from structure
- Focus on relationships and patterns
- Explore gaps and connections
- Generate strategic insights

**Example Prompts:**
- "What themes are isolated in this analysis?"
- "How do different risk factors connect?"
- "What gaps exist in the discourse structure?"
- "What emerging themes are gaining connectivity?"

---

## Visualization Strategies

### Entity-Only Graphs

**Use When:**
- High-level overview needed
- Presenting to non-technical audience
- Too many concepts for detailed view
- Focus on major themes

**Characteristics:**
- Sparser, cleaner graph
- Focus on named entities
- Easier to interpret
- Better for presentations

### Concept-Based Graphs

**Use When:**
- Detailed analysis needed
- Understanding all relationships
- Research and investigation
- Comprehensive view required

**Characteristics:**
- Dense, comprehensive graph
- Shows all concept relationships
- More detailed insights
- Better for deep analysis

### Rendering Graphs

**DOT Format:**
```python
viz = generate_knowledge_graph_visualization(
    texts=docs,
    extract_entities_only=False,
    context_name="analysis"
)

# Save and render
with open("graph.dot", "w") as f:
    f.write(viz['dot_graph'])

# Render with Graphviz
# dot -Tpng graph.dot -o graph.png
# dot -Tsvg graph.dot -o graph.svg
```

---

## Best Practices Summary

1. **Understand Metrics**: Know what modularity, betweenness, and coherence mean
2. **Interpret Clusters**: Recognize isolated, dense, and sparse patterns
3. **Analyze Gaps**: Use gaps to guide research and due diligence
4. **Check Quality**: Verify graph meets quality indicators
5. **Watch for Warnings**: Identify and address warning signs
6. **Track Evolution**: Use longitudinal analysis for trends
7. **Compare Sources**: Use multi-source comparison for insights
8. **Focus on Bridges**: Understand critical integration points
9. **Use Graph-RAG**: Leverage structure-informed AI insights
10. **Visualize Appropriately**: Choose entity vs. concept graphs based on need

---

**Last Updated:** 2025-01-06

