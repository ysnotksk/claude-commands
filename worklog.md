---
description: "End-of-session sign-off: update backlog + write local worklog"
allowed-tools: [Read, Write, Edit, Bash, Glob, Grep, AskUserQuestion]
---

End-of-session sign-off. This command updates the committed `.backlog/` files for AI handoff AND writes a local worklog for the human. Follow these steps in order:

---

## Phase 1: Gather Context

1. Determine the project name from the working directory (e.g., `subject-lab` from `/Users/yosh/Projects/subject-lab`).
2. Review conversation history to identify what was accomplished this session.
3. Run `git log --oneline --since="today"` to capture today's commits.
4. Read `.backlog/SESSION_LOG.md`, `.backlog/BACKLOG.md`, and `.backlog/DECISIONS.md` to understand current state. If `.backlog/` does not exist, skip Phase 2 and Phase 3 entirely — only write the local worklog (Phase 4).

---

## Phase 2: Interactive Review

Present a summary of what was accomplished, then ask the user (use AskUserQuestion):

- **New backlog items**: Anything discovered during the session that should be added?
- **Deferred items**: Anything to defer? (Must include reason + resume condition.)
- **Priority changes**: Should the "Next" section be reordered for the next session?
- **Decisions**: Any architectural or design decisions worth recording in DECISIONS.md?

Keep the questions concise. If the user says "nothing" or "looks good", proceed with just the session summary.

---

## Phase 3: Update .backlog/ Files (committed)

Based on conversation history and user answers from Phase 2:

### SESSION_LOG.md
Append a new entry:
```
## YYYY-MM-DD
- Completed: <what was finished>
- In progress: <what's partially done, with file/line refs>
- Next: <immediate next steps for the next AI session>
- Observations: <anything worth noting>
```

### BACKLOG.md
- Move completed items from "Next" or "Planned" → "Done (Recent)" with date
- Add newly discovered items to the appropriate section (Next / Planned)
- Move deferred items to "Deferred" with reason + resume condition
- Apply any priority reordering the user requested

### DECISIONS.md
Only if decisions were made this session. Append:
```
## YYYY-MM-DD: <Decision title>
- Context: <what prompted this>
- Decision: <what was chosen>
- Rationale: <why this over alternatives>
- Trade-off: <what we gave up>
```

### Commit
Stage only the `.backlog/` files and commit:
```
docs(backlog): end-of-session update YYYY-MM-DD
```
Do NOT push.

---

## Phase 4: Write Local Worklog (not committed)

1. Read or create `~/.claude/worklogs/<project-name>.md` (header: `# <Project Name> — Work Log`).
2. Append a new entry under `## YYYY-MM-DD`:
   - What was done (grouped by theme, not chronological)
   - Commits (hash + message)
   - Local/draft artifacts created (if any)
   - Key decisions or discussions (if any)
3. Keep it concise — bullet points, one line each.
4. Do NOT stage or commit the worklog. It stays local.
