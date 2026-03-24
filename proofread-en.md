---
description: "Proofread English text with vale + structured analysis"
argument-hint: "<text or file path>"
allowed-tools: [Bash, Read, Write]
---

# English Proofreading with vale + Claude

Proofread English text using vale for mechanical style checks and Claude for context-dependent analysis.

**Input**: $ARGUMENTS

## Workflow

### 1. Input Acquisition

- If a file path is given → `Read` the file
- If raw text is given → write to `/tmp/proofread_en_input.md` and use that

### 2. Run vale for Structural Analysis

```bash
vale --config=/Users/yosh/Projects/claude-commands/.vale.ini --output=JSON <file>
```

Parse the JSON output. If vale fails (e.g. packages not synced), run `vale sync --config=/Users/yosh/Projects/claude-commands/.vale.ini` first and retry.

### 3. Checklist (vale results + Claude judgment)

Using both vale's mechanical output and your own reading, check for:

#### Grammar
- Subject-verb agreement
- Tense consistency within paragraphs
- Dangling modifiers
- Comma splices and run-on sentences
- Misplaced or squinting modifiers

#### Spelling / Confusables
- affect/effect, its/it's, their/there/they're, complement/compliment
- who/whom, that/which, fewer/less, farther/further
- vale's Proofread.Confusables results + Claude context check

#### Punctuation Consistency
- Serial (Oxford) comma: consistent use or omission throughout
- Em dash (—) vs en dash (–) vs hyphen (-): correct and consistent usage
- Quotation mark style: straight vs curly, consistent throughout
- Semicolon and colon usage

#### Register Mixing
- Formal/informal tone mixing (contractions in otherwise formal prose, etc.)
- Colloquialisms in technical or academic writing
- Consistent voice and tone throughout

#### Redundancy
- vale's Proofread.Redundancy results
- Claude's context-dependent judgment on wordiness
- Unnecessary qualifiers ("very", "really", "quite", "rather")

#### Sentence Length
- Flag sentences with 40+ words
- Identify complex sentences that could be split for clarity

#### Passive Voice
- vale's Passive detection results
- Claude determines if each instance is contextually appropriate
- Only flag passive voice that weakens clarity or obscures agency

#### Parallel Structure
- Lists and enumerations maintain grammatical parallelism
- Correlative conjunctions (both...and, either...or, not only...but also)

#### Factual Accuracy
- Verifiable facts: names, dates, attributions, statistics
- Cross-check claims that can be verified from context
- Flag unverifiable or suspicious claims for author review

#### Repetition
- Same word or phrase repeated in adjacent sentences or paragraphs
- Repeated statistics or examples across sections
- Overused transitions or connectors

### 4. Output the Proofreading Report

Format the report as follows:

```markdown
## Proofreading Report

### Issues

| # | Line | Excerpt | Type | Source | Issue | Suggested Fix |
|---|------|---------|------|--------|-------|---------------|
| 1 | L12  | "..."   | Grammar | Claude | ... | ... |
| 2 | L44  | "..."   | Passive | vale   | ... | ... |

### Style Notes (not errors — for author judgment)
- ...

### Statistics
- Total sentences: N
- Total words: N
- Average sentence length: N words
- Longest sentence: N words (line X)
- vale alerts: N (error: N, warning: N, suggestion: N)
- Grammar/spelling issues found: N
```

**Source** column: indicate whether the issue was detected by `vale` or `Claude`.

### 5. No Issues Found

If no issues are detected, report that and output statistics only.

## Guidelines

- Output everything in English
- Quote the specific excerpt and indicate the line number
- Only flag genuine issues. Do not flag stylistic preferences
- Do NOT rewrite the entire text. Only present issues with suggested fixes
- For vale results, apply Claude judgment — suppress false positives where the usage is clearly intentional or correct in context
- Style Notes section is for observations that are not errors but may interest the author (e.g., tone shifts, unusual word choices)
