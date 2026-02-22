---
description: "Generate a researcher profile and comprehensive publication list / Identify researchers from a theory or concept name"
argument-hint: "<researcher name or concept/theory name>"
allowed-tools: [WebSearch, WebFetch, Read, Write, Bash, AskUserQuestion]
---

# Researcher Profile Generator

Generate a comprehensive researcher profile and full publication/research list from a researcher's name, or identify researchers from a theory/concept name.

**Input**: $ARGUMENTS

## Two Input Modes

### Mode A: Forward Lookup (Researcher Name → Profile & Publications)

Input: A researcher's name (e.g., "Csikszentmihalyi", "Hideki Yukawa")

Output:
1. **Profile** (basic info, background, career, personality)
2. **Full research list** (summary table with methodology overview column)
3. **Detailed research cards** (summary, methodology, significance)
4. **Footnoted references** (for fact-checking)

### Mode B: Reverse Lookup (Concept/Theory → Researcher Identification)

Input: A research topic, theory, or concept name (e.g., "flow theory", "experience sampling method", "meson theory")

Output (two stages):
1. **Related researchers table** (candidates with roles and degree of involvement)
2. Based on user's choice: **Detailed profile generation (B-path)** or **Comparison table (C-path)**

---

## Workflow

### Input Classification

Determine which mode applies:
- **A person's name is included** → Mode A (forward lookup)
- **A concept/theory/method name is included, researcher unknown** → Mode B (reverse lookup)
- **Ambiguous** → Ask the user to clarify

---

### Mode A: Forward Lookup Workflow

#### Step 1: Information Gathering (Multi-language, Multiple Sources)

Upon receiving a researcher's name, gather information as follows:

1. **Conduct web searches in multiple languages**
   - Use `web_search` with the name + "research" "publications" "bibliography" etc.
   - **Always search in both the user's language and English.** Additionally, attempt searches in the researcher's region-specific language (Chinese, German, French, etc.) as appropriate
   - Source priority: Wikipedia (multilingual editions), university official pages, authoritative sites (NobelPrize.org, etc.), Google Scholar, academic databases (PubMed, arXiv, JSTOR, etc.), encyclopedias (Britannica, etc.)

2. **Use `web_fetch` to retrieve detailed pages**
   - University researcher profile pages, publication list pages, etc.
   - Academic database author pages (when accessible)

3. **Pursue comprehensiveness while acknowledging limitations**
   - List not only landmark works but also early research, minor studies, and collaborative work as much as possible
   - **Only include what can be verified through web searches. Never fabricate unverified research**
   - Include the following disclaimer at the top of the document: "This document is based on information available on the web. Due to access restrictions on academic databases, it may not cover all research. For more complete information, consult Google Scholar, Semantic Scholar, ORCID, or other academic databases."

> **Future improvement note (API integration)**: Currently web-search-based, but the following APIs would greatly improve accuracy and coverage if available:
> - **Semantic Scholar API** / **OpenAlex API**: Retrieve full paper lists, citation counts, co-authorship by author ID
> - **CrossRef API**: DOI-based paper metadata (title, authors, abstract, citations)
> - **PubMed API (Entrez)**: Medical and life science paper search
> - **arXiv API**: Physics, math, CS preprint search
> - **ORCID API**: Retrieve affiliations and paper lists via unified researcher ID
> - **Google Scholar Profiles** (unofficial API): h-index, citation counts, paper lists
>
> These would also significantly improve methodology detail extraction from abstracts.

#### Step 2: Output Format Decision

Default to Markdown (.md) unless the user specifies otherwise:

| Request | Output Format | Use Case |
|---------|--------------|----------|
| Default | Markdown (.md) | Easy to view and edit |
| "In Excel" / "as a spreadsheet" | Excel (.xlsx) | Filtering and sorting tables |
| "As PDF" / "as a report" | PDF (.pdf) | For submission or printing |
| "In Word" | Word (.docx) | For report submission |

#### Step 3: Document Generation

Generate the document following the output template below.

---

### Mode B: Reverse Lookup Workflow

