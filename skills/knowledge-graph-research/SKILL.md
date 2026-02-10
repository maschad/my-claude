---
name: knowledge-graph-research
description: Deep discourse analysis of credit market documents using InfraNodus text network analysis. Transforms document collections into knowledge graphs, revealing conceptual relationships, thematic clusters, structural gaps, and research questions. Use when analyzing credit documentation, developing investment theses, conducting due diligence, or synthesizing market intelligence.
license: Complete terms in LICENSE.txt
---

# Knowledge Graph Research Skill

## Overview

This skill enables deep discourse analysis of credit market documents using InfraNodus text network analysis. It transforms collections of documents into knowledge graphs, revealing conceptual relationships, thematic clusters, structural gaps, and research questions that emerge from the discourse structure itself.

---

# Process

## 🚀 High-Level Workflow

Using knowledge graph research involves understanding the capabilities, preparing documents, analyzing discourse structure, and interpreting results:

### Phase 1: Understand Core Capabilities

#### 1.1 Text Network Analysis
- Convert documents into knowledge graphs with nodes (concepts) and edges (relationships)
- Extract main topical clusters from credit reports, research, and market commentary
- Identify structural discourse gaps - areas where concepts are isolated or poorly connected
- Generate research questions based on network topology

#### 1.2 Discourse Gap Detection
- Find clusters that lack connections, suggesting blind spots in analysis
- Identify bridge concepts that could connect disparate themes
- Reveal assumptions embedded in document structure
- Surface areas requiring additional due diligence

#### 1.3 Concept Clustering
- Group related concepts using network modularity algorithms
- Extract dominant themes from credit market discussions
- Track thematic evolution across document sets
- Identify emerging narratives in market sentiment

#### 1.4 Graph-Based AI Insights (Graph-RAG)
- Use knowledge graph structure to provide contextually-aware AI responses
- Query across graph topology rather than just text similarity
- Generate insights that account for concept relationships and discourse patterns
- Produce responses grounded in structural understanding of the domain

#### 1.5 Visual Graph Generation
- Export DOT format graphs for Graphviz rendering
- Create entity-based graphs (high-level overview, sparser)
- Create concept-based graphs (detailed, shows all relationships)
- Visualize discourse structure for presentations and reports

---

### Phase 2: Prepare Documents and Plan Analysis

**Load [📄 Document Preparation Guide](./reference/document_preparation.md) for comprehensive document preparation strategies.**

#### 2.1 Document Selection

**Include Context-Rich Documents:**
- Credit agreements and amendments
- Research reports and market commentary
- Earnings call transcripts
- Regulatory filings (10-K, 10-Q risk factors)
- Internal memos and analysis

**Mix Document Types:**
- Combine different perspectives (internal vs. external)
- Include multiple time periods for evolution tracking
- Mix document types to reveal cross-cutting themes
- Balance depth and breadth of coverage

#### 2.2 Text Quality Requirements

**Clean, Well-Formatted Text:**
- Use OCR-corrected text when needed
- Remove excessive boilerplate if it dominates
- Preserve meaningful structure (headings, sections)
- Ensure sufficient length for meaningful analysis

**Consider Document Length:**
- Very long documents may need chunking
- Very short documents may not generate meaningful graphs
- Balance between detail and manageability

#### 2.3 Context Naming Strategy

**Use Descriptive, Structured Names:**
- Include date/version for tracking evolution
- Examples: `bsl_covenants_q4_2024`, `healthcare_risk_analysis_2024`
- Helps organize multiple analyses
- Enables longitudinal tracking

---

### Phase 3: Execute Analysis Workflows

#### 3.1 Covenant Precedent Research

**Scenario:** Analyzing covenant structures across multiple credit agreements

