# Security Checklist

This document provides a comprehensive security checklist for AI-assisted development projects.

## Pre-Commit Checklist

Before committing code, verify:

- [ ] No secrets or credentials in code
- [ ] No `.env` files committed
- [ ] All user inputs are validated and sanitized
- [ ] No hardcoded passwords or API keys
- [ ] Dependencies are up-to-date and secure
- [ ] Pre-commit hooks pass successfully

## Pre-Deployment Checklist

Before deploying to production:

### Authentication & Authorization
- [ ] Passwords are hashed using secure algorithms (bcrypt, argon2)
- [ ] Session tokens are secure and HttpOnly
- [ ] API keys are stored in environment variables
- [ ] Authorization checks are implemented server-side
- [ ] Principle of least privilege is enforced

### Input Validation
- [ ] All user inputs are validated
- [ ] SQL injection prevention (parameterized queries)
- [ ] XSS prevention (output escaping)
- [ ] Command injection prevention
- [ ] Path traversal prevention

### Data Protection
- [ ] Sensitive data is encrypted at rest
- [ ] HTTPS/TLS is enforced for all communications
- [ ] Database credentials are secure
- [ ] Logs don't contain sensitive information

### Dependencies
- [ ] All dependencies are up-to-date
- [ ] No known vulnerabilities in dependencies
- [ ] Dependency versions are pinned
- [ ] Security audit completed (`npm audit`, `pip-audit`, etc.)

### Configuration
- [ ] Environment variables are used for configuration
- [ ] Default credentials are changed
- [ ] Debug mode is disabled in production
- [ ] Error messages don't expose sensitive information

### AI-Generated Code Review
- [ ] AI-generated code reviewed for security issues
- [ ] No prompt injection vulnerabilities
- [ ] External dependencies verified
- [ ] Security best practices followed

## Regular Security Audit Checklist

Perform these checks regularly (monthly or quarterly):

### Code Review
- [ ] Review recent commits for security issues
- [ ] Check for new dependencies added
- [ ] Verify security best practices are followed
- [ ] Review access control implementations

### Dependency Management
- [ ] Run security audits (`npm audit`, `pip-audit`, `safety`)
- [ ] Update dependencies with security patches
- [ ] Review and remove unused dependencies
- [ ] Check for deprecated packages

### Infrastructure
- [ ] Review server access logs
- [ ] Check for unauthorized access attempts
- [ ] Verify backup and recovery procedures
- [ ] Review firewall and network security rules

### Access Control
- [ ] Review user accounts and permissions
- [ ] Remove inactive accounts
- [ ] Verify role-based access controls
- [ ] Check for privilege escalation vulnerabilities

### Monitoring
- [ ] Security monitoring is active
- [ ] Logs are reviewed regularly
- [ ] Intrusion detection is configured
- [ ] Incident response plan is documented

## Incident Response Checklist

If a security incident occurs:

1. **Immediate Actions**
   - [ ] Isolate affected systems
   - [ ] Preserve evidence (logs, files)
   - [ ] Notify security team/lead
   - [ ] Document the incident

2. **Investigation**
   - [ ] Identify the scope of the breach
   - [ ] Determine how the breach occurred
   - [ ] Identify affected data/users
   - [ ] Review logs and access records

3. **Remediation**
   - [ ] Patch vulnerabilities
   - [ ] Change compromised credentials
   - [ ] Update security controls
   - [ ] Notify affected users (if required)

4. **Post-Incident**
   - [ ] Conduct post-mortem analysis
   - [ ] Update security procedures
   - [ ] Implement additional safeguards
   - [ ] Document lessons learned

## AI Development Specific Checks

### Prompt Security
- [ ] User inputs are sanitized before AI processing
- [ ] No prompt injection vulnerabilities
- [ ] AI outputs are validated before use
- [ ] Rate limiting is implemented for AI API calls

### Code Generation Security
- [ ] AI-generated code is reviewed before use
- [ ] No hardcoded credentials in generated code
- [ ] Generated code follows secure patterns
- [ ] Dependencies suggested by AI are verified

### Data Privacy
- [ ] No PII sent to AI services without consent
- [ ] AI service usage complies with privacy regulations
- [ ] Data retention policies are followed
- [ ] User data is anonymized when possible

## Security Tools Integration

Recommended tools for security scanning:

### Secret Detection
- `gitleaks` - Comprehensive secret scanning
- `detect-secrets` - Multi-format secret detection
- `truffleHog` - Credential scanning

### Dependency Scanning
- `npm audit` - Node.js dependency vulnerabilities
- `pip-audit` - Python dependency vulnerabilities
- `safety` - Python security checker
- `bundler-audit` - Ruby gem vulnerabilities

### Code Analysis
- `bandit` - Python security linter
- `eslint-plugin-security` - JavaScript security rules
- `semgrep` - Static analysis for security

### Container Security
- `trivy` - Container vulnerability scanner
- `docker-bench` - Docker security best practices

## Resources

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [CWE Top 25](https://cwe.mitre.org/top25/)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
- [AI Security Best Practices](https://owasp.org/www-project-top-10-for-large-language-model-applications/)

## Reporting Security Issues

If you discover a security vulnerability:

1. **DO NOT** create a public issue
2. Email security concerns to: [security@yourdomain.com]
3. Include details about the vulnerability
4. Allow time for the issue to be addressed before disclosure

---

**Last Updated**: {{DATE}}
**Version**: 1.0
