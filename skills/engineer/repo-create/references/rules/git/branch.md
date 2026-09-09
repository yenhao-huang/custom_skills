# Target Repository Branch Rules

Use this reference when writing `docs/rules/git/branch.md`.

- Inspect the actual default branch, remotes, protection rules, and contribution
  docs before choosing a base. Do not invent a `dev` branch or a deployment flow.
- Document the repository's branch roles and task-branch naming convention.
  Use one non-default branch per logical change or issue; reuse an existing
  branch and PR for follow-up fixes.
- For concurrent work, use a dedicated worktree or checkout outside another
  contributor's active checkout. Check for an existing issue worktree before
  creating another, and verify `git rev-parse --show-toplevel` and the current
  branch before editing or committing.
- Preserve unrelated work. Never commit or push directly to protected or shared
  integration branches, force-push, bypass hooks, or rewrite published history
  without explicit authorization for the operation.
- Keep worktrees and branches available while their PRs need review or fixes.
  Before authorized cleanup, verify the merge state, local changes, and the exact
  paths and branches; a closed but unmerged PR is not evidence of integration.

Describe human deployment or release decisions only when the target repository
defines them. Do not copy source-project branch prefixes, hardware gates, or
branch names into unrelated repositories.
