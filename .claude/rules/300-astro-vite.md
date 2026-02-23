---
paths:
  - "**/*.astro"
  - "astro.config.*"
  - "vite.config.*"
---
# Astro / Vite Debugging

## Module Resolution Errors
When `Could not resolve`, `Cannot find module`, or `ENOENT`:
1. **File existence**: `git ls-files | grep "target/file"` — is it tracked?
2. **.gitignore check**: `git check-ignore -v path/to/file` — is it excluded?
3. **Module config**: Check `tsconfig.json` paths, `vite.config` resolve.alias, resolve.extensions.
4. **Import paths**: Verify relative paths, extensions, aliases.

## CI/CD vs Local Differences
When local succeeds but CI/CD fails:
1. File existence (most common — check git tracking first).
2. Environment variables in CI/CD.
3. `package-lock.json` committed?
4. Node.js version parity.
5. Build root directory setting.
6. Stale cache — clear and rebuild.

## Best Practices
- Use explicit extensions in imports (e.g., `@/lib/api.ts` not `@/lib/api`).
- Beware broad `.gitignore` patterns (`lib/`) that exclude source directories.
- Keep `tsconfig.json` paths and `vite.config` aliases in sync.
