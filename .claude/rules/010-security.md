# Security Rules

Ref: `docs/SECURITY_GUIDELINES.md`

- **Credentials**: NEVER hardcode secrets. Use `.env` + `.env.example`.
- **Input**: Validate/sanitize all inputs (type, length, format). Prevent SQLi, XSS, Cmd Injection, Path Traversal.
- **Output**: Mask sensitive data in logs/errors. Escape HTML. Generic user errors only.
- **Dependencies**: Pin versions. Verify integrity. User approval for new packages. No known CVEs.
- **AI-Security**: Parameterized prompts only. Sanitize inputs to AI. Verify AI-generated code.
- **Auth**: Secure hashing (bcrypt/argon2). HttpOnly cookies. JWT validation. RBAC/Least Privilege.
- **Protection**: HTTPS/TLS always. Encryption at rest for sensitive data.
