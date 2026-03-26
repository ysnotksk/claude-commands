---
description: "Simulate the Delphi method to generate improvement or solution proposals for a given theme or challenge"
argument-hint: "<theme or challenge> [rounds:N]"
allowed-tools: [Write, AskUserQuestion, Agent, WebFetch, WebSearch]
---

# Delphi Method Skill

Simulate the Delphi method — an iterative, anonymous expert feedback process — to produce high-quality improvement or solution proposals for any theme or challenge the user presents. Each expert runs as an isolated agent to enforce genuine independence: within a round, no expert sees any other expert's response; between rounds, experts receive only the facilitator's anonymized aggregation. This prevents authority bias and bandwagon effects.

## Mode Detection

1. If the user's input contains "brief" or "brainstorm", run the **Expert Brainstorm** variant (see below).
2. Otherwise, check for a round count in the user's input (e.g., "5 rounds", "rounds:4", "4R"). Valid range: **2–7**. Real Delphi studies typically use 2–4 rounds; more than 7 yields diminishing returns.
3. If no round count is specified, default to **3 rounds**.

## Overall Flow (Full Delphi)

```
Main: Theme + Panel assembly
  For each round K (1 to N):
    → 5 Expert Agents in parallel   (each receives ONLY own persona + prior aggregations)
    → 1 Facilitator Agent           (receives all 5 proposals → produces anonymous aggregation)
  [Final round: skip Facilitator — main context synthesizes]
Main: Final Consensus Report → Write file
```

**Independence guarantees:**
- **Intra-round:** Each expert runs as a separate agent and receives only their own persona. They never see other experts' personas or proposals.
- **Inter-round:** Experts receive only the facilitator's anonymized aggregation from prior rounds — never raw proposals.

Agent count per N rounds: `5 × N` expert agents + `(N-1)` facilitator agents.

## Step-by-Step Instructions

### Step 0: Theme Exploration and Scoping

Before launching the expensive multi-agent process, conduct a structured exploration of the theme with the user. This step is **mandatory** — never skip it, even if the theme appears clear.

1. **Identify the core question.** Restate the user's theme as a specific, actionable research question. Present it to the user for confirmation.

2. **Ask up to 3 scoping questions** using AskUserQuestion. Focus on:
   - **Context:** The user's organizational setting, industry, scale, and current state (e.g., "What is your current evaluation system, and what pain points are you experiencing?")
   - **Focus:** Which aspects of the theme matter most to them (e.g., legal risk, operational design, cultural change, cost)
   - **Outcome:** What they intend to do with the Delphi output (e.g., executive proposal, policy draft, academic analysis, brainstorming)

3. **Refine the research question** based on the user's answers. A well-scoped question produces dramatically better expert proposals.

4. **Determine the round count** per Mode Detection rules.

5. **Present the refined question and round count** to the user. Proceed only after confirmation.

If the user explicitly says "just run it" or provides a highly specific, narrow question with clear context, you may abbreviate this step — but still restate the question for confirmation before proceeding.

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

Define 5 attributes per expert — these govern all statements across every round:

1. **Domain of expertise**: What they are an expert in
2. **Role & context**: Organization or setting they work in
3. **Core belief / values**: Non-negotiable axis — remains essentially unchanged across rounds
4. **Expected bias**: Blind spot that *can* be corrected through other experts' feedback
5. **Reasoning style**: How they build arguments (e.g., data-driven, analogy-based, principles-first, case-study-oriented, risk-focused)

### Step 2: For Each Round — Spawn 5 Expert Agents in Parallel

For each round K (from 1 to N):