Identify researchers from a concept, theory, or method name, then generate profiles.

#### Step 1: Concept → Researcher Identification

1. **Search for the concept and related researchers**
   - Use `web_search` with the concept name + "founder" "originated by" "coined by" "developed by" "proposed by" etc.
   - Search in both English and the user's language
   - Reference Wikipedia, encyclopedias, academic review papers, etc.

2. **Extract related researchers and classify roles**
   Assess each researcher's "degree of involvement":

   | Involvement | Definition | Example |
   |-------------|-----------|---------|
   | **Originator/Founder** | First defined or named the concept | Csikszentmihalyi (flow theory) |
   | **Co-founder** | Made essential contributions to its creation | Seligman (co-founding positive psychology) |
   | **Major developer** | Significantly expanded or refined the theory | Nakamura (framework development of flow theory) |
   | **Applier/Popularizer** | Applied the theory to other fields or popularized it | Jimmy Johnson (flow theory in sports) |
   | **Precursor/Influencer** | Provided precursor ideas for the concept | Maslow (self-actualization → precursor to flow) |

#### Step 2: Present Related Researchers Table

Present the following template directly in chat (not as a document):

```
[Reverse Lookup Results] Researchers related to "[concept name]"

| # | Researcher | Involvement | Role Summary | Active Period | Key Works |
|---|-----------|-------------|-------------|--------------|-----------|
| 1 | [Name]    | Originator  | [1-2 sentences] | [Period] | [Work title] |
| 2 | [Name]    | Co-founder  | [1-2 sentences] | [Period] | [Work title] |
| ...| ...      | ...         | ...         | ...          | ...       |
```

#### Step 3: Present Options to User

Use `AskUserQuestion` to present the following options:

- **"Select one for a detailed profile" (B-path)**: Transition to Mode A forward lookup workflow to generate a full profile and research document for the selected researcher
- **"Generate comparison table for all" (C-path)**: Generate a comparison table document with brief profiles of all related researchers

#### Step 4-B: Detailed Profile Generation (if B-path selected)

Start from Mode A Step 1 (information gathering) for the selected researcher and generate the same complete document as a forward lookup.

#### Step 4-C: Comparison Table Generation (if C-path selected)

Generate a document using the following comparison table template:

```markdown
# Comparison of Researchers Related to "[Concept Name]"

> This document compares key researchers associated with "[concept name]".

## Concept Overview

[Brief description of the concept (3-5 sentences). Definition, significance, fields of application, etc.]

## Researcher Comparison Table

| Item | [Researcher 1] | [Researcher 2] | [Researcher 3] | ... |
|------|---------------|---------------|---------------|-----|
| Involvement | Originator | Co-founder | Developer | ... |
| Birth-Death | | | | |
| Nationality/Region | | | | |
| Affiliation | | | | |
| Field | | | | |
| Key contribution to this concept | [2-3 sentences] | [2-3 sentences] | [2-3 sentences] | |
| Period of contribution | | | | |
| Key works/papers | | | | |
| Methodology characteristics | | | | |
| Personal characteristics | [1-2 sentences] | [1-2 sentences] | [1-2 sentences] | |

## Individual Researcher Details

### [Researcher 1] ([Involvement])

[Career summary (3-5 sentences)]

**Contribution to this concept:**
[Specific contribution (5-10 sentences). What, when, and how they contributed.]

[Repeat for all researchers]

## Genealogy of the Concept's Development

[Describe chronologically how the concept developed. Show who contributed what and when,
and how each person's work connected to the next.]

## References & Footnotes

[List sources in footnote format]
```

#### Notes Specific to Reverse Lookup

- **Number of related researchers**: Typically narrow down to 3-7. If too many (e.g., "quantum mechanics" with dozens), limit to the top 5-7 by involvement and note that "many other contributors exist"
- **Exercise caution in involvement assessment**: Attribution of "originator" or "founder" may be academically debated (e.g., who is the "true" founder of positive psychology). In such cases, present multiple viewpoints
- **Be aware of concepts spanning eras**: Old concepts (e.g., "evolution") have many precursors; listing all is impractical. Focus on the historically most significant figures

