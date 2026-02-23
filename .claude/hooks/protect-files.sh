#!/bin/bash
# Claude Code PreToolUse Hook: Protect critical files from accidental modification
# Triggered before Edit or Write operations.
# Input: JSON on stdin with tool_input.file_path
# Exit: 0 = allow, 2 = block (message on stderr)

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
[ -z "$FILE_PATH" ] && exit 0

BASENAME=$(basename "$FILE_PATH")

# --- Block: environment / secret files ---
case "$FILE_PATH" in
  *.env|*.env.*|*/.env|*/.env.*)
    echo "BLOCKED: Cannot edit .env files. Use .env.example instead." >&2
    exit 2
    ;;
esac

# --- Block: lock files ---
case "$BASENAME" in
  package-lock.json|yarn.lock|pnpm-lock.yaml|poetry.lock|Pipfile.lock|Cargo.lock|go.sum|Gemfile.lock|composer.lock)
    echo "BLOCKED: Cannot edit lock files directly. Use package manager commands." >&2
    exit 2
    ;;
esac

# --- Block: certificate / key files ---
case "$BASENAME" in
  *.pem|*.key|*.crt|*.p12|*.pfx|*.jks|*.keystore)
    echo "BLOCKED: Cannot edit certificate/key files." >&2
    exit 2
    ;;
esac

# --- Block: git internals ---
case "$FILE_PATH" in
  */.git/*)
    echo "BLOCKED: Cannot edit .git internals." >&2
    exit 2
    ;;
esac

exit 0
