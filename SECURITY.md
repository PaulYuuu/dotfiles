# Security Policy

## Reporting a Vulnerability

If you discover a security issue, please contact me privately rather than opening a public issue.

## Security Considerations

### Encrypted Files

- This repository uses [age](https://age-encryption.org/) encryption for sensitive files
- Private keys are stored locally and never committed
- Encrypted files have `.age` extension

### Best Practices

- Never commit unencrypted secrets or API keys
- Use `.chezmoiignore` for files that shouldn't be synced
- Keep age identity files backed up separately
- Review diffs before applying changes with `chezmoi diff`
