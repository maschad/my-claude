# Document Preparation Guide

## Overview

This guide covers best practices for preparing credit documents for semantic search. Proper document preparation significantly improves search quality and result relevance.

---

## Document Quality Requirements

### Text Quality

**Use Clean, OCR-Corrected Text**
- Remove OCR artifacts and errors
- Fix character recognition mistakes
- Ensure proper encoding (UTF-8)
- Verify special characters are correct

**Preserve Structural Formatting**
- Maintain headings and section numbers
- Keep article and clause numbering
- Preserve list formatting
- Retain table structures where possible

**Include Complete Documents**
- Upload full documents, not excerpts
- Include all exhibits and schedules
- Preserve cross-references
- Maintain document hierarchy

### Document Completeness

**Required Elements:**
- Complete document text
- All exhibits and schedules
- Amendment history (if applicable)
- Signature pages (for metadata)

**Optional but Helpful:**
- Table of contents
- Defined terms section
- Cross-reference tables

---

## Metadata Tagging

### Required Metadata

**Document Type**
- Use standardized taxonomy:
  - `credit_agreement`
  - `security_agreement`
  - `fee_letter`
  - `assignment_and_assumption`
  - `participation_agreement`
  - `legal_opinion`
  - `covenant_category`
  - `covenant_example`
  - `amendment_agreement`
  - `intercreditor_agreement`

**Company Information**
- `company_id`: UUID linking to knowledge graph
- `company_name`: Full legal name
- `ticker`: Stock ticker (if applicable)

**Deal Information**
- `deal_id`: UUID for transaction
- `deal_name`: Descriptive name (e.g., "2024 Refinancing")
- `deal_type`: Facility type (e.g., "syndicated", "bilateral")

**Dates**
- `execution_date`: Document execution date
- `effective_date`: Effective date (may differ from execution)
- `maturity_date`: Facility maturity (for credit agreements)
- `amendment_date`: Date of amendment (for amendments)

### Optional Metadata

**Parties**
- `borrower`: Primary obligor
- `lenders`: List of lender names
- `administrative_agent`: Agent bank
- `arranger`: Lead arranger
- `guarantors`: List of guarantors

**Financial Terms**
- `facility_amount`: Total commitment
- `pricing_spread`: Interest rate spread
- `upfront_fee_bps`: Upfront fee in basis points
- `commitment_fee_bps`: Commitment fee in basis points

**Structural Terms**
- `lien_priority`: First lien, second lien, unsecured
- `collateral_types`: List of collateral categories
- `governing_law`: Jurisdiction

---

## Document Chunking

### Chunking Strategy

**Logical Boundaries**
- Chunk at section/article boundaries
- Preserve clause completeness
- Maintain context around key provisions
- Avoid splitting related concepts

**Optimal Chunk Size**
- Target: 500-2000 words per chunk
- Balance: Enough context vs. search precision
- Consider: Embedding model context window

**Context Preservation**
- Include section headers in chunks
- Preserve cross-references
- Maintain defined terms context
- Keep related provisions together

### Chunking Patterns

**Credit Agreements**
- Chunk by article (e.g., Article 7: Covenants)
- Preserve section structure
- Keep related sections together

**Security Agreements**
- Chunk by collateral type
- Preserve grant of security
- Maintain perfection requirements

**Fee Letters**
- Chunk by fee type
- Preserve calculation mechanics
- Keep fee schedules together

**Covenant Documents**
- Chunk by covenant type
- Preserve examples and precedents
- Maintain category groupings

---

## Metadata Consistency

### Standardized Taxonomies

**Document Types**
Use consistent naming:
- ✅ `credit_agreement` (not `loan_agreement`, `credit_facility`)
- ✅ `security_agreement` (not `collateral_agreement`, `pledge_agreement`)
- ✅ `fee_letter` (not `fee_agreement`, `fee_schedule`)

**Company IDs**
- Link to knowledge graph entities
- Use consistent UUID format
- Maintain company name consistency

**Deal IDs**
- Create unique UUID per transaction
- Link all related documents
- Use descriptive deal names

### Date Formats

**Standard Format: ISO 8601**
- `YYYY-MM-DD` (e.g., `2024-03-15`)
- `YYYY-MM-DDTHH:MM:SSZ` (for timestamps)

