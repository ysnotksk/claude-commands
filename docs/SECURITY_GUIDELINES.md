# Security Guidelines for AI-Assisted Development

This document provides comprehensive security guidelines specifically tailored for AI-assisted development workflows.

## Table of Contents

1. [AI-Specific Security Concerns](#ai-specific-security-concerns)
2. [Common Vulnerabilities and Mitigations](#common-vulnerabilities-and-mitigations)
3. [Secure Coding Practices](#secure-coding-practices)
4. [Incident Response](#incident-response)
5. [Best Practices](#best-practices)

## AI-Specific Security Concerns

### Prompt Injection

**Risk**: Attackers can manipulate AI prompts to execute unauthorized actions or extract sensitive information.

**Mitigation**:
- Always sanitize user inputs before passing to AI models
- Use parameterized prompts instead of string concatenation
- Implement input validation and whitelisting
- Separate user data from system prompts
- Monitor AI outputs for suspicious patterns

**Example - Bad**:
```python
# ❌ Vulnerable to prompt injection
user_input = request.get("query")
prompt = f"Process this: {user_input}"
response = ai_model.generate(prompt)
```

**Example - Good**:
```python
# ✅ Safe: Input validation and sanitization
user_input = sanitize_input(request.get("query"))
if not validate_input(user_input):
    raise ValueError("Invalid input")
prompt = template.format(user_query=user_input)
response = ai_model.generate(prompt)
```

### AI-Generated Code Verification

**Risk**: AI may generate code with security vulnerabilities or malicious patterns.

**Mitigation**:
- Always review AI-generated code before committing
- Run security scans on AI-generated code
- Test AI-generated code thoroughly
- Verify that security best practices are followed
- Never blindly trust AI suggestions for security-critical code

**Checklist**:
- [ ] Code follows secure coding patterns
- [ ] No hardcoded credentials
- [ ] Input validation is present
- [ ] Output sanitization is implemented
- [ ] Dependencies are secure and necessary
- [ ] Error handling doesn't expose sensitive information

### External Resource Dependencies

**Risk**: AI may suggest external resources (APIs, libraries) that are malicious or insecure.

**Mitigation**:
- Verify all external dependencies before use
- Check package integrity and signatures
- Review dependency licenses
- Use trusted package registries
- Regularly audit dependencies for vulnerabilities

## Common Vulnerabilities and Mitigations

### SQL Injection

**Prevention**:
- Use parameterized queries/prepared statements
- Never concatenate user input into SQL queries
- Validate and sanitize all inputs
- Use ORM frameworks with built-in protection

**Example**:
```python
# ❌ Vulnerable
query = f"SELECT * FROM users WHERE id = {user_id}"

# ✅ Safe
query = "SELECT * FROM users WHERE id = ?"
cursor.execute(query, (user_id,))
```

### Cross-Site Scripting (XSS)

**Prevention**:
- Escape HTML entities in output
- Use Content Security Policy (CSP)
- Validate and sanitize user input
- Use framework-specific sanitization functions

**Example**:
```javascript
// ❌ Vulnerable
element.innerHTML = userInput;

// ✅ Safe
element.textContent = userInput;
// or
element.innerHTML = escapeHtml(userInput);
```

### Command Injection

**Prevention**:
- Avoid executing system commands with user input
- Use safe APIs instead of shell commands
- Validate and sanitize input if commands are necessary
- Use whitelist validation for command arguments

**Example**:
```python
# ❌ Vulnerable
os.system(f"rm {filename}")

# ✅ Safe
if filename in allowed_files:
    os.remove(filename)
```

### Path Traversal

**Prevention**:
- Validate file paths
- Prevent directory traversal (`../`)
- Use canonical paths
- Restrict access to allowed directories

**Example**:
```python
# ❌ Vulnerable
file_path = user_input
with open(file_path, 'r') as f:
    content = f.read()

# ✅ Safe
file_path = os.path.normpath(user_input)
if not file_path.startswith(allowed_directory):
    raise ValueError("Invalid path")
with open(file_path, 'r') as f:
    content = f.read()
```

## Secure Coding Practices

### Input Validation

**Always validate**:
- Data type (string, number, email, URL)
- Length (min/max)
- Format (regex patterns)
- Range (for numbers)
- Special characters

**Example**:
```python
def validate_email(email):
    if not isinstance(email, str):
        raise TypeError("Email must be a string")
    if len(email) > 254:
        raise ValueError("Email too long")
    if not re.match(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', email):
        raise ValueError("Invalid email format")
    return email
```

### Output Sanitization

**Always sanitize**:
- HTML output (escape entities)
- Log output (mask sensitive data)
- Error messages (don't expose internals)
- API responses (filter sensitive fields)

**Example**:
```python
def sanitize_for_log(data):
    """Mask sensitive information in logs"""
    sensitive_keys = ['password', 'token', 'api_key', 'secret']
    sanitized = data.copy()
    for key in sensitive_keys:
        if key in sanitized:
            sanitized[key] = '***MASKED***'
    return sanitized
```

### Authentication & Authorization

**Best Practices**:
- Hash passwords with secure algorithms (bcrypt, argon2)
- Use secure session management
- Implement proper token-based authentication
- Verify authorization on server-side
- Use principle of least privilege

**Example**:
```python
import bcrypt

def hash_password(password):
    salt = bcrypt.gensalt()
    return bcrypt.hashpw(password.encode(), salt)

def verify_password(password, hashed):
    return bcrypt.checkpw(password.encode(), hashed)
```

### Dependency Management

**Best Practices**:
- Pin dependency versions (use lock files)
- Regularly update dependencies
- Audit dependencies for vulnerabilities
- Review dependency licenses
- Remove unused dependencies

**Tools**:
- `npm audit` for Node.js
- `pip-audit` or `safety` for Python
- `bundler-audit` for Ruby

## Incident Response

### Immediate Actions

1. **Isolate**: Disconnect affected systems from network
2. **Preserve**: Save logs, files, and evidence
3. **Notify**: Alert security team immediately
4. **Document**: Record all actions taken

### Investigation Steps

1. Identify scope of breach
2. Determine attack vector
3. Identify affected data/users
4. Review logs and access records
5. Assess damage

### Remediation

1. Patch vulnerabilities
2. Change compromised credentials
3. Update security controls
4. Notify affected users (if required)
5. Implement additional safeguards

### Post-Incident

1. Conduct post-mortem analysis
2. Update security procedures
3. Document lessons learned
4. Train team on new procedures

## Best Practices

### Development Workflow

1. **Pre-commit**: Run security checks before committing
2. **Code Review**: Review AI-generated code for security issues
3. **Testing**: Test security controls regularly
4. **Monitoring**: Monitor for security events
5. **Updates**: Keep dependencies and tools updated

### AI Code Generation

1. **Review**: Always review AI-generated code
2. **Test**: Test AI-generated code thoroughly
3. **Verify**: Verify security best practices are followed
4. **Document**: Document AI-generated code changes
5. **Audit**: Regular security audits of AI-generated code

### Secret Management

1. **Never commit**: Never commit secrets to version control
2. **Environment variables**: Use environment variables for secrets
3. **Secret management**: Use secret management tools (Vault, AWS Secrets Manager)
4. **Rotation**: Rotate secrets regularly
5. **Access control**: Limit access to secrets

### Monitoring & Logging

1. **Log security events**: Log authentication, authorization, and security events
2. **Monitor anomalies**: Monitor for unusual patterns
3. **Alert on issues**: Set up alerts for security issues
4. **Review logs**: Regularly review security logs
5. **Mask sensitive data**: Never log sensitive information

## Resources

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [OWASP AI Security](https://owasp.org/www-project-top-10-for-large-language-model-applications/)
- [CWE Top 25](https://cwe.mitre.org/top25/)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
- [CISA Secure Coding Practices](https://www.cisa.gov/secure-coding-practices)

## Reporting Security Issues

If you discover a security vulnerability:

1. **DO NOT** create a public issue
2. Email security concerns to: [security@yourdomain.com]
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)
4. Allow reasonable time for remediation before disclosure

---

**Last Updated**: {{DATE}}
**Version**: 1.0




