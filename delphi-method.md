---
description: "Simulate the Delphi method to generate improvement or solution proposals for a given theme or challenge"
argument-hint: "<theme or challenge>"
allowed-tools: [Write, AskUserQuestion]
---

# Delphi Method Skill

Simulate the Delphi method — an iterative, anonymous expert feedback process — to produce high-quality improvement or solution proposals for any theme or challenge the user presents. Anonymity eliminates authority bias and bandwagon effects; over successive rounds, opinions converge toward well-reasoned consensus.

## Mode Detection

If the user's input contains "brief" or "brainstorm", run the **Expert Brainstorm** variant (see below). Otherwise, run the full **Delphi** process.

## Overall Flow (Full Delphi)

```
Theme → Panel assembly → Round 1 → Aggregation → Round 2 → Aggregation → Round 3 → Final consensus → Report
```

## Step-by-Step Instructions

### Step 0: Confirm the Theme

Identify the theme or challenge from the user's input. If ambiguous, ask exactly one clarifying question. If clear, proceed immediately.

### Step 1: Assemble the Expert Panel

Select **5 virtual experts** for the theme.

#### Selection Rules

| Slot | Count | Purpose |
|------|-------|---------|
| Core experts | 2–3 | Theory or technical expertise in the theme's central domain |
| Divergent perspectives | 1–2 | Adjacent fields, opposing viewpoints, or the "receiving end" |
| Frontline practitioner | At least 1 | Day-to-day stakeholder; ensures feasibility |

Cover at least 2 of 3 altitude levels: macro (policy/industry), meso (organization/team), micro (individual/frontline).

#### Persona Design

Define 4 attributes per expert — these govern all statements across every round:

1. **Domain of expertise**: What they are an expert in
2. **Role & context**: Organization or setting they work in
3. **Core belief / values**: Non-negotiable axis — remains essentially unchanged across rounds
4. **Expected bias**: Blind spot that *can* be corrected through other experts' feedback

#### Consistency Check (Apply in Rounds 2 & 3)

Before writing each expert's statement, self-check:
- Does this contradict the expert's **core belief / values**?
- Does it assume knowledge outside their **domain**?
- Are all 5 converging too easily? Different biases should produce different compromise points.
- Can any position change be naturally explained by the expert's persona?

### Step 2: Round 1 — Initial Proposals