**Workflow:**
```python
# Step 1: Collect credit agreements
agreements = [
    credit_agreement_1,
    credit_agreement_2,
    credit_agreement_3
]

# Step 2: Build knowledge graph
graph = analyze_text_network(
    texts=agreements,
    context_name="financial_covenant_structures"
)

# Step 3: Identify gaps in covenant coverage
gaps = detect_discourse_gaps(
    texts=agreements,
    context_name="covenant_gap_analysis"
)

# Step 4: Ask strategic questions
insights = get_graph_based_insights(
    texts=agreements,
    prompt="What covenant structures are common across these agreements? What variations exist?",
    mode="question",
    context_name="covenant_comparison"
)

# Step 5: Visualize for presentation
viz = generate_knowledge_graph_visualization(
    texts=agreements,
    extract_entities_only=False,
    context_name="covenant_network"
)
```

#### 3.2 Market Sentiment Analysis

**Scenario:** Tracking thematic evolution in credit market commentary

**Workflow:**
```python
# Analyze thematic evolution
reports = [weekly_report_1, weekly_report_2, weekly_report_3]

# Extract clusters
clusters = cluster_credit_concepts(
    texts=reports,
    min_cluster_size=2,
    context_name="weekly_credit_themes"
)

# Identify what's NOT being discussed
gaps = detect_discourse_gaps(
    texts=reports,
    context_name="market_blind_spots"
)

# Generate strategic insights
insights = get_graph_based_insights(
    texts=reports,
    prompt="What emerging themes are gaining connectivity in credit discussions?",
    mode="chat",
    context_name="theme_evolution"
)
```

#### 3.3 Due Diligence Enhancement

**Scenario:** Comprehensive analysis of deal documentation

**Workflow:**
```python
# Combine multiple document types
docs = [
    credit_agreement,
    security_agreement,
    intercreditor_agreement,
    fee_letter
]

# Build comprehensive graph
graph = analyze_text_network(
    texts=docs,
    context_name="comprehensive_deal_structure"
)

# Find structural gaps
gaps = detect_discourse_gaps(
    texts=docs,
    context_name="documentation_completeness"
)

# Generate diligence questions
questions = get_graph_based_insights(
    texts=docs,
    prompt="What key topics are isolated or poorly connected in this deal documentation?",
    mode="question",
    context_name="diligence_gaps"
)
```

#### 3.4 Investment Thesis Development

**Scenario:** Building comprehensive understanding of market narratives

**Workflow:**
1. Collect research reports, earnings calls, and market commentary
2. Build knowledge graph to identify well-connected vs. isolated themes
3. Detect discourse gaps that competitors may have missed
4. Generate research questions based on structural analysis
5. Use Graph-RAG to synthesize insights across the discourse structure

#### 3.5 Longitudinal Analysis

**Scenario:** Tracking how knowledge graphs evolve over time

**Workflow:**
```python
# Quarter 1
q1_graph = analyze_text_network(q1_docs, "q1_2024")

# Quarter 2
q2_graph = analyze_text_network(q2_docs, "q2_2024")

# Compare modularity, cluster evolution, emerging concepts
```

---

### Phase 4: Interpret and Apply Results

**Load [✅ Best Practices Guide](./reference/best_practices.md) for comprehensive interpretation strategies.**

#### 4.1 Graph Interpretation

**Modularity Scores:**
- **High modularity (>0.4)**: Fragmented discourse with clear clusters
- **Low modularity (<0.3)**: Interconnected, cohesive discussion
- **0.3-0.5**: Ideal range - clear themes with some integration

**Betweenness Centrality:**
- High betweenness = bridge concepts connecting different parts
- Critical for understanding the whole discourse
- Potential areas for innovation or disruption

**Cluster Analysis:**
- **Isolated clusters**: Specialized domains or potential blind spots
- **Dense clusters**: Well-understood, thoroughly discussed topics
- **Sparse graphs**: Fragmented understanding, need for synthesis

#### 4.2 Gap Analysis

**Interpreting Discourse Gaps:**
- Gaps don't always mean problems - sometimes specialization is appropriate
- Bridge concepts are critical - they connect otherwise isolated themes
- Use gaps to guide further research and due diligence
- Cross-reference gaps with actual documentation

