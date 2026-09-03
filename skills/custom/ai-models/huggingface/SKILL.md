---
name: huggingface
description: Discover, compare, run, publish, and troubleshoot Hugging Face models, datasets, and Spaces with compatibility, authentication, reproducibility, and safety checks. Use for Hub searches, local inference, gated assets, uploads, fine-tuning preparation, or Hugging Face Python and CLI errors.
---

# Hugging Face

## Workflow

1. Read `STATE.md`; reset it from `references/template/STATE.template.md` for a
   new run. Classify the request as discovery, local inference, authentication,
   publishing, training preparation, or troubleshooting.
2. Read only the matching domain reference:
   - `references/discovery.md` for model, dataset, or Space selection.
   - `references/inference.md` for local inference.
   - `references/auth.md` for private or gated access.
   - `references/publish.md` for uploads.
   - `references/troubleshooting.md` for errors.
3. Inspect the actual runtime, package versions, hardware, authentication state,
   and requested asset metadata before proposing or running a command.
4. Execute the smallest reproducible workflow that satisfies the request. Use
   `$download-models` for managed long-running model downloads when available.
5. Validate model or dataset identity, task compatibility, revision, output
   shape or files, and authorization scope as applicable.
6. Record commands, assumptions, artifacts, validation, and unresolved issues
   in `STATE.md`.

## Rules

- Never print or persist raw access tokens.
- Pin revisions when reproducibility matters.
- Do not install missing dependencies unless the user explicitly requests
  environment setup; follow the target project's dependency policy.
- Get explicit confirmation before publishing or overwriting remote Hub assets.

## Output

Return concise results with exact commands used, verified artifact identifiers,
environment assumptions, and the next diagnostic step when unresolved.