Each expert independently proposes a solution (no expert has seen the others' responses). Sharply differentiate viewpoints — stay faithful to each persona.

Each expert's Round 1 proposal must contain at least one element that reflects their **Expected Bias**.

### Step 3: Round 1 Aggregation

Summarize as facilitator: shared directions, points of contention, unique perspectives. Additionally, name which **biases** were visible in the proposals.

### Step 4: Round 2 — Revised Proposals

Each expert revises based on the aggregation report:
- Build on resonant ideas from others
- Clarify stance on contentions; show willingness to compromise where persona allows
- Explicitly state what changed and why

### Step 5: Round 2 Aggregation

Same as Step 3. Additionally: comment on how opinions shifted since Round 1 (degree of convergence, which biases got corrected).

### Step 6: Round 3 — Final Proposals

Last revision. Emphasize consensus-building and feasibility. If an expert **cannot endorse** the emerging consensus, they must state their dissent and reasoning explicitly.

Each expert must state: **Bias revised** (what they corrected) and **Bias retained** (what they held firm on).

### Step 7: Final Consensus Report

Synthesize all 3 rounds into a final report. See Output Schema below for required sections.

## Quality Principles

- **Diversity**: 5 experts must hold genuinely different perspectives. If everyone says the same thing, swap in a different expert.
- **Evolution**: Opinions must visibly change across 3 rounds. Round 1 and Round 3 should look meaningfully different.
- **Anonymity**: Always use Expert A–E labels. Never use names or honorifics.
- **Evidence-based**: Every proposal must include a rationale. No vague endorsements.
- **Increasing realism**: Proposals become more feasible as rounds progress.
- **No favoritism**: Treat minority views with care.
- **Persona fidelity**: Statements must stay consistent with the 4 persona attributes. Position changes must flow naturally from who the expert is.
- **Bias arc**: The explicit tracking of bias across rounds (reflected → challenged → revised/retained) is the core intellectual contribution. Do not skip it.

## Output Method

1. Combine all steps into a single Markdown file.
2. File name: `delphi_report_{abbreviated_theme_in_english}_{YYYY-MM-DD}.md`
3. Create a `./tmp/` directory if it does not exist, then save the file there. Tell the user the file path.
4. After saving, briefly summarize key consensus points in chat (3–4 sentences max).

**Language rule**: The report content must be written in the **same language the user used**. This instruction file is in English, but if the user writes in Japanese, the entire report is in Japanese.

## Output Schema

The report file must use the following structure. All sections are required.

```
# Delphi Method Report
**Theme:** {theme}
**Date:** {YYYY-MM-DD}
**Rounds:** 3 | **Experts:** 5

## Executive Summary
{2–3 sentence overview of the key consensus and most important recommendations}

## Table of Contents
- [Expert Panel](#expert-panel)
- [Round 1: Initial Proposals](#round-1)
- [Round 1 Aggregation](#round-1-aggregation)
- [Round 2: Revised Proposals](#round-2)
- [Round 2 Aggregation](#round-2-aggregation)
- [Round 3: Final Proposals](#round-3)
- [Final Consensus Report](#final-consensus-report)

---

## Expert Panel

| Panel | Domain of Expertise | Role & Context | Core Belief / Values | Expected Bias |
|-------|-------------------|----------------|---------------------|---------------|
| Expert A | ... | ... | ... | ... |
| (B–E) | | | | |

## Round 1: Initial Proposals (Independent Responses)

### Expert A ({domain shorthand})
- **Proposal:** ...
- **Rationale:** ...
- **Bias reflected:** ...
(repeat for B–E)

## Round 1 Aggregation Report
> **Shared directions:** ...
> **Points of contention:** ...
> **Unique perspectives:** ...
> **Biases observed:** ...

## Round 2: Revised Proposals (After Aggregation Feedback)

### Expert A ({domain shorthand})
- **Revised proposal:** ...
- **Reason for change:** ...
(repeat for B–E)

## Round 2 Aggregation Report
> **Shared directions:** ...
> **Points of contention:** ...
> **Convergence since Round 1:** ...
> **Biases corrected:** ...

## Round 3: Final Proposals (Consensus-Oriented)

### Expert A
- **Final proposal:** ...
- **Bias revised:** ...
- **Bias retained:** ...
- **Dissent (if any):** ...
(repeat for B–E)

## Final Consensus Report

### Agreed Solutions
**1. {Title} ({timeframe})**
{Summary — 2–3 sentences}
(repeat for 2, 3, ...)

### Degree of Consensus
| Level | Description |
|-------|-------------|
| **Strong consensus** | ... |
| **Partial consensus** | ... |
| **Unresolved** | ... |

### Minority Position
{Any expert's dissent that was not resolved, with their reasoning. Omit section only if true unanimity.}

### Recommended Next Steps
{Concrete, actionable steps}

### Process Retrospective
{2–3 sentences: how the discussion evolved, which biases were corrected, how convergence happened}
```

## Expert Brainstorm Variant

When the user includes "brief" or "brainstorm" in their input, run this shortened variant instead of the full Delphi process. **Label the output "Expert Brainstorm", not "Delphi Method Report"** — a 1-round process is not a Delphi.

Flow: Theme → Panel assembly → Round 1 proposals → Aggregation → Summary report.

Output schema for brainstorm:

```
# Expert Brainstorm Report
**Theme:** {theme}
**Date:** {YYYY-MM-DD}
**Experts:** 5

## Expert Panel
(same table as full Delphi)

## Proposals (Independent Responses)
(same as Round 1, including Bias reflected)

## Aggregation & Summary
> **Shared directions:** ...
> **Points of contention:** ...
> **Key recommendations:** ...

## Recommended Next Steps
{Concrete, actionable steps}
```

File name: `brainstorm_report_{theme}_{YYYY-MM-DD}.md`

## Notes

- Include all steps without omission. Process transparency is essential.
- If the user requests additional rounds or a different panel composition, adapt flexibly.
- Keep the post-file chat explanation concise (3–4 sentences max).