#### 4.3 Quality Indicators

**Good Graph Characteristics:**
- Modularity between 0.3-0.5 (clear themes, some integration)
- Multiple clusters of similar size (balanced coverage)
- Bridge concepts connecting major themes
- Interpretable cluster themes

**Warning Signs:**
- Single dominant cluster (overly general or unfocused)
- Many tiny clusters (fragmented, noisy data)
- No clear thematic structure (poor source quality)
- Modularity >0.6 (siloed, disconnected discourse)

---

# Reference

## Key Functions

### `analyze_text_network(texts, context_name)`
**Purpose:** Create knowledge graph from document collection

**Parameters:**
- `texts`: List of document strings (articles, reports, agreements)
- `context_name`: Identifier for this analysis context

**Returns:**
- Knowledge graph with nodes, edges, and clusters
- Main topics and key concepts
- Thematic clusters with modularity scores
- Network statistics

**Example:**
```python
# Analyze a set of credit agreements
texts = [agreement1_text, agreement2_text, agreement3_text]
result = analyze_text_network(
    texts=texts,
    context_name="syndicated_loan_covenants_q4_2024"
)

# Result contains:
# - nodes: [{id, label, size, metrics}, ...]
# - edges: [{source, target, weight}, ...]
# - clusters: [{id, concepts, theme}, ...]
# - main_topics: ["financial covenants", "collateral", ...]
```

### `detect_discourse_gaps(texts, context_name)`
**Purpose:** Identify structural gaps and missing connections

**Parameters:**
- `texts`: Document collection
- `context_name`: Analysis identifier

**Returns:**
- Discourse gaps (disconnected clusters)
- Bridge concepts that could connect themes
- Research questions generated from gaps
- Recommendations for further investigation

**Example:**
```python
# Find what's missing in credit analysis
gaps = detect_discourse_gaps(
    texts=[research_reports],
    context_name="healthcare_lending_gap_analysis"
)

# Result might show:
# - "ESG considerations" cluster isolated from "credit metrics" cluster
# - Bridge concept: "sustainability-linked pricing"
# - Research question: "How do ESG factors impact covenant structures?"
```

### `cluster_credit_concepts(texts, min_cluster_size, context_name)`
**Purpose:** Extract and cluster thematic concepts

**Parameters:**
- `texts`: Document collection
- `min_cluster_size`: Minimum concepts per cluster (default: 2)
- `context_name`: Analysis identifier

**Returns:**
- Topical clusters with key concepts
- Cluster coherence metrics
- Dominant themes and sub-themes

**Example:**
```python
# Cluster concepts from market commentary
clusters = cluster_credit_concepts(
    texts=[market_reports],
    min_cluster_size=3,
    context_name="bsl_clo_market_themes"
)

# Result groups related concepts:
# Cluster 1: ["spread compression", "covenant-lite", "EBITDA adjustments"]
# Cluster 2: ["CLO issuance", "AAA tranche", "arbitrage opportunities"]
```

### `get_graph_based_insights(texts, prompt, mode, context_name)`
**Purpose:** Generate AI insights using graph structure (Graph-RAG)

**Parameters:**
- `texts`: Document collection
- `prompt`: Question or research query
- `mode`: "chat" | "question" | "summary"
- `context_name`: Analysis identifier

**Returns:**
- AI-generated insights grounded in graph topology
- Main topics and key concepts from graph
- Thematic clusters and their relationships
- Discourse gaps relevant to the query
- Graph modularity metrics

**Example:**
```python
# Ask strategic questions informed by discourse structure
insights = get_graph_based_insights(
    texts=[credit_docs, market_research],
    prompt="What hidden risks exist in the healthcare lending market?",
    mode="question",
    context_name="healthcare_risk_analysis"
)

# Response includes:
# - AI answer informed by graph structure
# - Identification of isolated risk concepts
# - Gaps between discussed and undiscussed risks
# - Structural insights about discourse patterns
```

### `generate_knowledge_graph_visualization(texts, extract_entities_only, context_name)`
**Purpose:** Create exportable DOT graph for visualization

