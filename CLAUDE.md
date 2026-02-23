# claude-commands

> Source of truth: `docs/00_tech_stack.md` | Security: `docs/SECURITY_GUIDELINES.md`

## Project

- **Stack**: {{TECH_STACK}}
- **Description**: {{PROJECT_DESCRIPTION}}

## Commands

```sh
# Development
{{DEV_COMMAND}}

# Build
{{BUILD_COMMAND}}

# Test
{{TEST_COMMAND}}

# Lint / Format
{{LINT_COMMAND}}
```

## Process

### Phase 0: Discovery & Planning (MANDATORY)
- **Trigger**: New project, new feature, or missing documentation.
- BEFORE writing any code:
    1. Review `docs/00_tech_stack.md` and `README.md`.
    2. If empty or generic, ask user for specs.
    3. Draft Overview, Tech Stack, Key Features into `docs/00_tech_stack.md`.
    4. Create a Todo list. WAIT for user approval.

### Phase 1: Implementation
- Analyze (align with tech stack) → Security Scan → Plan → Execute.
- Keep `docs/00_tech_stack.md` updated as source of truth.
- No new packages without explicit justification and user approval.

## References

- Security guidelines: `docs/SECURITY_GUIDELINES.md`
- Best practices: `docs/BEST_PRACTICES.md`
- Security checklist: `docs/SECURITY.md`