---

## Output Template (Mode A: Forward Lookup)

```markdown
# [Researcher Name] ([Native script] / [English name])

> **Scope of Information**: This document is based on information available on the web.
> Due to access restrictions on academic databases, it may not cover all research.
> For more complete information, consult Google Scholar, Semantic Scholar, ORCID,
> or other academic databases.

## 1. Profile

| Item | Details |
|------|---------|
| Date of Birth | YYYY-MM-DD |
| Date of Death | YYYY-MM-DD (or "Living" if alive) |
| Place of Birth | Country, City |
| Nationality | |
| Affiliations | Major institutional history (chronological) |
| Degree | Highest degree and institution |
| Field | |
| Major Awards | Nobel Prize, etc. |

### Background & Career

[Describe childhood through education and career chronologically. Several paragraphs.]

### Personality — Character, Temperament & Intellectual Style

[Describe the researcher as a person from the perspectives below. 2-4 paragraphs.]

[Follow the "Personality Description Guidelines" below.]

---

## 2. Research List

> Below is a comprehensive list of research accomplishments, not limited to major works.

### Summary Table

| # | Research Topic | Period | Field | Summary | Methodology Overview |
|---|---------------|--------|-------|---------|---------------------|
| 1 | [Topic] | [Year/Period] | [Field] | [What was studied and how] | [Follow methodology guidelines below] |
| 2 | ... | ... | ... | ... | ... |

---

## 3. Research Details

### Research 1: [Topic] ([Period])

**Summary**
- Subject: [What was studied]
- Objective: [What was being investigated]
- Content: [Specific findings and conclusions]

**Methodology**

| Item | Details |
|------|---------|
| Approach | Quantitative / Qualitative / Mixed |
| Method | [Describe specifically per field guidelines below] |
| Subjects | [Experimental subjects, participants, observation targets, data sources, etc.] |
| Sample/Scale | [Number of participants, data points, observation period, etc. (if known)] |
| Key Technology/Equipment | [Equipment, techniques, tools used (if applicable)] |
| Key Publications | [Representative publications (if known)] |

**Significance & Impact**
[Describe the impact on the field or society in 1-2 sentences]

---

[Repeat for all research items]

---

## 4. References & Footnotes

Superscript numbers in the text (e.g., [^1]) correspond to the sources below.

[^1]: [Source name, URL]
[^2]: [Source name, URL]
...
```

### Footnote (Fact-checking Citation) Guidelines

Throughout the document, attach Markdown footnotes `[^N]` to factual statements.
This allows readers to verify which information came from which source, functioning as a fact-checking mechanism.

#### Statements That Must Have Footnotes

The following factual statements **must** have footnotes:

1. **Profile information**: Date of birth, birthplace, nationality, affiliations, degrees, awards, etc.
2. **Career facts**: When they joined where, who they married, when they died, etc.
3. **Personality episodes**: Direct quotes, colleague/student testimonies, anecdotes
4. **Specific research facts**: Sample sizes, participant counts, publication year/journal
5. **Evaluative statements**: "Was described as ___", "Influenced ___", etc.

#### Statements That Don't Need Footnotes

- Author's (Claude's) summarizing or synthesizing statements (integration of multiple sources)
- Widely known general facts (though specific numbers and dates should still have footnotes)

#### Footnote Format

```markdown
<!-- In text -->
Csikszentmihalyi was born on September 29, 1934, in Fiume[^1].

<!-- Footnote section at end -->
[^1]: Wikipedia "Mihaly Csikszentmihalyi", https://en.wikipedia.org/wiki/Mihaly_Csikszentmihalyi
```

- In text: Place `[^N]` immediately after the relevant statement
- At end: List as `[^N]: Source name, URL`
- Reuse the same footnote number when referencing the same source multiple times
- Use sequential numbering throughout the document

---

## Methodology Description Guidelines

Methodology descriptions vary significantly by research field. Follow these guidelines to describe methods at an appropriate granularity for each field.

