# Authentication

Use the existing Hugging Face login or `HF_TOKEN` environment integration.
Never place tokens in a command argument, code snippet, tracked file, log, or
response.

## Failure Checks

- `401` or `403` on gated assets: confirm access approval and token scope.
- Push denied: confirm write scope and owner namespace.
- CI: use a secret-backed environment value, not hardcoded text.

Redact token-like strings before showing logs. Authentication repair should
change only the intended credential store.