**Parameters:**
- `texts`: Document collection
- `extract_entities_only`: True for high-level (entities), False for detailed (concepts)
- `context_name`: Visualization identifier

**Returns:**
- DOT format graph string
- Graph summary and insights
- Usage instructions for rendering

**Example:**
```python
# Create high-level entity graph
viz = generate_knowledge_graph_visualization(
    texts=[agreements],
    extract_entities_only=True,  # Sparser, cleaner graph
    context_name="loan_agreement_structure"
)

# Save and render:
# 1. Save viz['dot_graph'] to file.dot
# 2. Run: dot -Tpng file.dot -o graph.png
# 3. Or: dot -Tsvg file.dot -o graph.svg

# Create detailed concept graph
viz_detailed = generate_knowledge_graph_visualization(
    texts=[agreements],
    extract_entities_only=False,  # Dense, comprehensive graph
    context_name="covenant_network_detailed"
)
```

---

## Technical Approach

### Knowledge Graph Construction
The system uses InfraNodus, which:
1. Extracts key concepts from text using NLP
2. Builds a network where concepts are nodes and co-occurrence creates edges
3. Calculates network metrics (modularity, betweenness centrality, clustering)
4. Identifies topical communities using graph algorithms

### Discourse Gap Analysis
Gaps are identified by:
- Finding clusters with low inter-connectivity
- Identifying bridge concepts that could connect themes
- Measuring graph modularity to assess discourse fragmentation
- Comparing expected vs. actual concept relationships

### Graph-RAG Workflow
1. Documents are converted to knowledge graph
2. Graph topology is analyzed for structure and patterns
3. AI queries use both semantic content AND graph structure
4. Responses incorporate understanding of concept relationships

---

## Output Structure

### Knowledge Graph
```json
{
  "nodes": [
    {
      "id": "financial_covenants",
      "label": "financial covenants",
      "size": 15,
      "betweenness": 0.42,
      "cluster": 1
    }
  ],
  "edges": [
    {
      "source": "financial_covenants",
      "target": "leverage_ratio",
      "weight": 8
    }
  ],
  "clusters": [
    {
      "id": 1,
      "concepts": ["financial_covenants", "leverage_ratio", "EBITDA"],
      "theme": "Financial Metrics"
    }
  ],
  "main_topics": ["financial covenants", "collateral", "guarantees"],
  "modularity": 0.38
}
```

### Discourse Gaps
```json
{
  "gaps": [
    {
      "cluster_a": "pricing_mechanisms",
      "cluster_b": "environmental_covenants",
      "connectivity": 0.12,
      "suggested_bridges": ["sustainability_linked_pricing"]
    }
  ],
  "research_questions": [
    "How do ESG considerations affect loan pricing?",
    "What covenant structures support sustainability goals?"
  ]
}
```

---

## Integration with Other Skills

### With Document Semantic Search
1. Use graph analysis to identify key covenant types
2. Feed concept clusters into semantic search queries
3. Validate graph insights with specific document retrieval
4. Cross-reference gaps with actual documentation

**Example:**
```python
# Step 1: Build knowledge graph
graph = analyze_text_network(
    texts=credit_agreements,
    context_name="covenant_structures"
)

# Step 2: Extract key concepts
key_concepts = [cluster['theme'] for cluster in graph['clusters']]

# Step 3: Use in semantic search
from document_search import semantic_search_credit_documents
for concept in key_concepts:
    results = semantic_search_credit_documents(
        query_text=f"{concept} in credit agreements",
        limit=10
    )
```

### With SEC Intelligence
1. Analyze 10-K risk factors using discourse analysis
2. Track thematic evolution across quarterly filings
3. Compare discourse structure across peer companies
4. Identify gaps in regulatory disclosure