### Summary Table Descriptions

The "Methodology Overview" column in the summary table should condense the following into a single cell:

- **Approach type** (Quantitative/Qualitative/Mixed/Theoretical) in bold at the start
- **Method summary** (1-2 sentences, specific)
- **Subject/scale overview** (if known)

**Good examples:**
- "**Quantitative, theoretical**. Derived meson mass mathematically by assuming a scalar field mediating nuclear force based on quantum field theory. Pure theoretical calculation with pen and paper."
- "**Quantitative, experimental**. Gene recombination experiments using E. coli. Three-dimensional structure determined by X-ray crystallography."
- "**Qualitative**. Semi-structured interviews with 30 schizophrenia patients. Analyzed using grounded theory."
- "**Quantitative, epidemiological**. Prospective cohort study of 5,209 Framingham residents. 20-year follow-up identifying cardiovascular risk factors via multivariate regression."

### Field-Specific Guidelines for Detail Cards

#### Theoretical Sciences (Theoretical Physics, Mathematics, Theoretical CS, etc.)
- Method: Mathematical model construction, proofs, thought experiments, analytical calculations, numerical simulations, etc.
- Subject: Physical systems, mathematical structures, problem classes studied
- Techniques: Mathematical methods used (perturbation theory, group theory, variational methods, etc.)
- "Pen-and-paper theoretical calculation" is a legitimate method to document

#### Experimental Sciences (Experimental Physics, Chemistry, Biology, Materials Science, etc.)
- Method: Experimental techniques (X-ray diffraction, spectroscopy, PCR, electron microscopy, accelerator experiments, etc.)
- Subject: Experimental targets (materials, species, particles) and conditions
- Sample/Scale: Number of specimens, measurements, experimental conditions (temperature, pressure, etc.)
- Technology/Equipment: Names and specifications of major equipment used

#### Medicine & Public Health
- Method: Study design (RCT / cohort study / case-control / cross-sectional / meta-analysis / systematic review, etc.)
- Subject: Target population (patient groups, healthy controls, specific diseases, etc.)
- Sample/Scale: Number of participants (N=), follow-up period, dropout rate, etc.
- Techniques: Statistical methods (logistic regression, Cox proportional hazards, ITT analysis, etc.)

#### Social Sciences (Psychology, Sociology, Education, Economics, etc.)
- Method:
  - Quantitative: Surveys, experiments (lab/field), econometric analysis, large-scale data analysis, etc.
  - Qualitative: Interviews (structured/semi-structured/unstructured), focus groups, participant observation, ethnography, discourse analysis, narrative analysis, etc.
  - Mixed: Combinations such as surveys + interviews
- Subject: Participant attributes (age group, occupation, region, selection criteria, etc.)
- Sample/Scale: Number of participants (N=), sampling method (random/purposive/snowball, etc.)
- Analysis: Statistical methods or qualitative analysis methods (grounded theory, thematic analysis, etc.)

#### Humanities (History, Philosophy, Literary Studies, etc.)
- Method: Literature review, text analysis, hermeneutic approach, comparative study, archival research, etc.
- Subject: Texts, periods, regions, thinkers analyzed
- Sources: Primary and secondary sources used

#### Information Science & Engineering
- Method: Algorithm design/analysis, numerical simulation, benchmark experiments, prototype development, user studies, etc.
- Subject: Dataset names/size, computational environment
- Techniques: Programming languages, frameworks, hardware

### When Information Is Unknown

When methodology details cannot be obtained through web searches, state honestly:

- Summary table: "**Quantitative (details unknown)**. Experimental research on ___. See original paper for methodology details."
- Detail card: Note "To be confirmed: see original paper" for the relevant item
- **Do not fill in methodology details with speculation or guesswork.** Writing "likely ___, but confirmation needed" is acceptable where there is reasonable basis

---

## Personality Description Guidelines

A researcher's character, temperament, and intellectual style deeply influence their choice of research topics, methodological preferences, and school formation. Always include a "Personality" section in the profile, depicting the researcher as a three-dimensional person.

