# Target Repository Issue Rules

Use this reference when writing `docs/rules/git/issues.md`.

- State when the target repository requires an issue before implementation;
  preserve its ownership and design-proposal process rather than inventing one.
- Before a write, confirm the repository and authentication, search open and
  closed issues for duplicates, and read any issue being updated.
- Record the known problem or requested behavior, relevant versions and
  reproduction evidence, acceptance criteria, validation, and dependencies.
  Do not invent results, severity, owners, milestones, or commitments.
- Preserve unrelated issue sections and metadata. Include no secrets or
  unredacted sensitive logs.
- If the repository requires claiming work, verify ownership and check for an
  existing branch, worktree, and PR before starting another. Reuse those for
  review and CI fixes.
- Link issues and PRs with precise relationships. Use closing keywords only
  when closure is intended and supported by the PR's base branch; otherwise use
  `Refs #123` and verify acceptance and merge state before authorized closure.
- Read back each mutation and report its URL. Closing, reopening, transferring,
  or deleting an issue requires authorization for that operation.