**Consistency**
- Use same format across all documents
- Preserve timezone information
- Document date interpretation (execution vs. effective)

---

## Quality Control

### Pre-Upload Checklist

**Text Quality**
- [ ] OCR errors corrected
- [ ] Special characters preserved
- [ ] Encoding is UTF-8
- [ ] No corrupted text

**Structure**
- [ ] Complete document included
- [ ] Headings preserved
- [ ] Section numbering intact
- [ ] Cross-references maintained

**Metadata**
- [ ] Document type assigned
- [ ] Company ID linked
- [ ] Deal ID assigned
- [ ] Dates formatted correctly

**Chunking**
- [ ] Logical boundaries used
- [ ] Context preserved
- [ ] No split clauses
- [ ] Headers included in chunks

### Post-Upload Verification

**Search Test**
- Test semantic search on key terms
- Verify results are relevant
- Check metadata filtering works
- Confirm chunk boundaries are appropriate

**Metadata Verification**
- Verify company/deal linkage
- Check date accuracy
- Confirm document type classification
- Test metadata-based filtering

---

## Common Issues and Solutions

### Issue 1: Poor OCR Quality

**Problem:** Search returns irrelevant results due to OCR errors

**Solution:**
- Re-OCR with better quality settings
- Manual correction of key terms
- Use OCR post-processing tools
- Verify critical sections manually

### Issue 2: Missing Context

**Problem:** Chunks lack surrounding context

**Solution:**
- Increase chunk size
- Include section headers
- Preserve cross-references
- Add context from related sections

### Issue 3: Inconsistent Metadata

**Problem:** Documents can't be filtered effectively

**Solution:**
- Standardize document type taxonomy
- Verify company/deal IDs
- Use consistent date formats
- Create metadata validation rules

### Issue 4: Split Concepts

**Problem:** Related concepts split across chunks

**Solution:**
- Chunk at logical boundaries
- Preserve clause completeness
- Include related provisions together
- Review chunk boundaries manually

### Issue 5: Missing Documents

**Problem:** Related documents not linked

**Solution:**
- Link all documents in same deal
- Include amendment history
- Connect related agreements
- Maintain deal document inventory

---

## Document Types: Specific Guidelines

### Credit Agreements

**Key Sections to Preserve:**
- Defined terms
- Financial covenants
- Negative covenants
- Affirmative covenants
- Events of default
- Pricing and fees

**Chunking Strategy:**
- Article-level chunks
- Preserve section context
- Keep covenant definitions together

### Security Agreements

**Key Sections to Preserve:**
- Grant of security
- Collateral description
- Perfection requirements
- Release provisions

**Chunking Strategy:**
- Chunk by collateral type
- Preserve grant language
- Maintain perfection mechanics

### Fee Letters

**Key Sections to Preserve:**
- Fee calculations
- Fee schedules
- Payment mechanics
- Administrative fees

**Chunking Strategy:**
- Chunk by fee type
- Preserve calculation formulas
- Keep schedules together

### Covenant Documents

**Key Sections to Preserve:**
- Covenant definitions
- Examples and precedents
- Category descriptions
- Compliance mechanics

**Chunking Strategy:**
- Chunk by covenant type
- Preserve examples
- Maintain category structure

---

## Best Practices Summary

1. **Quality First**: Use clean, OCR-corrected text
2. **Complete Documents**: Include full documents, not excerpts
3. **Preserve Structure**: Maintain headings, numbering, formatting
4. **Logical Chunking**: Chunk at section boundaries
5. **Rich Metadata**: Tag with accurate, consistent metadata
6. **Standardize**: Use consistent taxonomies and formats
7. **Link Documents**: Connect related documents via deal_id
8. **Verify Quality**: Test search after upload
9. **Maintain Consistency**: Follow established patterns
10. **Document Standards**: Create and follow style guides

---

## Integration with Knowledge Graph

### Company Linking

**Link to Knowledge Graph:**
- Use consistent company_id UUIDs
- Link to knowledge graph entities
- Maintain company name consistency
- Update knowledge graph when needed

### Deal Relationships

**Track Deal Structure:**
- Link all documents in same deal
- Maintain deal hierarchy
- Track amendment relationships
- Preserve deal metadata

---

**Last Updated:** 2025-01-06