### Perspectives to Describe (select applicable ones)

1. **Character & Temperament**: Introverted/extroverted, quiet/eloquent, gentle/passionate, cautious/bold, etc. Based on testimonies from colleagues, students, family, interview articles, autobiographical writings.
2. **Intellectual Style & Thinking Tendencies**: Intuitive/analytical, theory-oriented/empirical, deep-diver/broad-explorer, solo-thinker/dialogue-inspired, etc.
3. **Interpersonal Relations & Mentoring Style**: Relationship with students (directive/hands-off/dialogical), relationships with collaborators, behavior in academic communities.
4. **Hobbies, Interests & Cultural Sophistication**: Non-research interests (literature, art, music, sports, philosophy, religion, etc.). Especially important when these influenced research.
5. **Notable Episodes**: Specific words or actions that symbolize the person (famous quotes, anecdotes, memorable events).
6. **Source of Research Motivation**: Why they devoted their life to the topic. Motivational background such as personal experiences, trauma, intellectual curiosity direction, sense of social mission.
7. **Contradictions & Conflicts**: Internal contradictions or conflicts as a researcher and human being.

### Writing Guidelines

- **Base on sources**: Write based on verifiable information from autobiographies, biographies, tributes, interviews, colleague/student testimonies. Do not speculate about personality.
- **Avoid stereotypes**: Do not use simplistic typifications like "geniuses are eccentric." Instead, depict multidimensionally based on specific episodes and testimonies.
- **Connect to research**: Show how character and temperament are reflected in research topic selection, methodology preferences, and theory-building style to organically connect profile and research list.
- **When no information exists**: Do not force it. Write "Detailed information about personality could not be confirmed."

### Information Gathering Tips

- **Autobiographies/Memoirs**: The researcher's own autobiography is the most direct source
- **Tributes/Memorial volumes**: Post-mortem tributes and colleague reminiscences are a treasure trove of personal portraits
- **TED Talks/Lectures**: Speaking style, sense of humor, audience interaction are visible
- **Interview articles**: Newspaper/magazine interviews often reveal personality
- **Student reminiscences**: Reveal mentoring style and daily behavior
- **Web search keyword examples**: `[name] personality`, `[name] memoir`, `[name] interview`, `[name] obituary tribute`, `[name] anecdote`, `[name] character`

---

## Important Notes

### Comprehensiveness & Accuracy
- **Prioritize comprehensiveness**: List not only landmark works but also early research, minor studies, and collaborative work as much as possible
- **Only include what can be verified through web searches**: Never fabricate unverified research
- State source limitations at the top of the document (disclaimer included in template)
- Prominent historical figures have abundant web information, but **active early-to-mid-career researchers or those in niche fields** often have limited information. In such cases, document what can be obtained and recommend additional research tools (Google Scholar, ORCID, etc.)

### Methodology Description
- **Always classify methodology**: Determine whether each study is quantitative or qualitative and specify concrete methods per the field-specific guidelines above
- **Include methodology overview column in summary table**: Enable a bird's-eye view of methods at the list level
- **Include sample/scale in detail cards**: Document participant counts, data scale, follow-up periods, etc. when known
- For theoretical researchers, nearly all entries may be "theoretical calculation," but differentiate by describing different mathematical methods and theoretical frameworks used

### Intellectual Honesty
- **When information is unknown**: Honestly write "Unknown" or "To be confirmed: see original paper." Do not fill gaps with speculation
- Accept that the amount of obtainable information varies greatly by field and researcher

### Output & Language
- **Default output format**: Markdown (.md), saved to the working directory
- If the user requests Excel/PDF/Word, use the corresponding method
- **Language**: Match the user's language (English if asked in English, etc.)
- **Search language**: Always search in both the user's language and English. Attempt additional languages based on the researcher's region of activity

### Copyright
- Paper titles and book names may be listed as factual information
- **Never quote long passages from paper abstracts or content.** Always summarize research in your own words
- Include a reference section with URLs so users can access original sources