1. **Spawn 5 Expert Agents in parallel** (one per expert). Each agent receives:
   - The theme
   - **Only their own persona** (NOT the other 4 experts' personas)
   - If K = 1: no prior context (first round)
   - If K > 1 and K < N: all prior Aggregation Reports (Rounds 1 through K-1) + **this expert's own proposals from all prior rounds**
   - If K = N: all prior Aggregation Reports + this expert's own prior proposals + final-round instructions (bias arc, dissent)
   - The appropriate Expert Agent Prompt template (First / Middle / Final)

2. **CRITICAL independence rules:**
   - Each expert agent receives ONLY their own persona — never the full panel table.
   - No expert agent receives any other expert's proposals from the current or prior rounds.
   - Each expert DOES receive their **own** prior proposals (for continuity of their reasoning).
   - The only cross-expert information that reaches an expert is the facilitator's anonymized aggregation.

3. Collect all 5 expert responses.

### Step 3: After Each Round (Except Final) — Spawn Facilitator Agent

After collecting all 5 expert proposals for round K (where K < N):

1. **Spawn 1 Facilitator Agent**. It receives:
   - All 5 expert proposals from round K (with Expert A–E labels for identification)
   - The Facilitator Agent Prompt template
   - If K > 1: prior Aggregation Reports (for continuity of analysis)

2. The Facilitator produces the Round K Aggregation Report — anonymized, with no Expert A–E labels.

3. **Verify the aggregation** before passing it to the next round. The main orchestrator checks:
   - **Anonymity:** Does the aggregation contain any Expert A–E labels? If yes, re-invoke the facilitator with a correction instruction.
   - **Coverage:** Does it reference themes from all 5 proposals (not necessarily individually, but no proposal should be entirely unrepresented)? If a proposal was dropped, flag it.
   - **Accuracy:** If the aggregation claims "N of 5 panelists supported X," spot-check against the actual proposals. Correct any miscount.

4. Save the verified Aggregation Report to pass to the next round's expert agents.

**Skip this step after the final round** — the main context handles the Final Consensus Report.

### Step 4: Final Consensus Report

In the main context, you now have:
- All expert proposals from every round (from the expert agents)
- All aggregation reports (from the facilitator agents)

Synthesize into the Final Consensus Report following the Output Schema.

### Step 5: Write Report

Compile all sections into a single Markdown file and save to `./tmp/`. Briefly summarize key consensus points in chat (3–4 sentences max).

### Error Handling

- **Expert agent failure:** Retry once with the same prompt. If the retry fails, proceed with 4 experts for that round and adjust the facilitator's instructions to note "4 of 5 panelists responded in this round."
- **WebSearch/WebFetch failure within an expert agent:** The expert should proceed with training-data-based reasoning and note in their output: "Web search was unavailable; sources are based on prior knowledge and should be independently verified."
- **Facilitator agent failure:** Retry once. If the retry fails, the main orchestrator produces the aggregation directly from the expert proposals, following the same anonymity rules.
- **Aggregation verification failure** (Step 3): Re-invoke the facilitator with a correction instruction specifying the violation. If the second attempt also fails, the main orchestrator corrects the aggregation manually.

## Agent Prompt Templates

### Expert Agent Prompt — First Round

Use for each of the 5 experts in Round 1. Each expert receives ONLY their own persona.

```
You are an expert participating in a Delphi method study. You are responding independently. You do NOT know who the other panelists are or what they have said.

## Theme
{theme}

## Your Persona
- **Domain of expertise:** {this expert's domain}
- **Role & context:** {this expert's role}
- **Core belief / values:** {this expert's core belief}
- **Expected bias:** {this expert's expected bias}
- **Reasoning style:** {this expert's reasoning style}

## Instructions
Propose a solution to the theme based on your expertise. Stay faithful to your persona's domain, core belief, and reasoning style. Your proposal must contain at least one element that reflects your Expected Bias.

**Research requirement:** Use WebSearch and WebFetch to ground your proposal in real evidence. To save tokens, follow these rules:
- **Limit searches to 2-3 targeted queries max.** Do not explore broadly — search only for the most critical evidence gap in your proposal.
- **Trusted sources only.** Restrict to: government/official sites (.go.jp, .gov), academic publishers (springer, wiley, oecd.org), established research institutes (RIETI, SHRM, Deloitte, McKinsey), major media (nikkei, NHK). Do not fetch blog posts, SEO content farms, or unverified sources.
- **Fetch only what you will cite.** Do not speculatively fetch pages to "see what's there." Each WebFetch must result in a cited source in your output.
- Do not fabricate citations. If search yields nothing useful, state that and proceed with your expertise.

## Output format
- **Proposal:** {your proposed solution}
- **Rationale:** {why this approach, grounded in your reasoning style, with real sources}
- **Bias reflected:** {which element of your proposal reflects your expected bias, and why}
- **Sources consulted:**
  - [URL]: {what was found and how it informed your proposal}
  - (minimum 1 source. If web search returned no useful results, state what you searched for and why results were insufficient.)
```

### Expert Agent Prompt — Middle Round

Use for each of the 5 experts in Rounds 2 through N-1.

```
You are an expert participating in Round {K} of a Delphi method study. You are responding independently. You do NOT know who the other panelists are. You have NOT seen their individual proposals — only the facilitator's anonymized summaries below.

## Theme
{theme}

## Your Persona
- **Domain of expertise:** {this expert's domain}
- **Role & context:** {this expert's role}
- **Core belief / values:** {this expert's core belief}
- **Expected bias:** {this expert's expected bias}
- **Reasoning style:** {this expert's reasoning style}

## Your Own Prior Proposals
{paste this expert's own proposals from all prior rounds — this is YOUR previous work, not other panelists'}

## Facilitator's Aggregation Reports from Prior Rounds
{paste ALL aggregation reports from Rounds 1 through K-1}

## Instructions
Revise YOUR OWN prior position based on the facilitator's aggregation reports:
- Build on resonant ideas surfaced in the aggregations
- Clarify your stance on points of contention
- Show willingness to compromise where your persona allows
- Explicitly state what changed and why
- If you see a dropped perspective from a prior round that still has merit, you may revive it

**Research requirement:** Use WebSearch and WebFetch to find real evidence that supports or challenges positions in the aggregation. To save tokens:
- **Limit to 1-2 targeted queries.** Search only for the strongest evidence gap in your revision — not everything.
- **Trusted sources only:** government (.go.jp, .gov), academic publishers, established research institutes, major media. No blog posts or SEO content.
- **Fetch only what you will cite.** Do not fabricate citations.

## Output format
- **Revised proposal:** {your updated solution, with real sources}
- **Reason for change:** {what specifically in the aggregation prompted this revision}
- **Sources consulted:**
  - [URL]: {what was found and how it informed your revision}
  - (minimum 1 source. If web search returned no useful results, state what you searched for.)
```

### Expert Agent Prompt — Final Round

Use for each of the 5 experts in Round N.

```
You are an expert participating in Round {N} (FINAL round) of a Delphi method study. You are responding independently. You do NOT know who the other panelists are. You have NOT seen their individual proposals — only the facilitator's anonymized summaries below.

## Theme
{theme}

## Your Persona
- **Domain of expertise:** {this expert's domain}
- **Role & context:** {this expert's role}
- **Core belief / values:** {this expert's core belief}
- **Expected bias:** {this expert's expected bias}
- **Reasoning style:** {this expert's reasoning style}

## Your Own Prior Proposals
{paste this expert's own proposals from all prior rounds — this is YOUR previous work, not other panelists'}

## Facilitator's Aggregation Reports from Prior Rounds
{paste ALL aggregation reports from Rounds 1 through N-1}

## Instructions
This is your final revision of YOUR OWN position. Emphasize consensus-building and feasibility. If you cannot endorse the emerging consensus, state your dissent and reasoning explicitly.

You must state:
- **Bias revised:** what you corrected from your initial stance, and why
- **Bias retained:** what you held firm on, and why

**Research requirement:** Use WebSearch and WebFetch to find real evidence that supports your final position or challenges the consensus. To save tokens:
- **Limit to 1-2 targeted queries.** Final round focuses on consensus-building, not new research. Search only if a critical claim needs verification.
- **Trusted sources only:** government (.go.jp, .gov), academic publishers, established research institutes, major media. No blog posts or SEO content.
- **Fetch only what you will cite.** Do not fabricate citations. It is acceptable to cite no new sources if your prior rounds already established sufficient evidence.

## Output format
- **Final proposal:** {your final solution, with real sources}
- **Bias revised:** {what you corrected and why}
- **Bias retained:** {what you held firm on and why}
- **Dissent (if any):** {areas where you cannot endorse the emerging consensus}
- **Sources consulted:**
  - [URL]: {what was found and how it informed your final position}
  - (minimum 1 source. If web search returned no useful results, state what you searched for.)
```

### Facilitator Agent Prompt

Use after each round (except the final round) to produce the anonymized aggregation.

```
You are a Delphi method facilitator. You have received 5 independent expert proposals. Your job is to produce an anonymized aggregation report that will be shared with the experts for the next round.

CRITICAL ANONYMITY RULE: Your aggregation must NOT attribute views to specific experts by label (no Expert A/B/C). Present all findings as unattributed themes, counts, and patterns. Use language like "one panelist proposed…", "a minority view held…", "several experts emphasized…", "3 of 5 panelists supported…".

## Expert Proposals Received
{paste all 5 expert proposals, labeled Expert A through E for your reference only}

{if round > 1: ## Prior Aggregation Reports
{paste prior aggregation reports for continuity of analysis}}

## Aggregation Instructions
Summarize: shared directions, points of contention, unique perspectives, and which bias patterns were visible. {if round > 1: Also comment on how opinions shifted since the previous round using aggregate language, and note any perspectives from prior rounds that were dropped.}

## Output format
## Round {K} Aggregation Report
> *(This section must not attribute views to specific experts by label.)*
> **Shared directions:** {themes that multiple panelists converged on}
> **Points of contention:** {opposing positions without attribution}
> **Unique perspectives:** {novel ideas without identifying their source}
> **Biases observed:** {bias patterns in aggregate}
> **Key evidence cited:** {specific data points, statistics, case studies, or sources mentioned by panelists, without attribution — e.g., "One panelist cited a study showing 37% bias reduction; another referenced EU AI Act Article 14." Preserve URLs where provided.}
{if round > 1:
> **Convergence since previous round:** {shifts using counts and proportions}
> **Biases corrected:** {which bias patterns diminished, in aggregate}
> **Dropped perspectives:** {ideas from prior rounds that no panelist carried forward}}
```

## Quality Principles

- **Intra-round independence**: Each expert runs as a separate agent receiving only their own persona. No expert sees another expert's response within the same round.
- **Inter-round independence**: Experts for Rounds 2+ receive ONLY the facilitator's anonymized aggregation — never raw proposals from prior rounds.
- **Anonymity**: The facilitator's aggregation reports never attribute opinions to specific expert labels. Expert A–E labels appear only in per-expert proposal sections of the final report.
- **Diversity**: 5 experts must hold genuinely different perspectives. If everyone says the same thing, swap in a different expert.
- **Evolution**: Opinions must visibly change across rounds. Round 1 and the final round should look meaningfully different.
- **Voice distinctiveness**: Different reasoning styles should produce noticeably different argument structures.
- **Evidence-based**: Every proposal must include a rationale. No vague endorsements.
- **Increasing realism**: Proposals become more feasible as rounds progress.
- **No favoritism**: Treat minority views with care.
- **Persona fidelity**: Statements must stay consistent with the 5 persona attributes. Position changes must flow naturally from who the expert is.
- **Bias arc**: The explicit tracking of bias across rounds (reflected → challenged → revised/retained) is the core intellectual contribution. Do not skip it. Example: "Bias reflected: Proposed removing all error handling (over-optimizes for simplicity)" → "Bias revised: Accepted validation at system boundaries after aggregation highlighted user-facing failure modes."

## Output Method

1. Combine all steps into a single Markdown file.
2. File name: `delphi_report_{abbreviated_theme_in_english}_{YYYY-MM-DD}.md`
3. Create a `./tmp/` directory if it does not exist, then save the file there. Tell the user the file path.
4. After saving, briefly summarize key consensus points in chat (3–4 sentences max).

**Language rule**: The report content must be written in the **same language the user used**. This instruction file is in English, but if the user writes in Japanese, the entire report is in Japanese.

## Output Schema

The report file must use the following structure. Repeat round sections for each round (1 through N).

```
# Delphi Method Report
**Theme:** {theme}
**Date:** {YYYY-MM-DD}
**Rounds:** {N} | **Experts:** 5

## Executive Summary
{2–3 sentence overview of the key consensus and most important recommendations}

## Quick Summary
{3–5 bullet points of key recommendations with anchor links to Agreed Solutions}

## Table of Contents
- [Expert Panel](#expert-panel)
- [Round 1: Initial Proposals](#round-1)
- [Round 1 Aggregation](#round-1-aggregation)
{repeat for each middle round}
- [Round {N}: Final Proposals](#round-{N})
- [Final Consensus Report](#final-consensus-report)

---

## Expert Panel

| Panel | Domain of Expertise | Role & Context | Core Belief / Values | Expected Bias | Reasoning Style |
|-------|-------------------|----------------|---------------------|---------------|-----------------|
| Expert A | ... | ... | ... | ... | ... |
| (B–E) | | | | | |

## Round 1: Initial Proposals (Independent Responses)

### Expert A ({domain shorthand})
- **Proposal:** ...
- **Rationale:** ...
- **Bias reflected:** ...
(repeat for B–E)

## Round 1 Aggregation Report
> *(This section must not attribute views to specific experts by label.)*
> **Shared directions:** {themes and proposals that multiple panelists converged on}
> **Points of contention:** {opposing positions described without attribution}
> **Unique perspectives:** {novel ideas summarized without identifying their source}
> **Biases observed:** {bias patterns described in aggregate}

## Round {K}: Revised Proposals (After Aggregation Feedback)
{repeat this section + aggregation for each middle round K from 2 to N-1}

### Expert A ({domain shorthand})
- **Revised proposal:** ...
- **Reason for change:** ...
(repeat for B–E)

## Round {K} Aggregation Report
> *(This section must not attribute views to specific experts by label.)*
> **Shared directions:** {updated themes after revision}
> **Points of contention:** {remaining disagreements described without attribution}
> **Convergence since previous round:** {describe shifts using counts and proportions}
> **Biases corrected:** {which bias patterns diminished or disappeared, described in aggregate}
> **Dropped perspectives:** {ideas from prior rounds that no panelist carried forward}

## Round {N}: Final Proposals (Consensus-Oriented)

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
{Any expert's dissent that was not resolved, with their reasoning. If all experts converged, state the strongest possible dissent that was NOT raised and why it could be compelling.}

### Strongest Counter-Argument
{The facilitator's articulation of the most compelling opposing view to the overall consensus, even if no expert holds it. This prevents uncritical consensus.}

### Recommended Next Steps
{Concrete, actionable steps}

### Process Retrospective
{2–3 sentences: how the discussion evolved, which biases were corrected, how convergence happened}
```

## Expert Brainstorm Variant

When the user includes "brief" or "brainstorm" in their input, run this shortened variant instead of the full Delphi process. **Label the output "Expert Brainstorm", not "Delphi Method Report"** — a 1-round process is not a Delphi.

For the brainstorm variant, **spawn 5 Expert Agents in parallel** (same independence guarantee as the full Delphi), then aggregate in the main context.

For the brainstorm variant, abbreviate Step 0: restate the research question and confirm with the user, but skip the detailed scoping questions. The brainstorm is designed for quick exploration, not deep analysis.

Flow: Theme confirmation → Panel assembly → 5 Expert Agents in parallel → Aggregation → Summary report.

Output schema for brainstorm:

```
# Expert Brainstorm Report
**Theme:** {theme}
**Date:** {YYYY-MM-DD}
**Experts:** 5

## Expert Panel
(same table as full Delphi, including Reasoning Style column)

## Proposals (Independent Responses)
(same as Round 1, including Bias reflected)

## Aggregation & Summary
> *(Summarize as unattributed themes — do not reference specific expert labels.)*
> **Shared directions:** ...
> **Points of contention:** ...
> **Key recommendations:** ...

## Recommended Next Steps
{Concrete, actionable steps}
```

File name: `brainstorm_report_{theme}_{YYYY-MM-DD}.md`

## Notes

- Include all steps without omission. Process transparency is essential.
- If the user requests a different panel composition, adapt flexibly.
- Keep the post-file chat explanation concise (3–4 sentences max).