**Example:**
```python
# Get 10-K risk factors
from sec_skill import get_latest_sec_10k
sec_doc = get_latest_sec_10k("TICKER")

# Analyze discourse structure
graph = analyze_text_network(
    texts=[sec_doc['risk_factors']],
    context_name="risk_factor_analysis"
)

# Identify gaps
gaps = detect_discourse_gaps(
    texts=[sec_doc['risk_factors']],
    context_name="risk_gaps"
)
```

### With Counterparty Network
1. Map conceptual relationships alongside financial exposure
2. Identify sector themes affecting network risk
3. Track how discourse about counterparties evolves
4. Find gaps in sector coverage or understanding

---

## Advanced Techniques

### Multi-Source Synthesis
Combine different document types:
```python
# Mix internal analysis, external research, market data
all_sources = internal_memos + sell_side_research + news_articles

comprehensive_graph = analyze_text_network(
    texts=all_sources,
    context_name="multi_source_synthesis"
)
```

### Iterative Refinement
Use gaps to guide further research:
```python
# Initial analysis
gaps = detect_discourse_gaps(texts=docs, context_name="initial")

# Focus research on gap areas
# ... gather more documents on identified gaps ...

# Re-analyze
refined = analyze_text_network(
    texts=docs + gap_focused_docs,
    context_name="refined_analysis"
)
```

### Interpretation Guide

**High Betweenness Centrality:**
Concepts with high betweenness are "bridges" - they connect different parts of the discourse. These are often:
- Integration points between topics
- Critical concepts for understanding the whole
- Potential areas for innovation or disruption

**Isolated Clusters:**
Clusters with few connections to others suggest:
- Specialized domains requiring expert knowledge
- Potential blind spots or incomplete analysis
- Opportunities for novel connections

**Dense Clusters:**
Heavily interconnected clusters indicate:
- Well-understood, thoroughly discussed topics
- Possible groupthink or conventional wisdom
- Areas where consensus exists

**Sparse Graphs:**
Low overall connectivity suggests:
- Fragmented understanding across sources
- Multiple independent narratives
- Need for synthesis or integration

---

## Limitations & Considerations

### Text Quality Matters
- OCR errors can create spurious concepts
- Legal boilerplate may dominate graphs if not filtered
- Very short documents may not generate meaningful graphs

### Graph Interpretation
- Networks show co-occurrence, not causation
- High-frequency terms may overshadow important rare terms
- Context is critical - interpret results with domain knowledge

### Scale Considerations
- Very large document sets may need batching
- Entity-only graphs are better for high-level overviews
- Concept graphs can become dense with many documents

### Complementary Approaches
- Graph analysis reveals structure, not semantic depth
- Combine with traditional reading for full understanding
- Use as hypothesis generator, not definitive answer source

---

## Future Enhancements

### Planned Capabilities
- Temporal graph evolution tracking
- Automated gap-filling recommendations
- Integration with entity extraction for named entities
- Custom concept filtering and weighting

### Integration Opportunities
- Direct SurrealDB storage of graphs
- Cross-referencing with semantic search results
- Automated report generation from graph insights
- Real-time graph updates as new documents arrive

---

# Reference Files

## 📚 Documentation Library

Load these resources as needed during knowledge graph research:

### Core Guides (Load First)
- [📄 Document Preparation Guide](./reference/document_preparation.md) - Best practices for preparing documents for knowledge graph analysis including:
  - Document selection strategies
  - Text quality requirements
  - Context naming conventions
  - Multi-source synthesis techniques

- [📊 Graph Analysis Guide](./reference/graph_analysis.md) - Comprehensive guide on interpreting knowledge graphs including:
  - Modularity and centrality metrics
  - Cluster interpretation
  - Gap analysis strategies
  - Quality indicators and warning signs

- [✅ Best Practices Guide](./reference/best_practices.md) - Complete best practices for knowledge graph research including:
  - Workflow patterns
  - Result interpretation guidelines
  - Integration strategies
  - Advanced techniques

---

**Skill Version:** 1.0
**Last Updated:** 2025-01-06
**Maintained By:** Arda Insights Team
**Dependencies:** InfraNodus API, arda-insights MCP server
