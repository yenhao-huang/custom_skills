---
name: gitea
description: >
  Configure persistent credentials and create or update issues on Wingene's
  internal Gitea. Use when the user mentions Gitea credentials, Gitea token,
  origin issue, opening an issue on origin, or the Gitea host
  192.168.1.76:3000.
---

# Gitea

Use this skill for the repository's internal Gitea authentication and issue
workflow.

## Required Reference

Before changing credential configuration or creating an issue, read
`references/gitea-workflow.md` completely.

## Workflow

1. Resolve the target from `git remote get-url origin`; do not silently use
   `upstream`.
2. Inspect the configured credential helper without printing credentials.
3. When the user asks for permanent credentials, apply the documented
   `credential.helper store` flow and warn that it stores the token in
   plaintext with user-only file permissions.
4. Before creating an issue, search open and closed issues for the exact title
   or an obvious equivalent.
5. Create the issue only when the user has requested that external write.
6. Verify the resulting issue number and URL.
7. Handle attachments according to the detected Gitea API version. Do not
   create repository commits, releases, or external uploads merely to host an
   issue image unless the user authorizes that extra write.

## Security Rules

- Never print, log, commit, or return a password or access token.
- Read secrets with hidden terminal input.
- Pass credentials to `git credential approve` through standard input.
- Retrieve credentials with `git credential fill` only inside a process that
  does not echo its output.
- Do not place tokens directly in a remote URL or shell command shown to the
  user.
- Stage and commit only the requested repository files; credential storage is
  outside the repository.

## Output

Report:

- The credential helper mode when it was changed.
- The issue number and URL when an issue was created or found.
- Whether an attachment was added, or the exact compatibility blocker.
