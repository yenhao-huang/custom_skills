# Target Repository Commit Rules

Use this reference when writing `docs/rules/git/commit.md`.

- After a requested unit of work passes relevant validation, create a focused
  local commit unless the user or repository says otherwise.
- Verify the repository root and branch, inspect `git status --short`, stage
  only the completed unit, and inspect `git diff --cached` before committing.
  Leave unrelated user changes unstaged.
- Do not commit secrets, local environment files, caches, generated outputs,
  datasets, model weights, or runtime logs unless the repository explicitly
  tracks the non-sensitive artifacts.
- Use Conventional Commits based on the actual diff:
  `<type>(<scope>): <imperative description>`. Common types are `feat`, `fix`,
  `perf`, `refactor`, `docs`, `test`, `build`, `ci`, `chore`, and `revert`.
  Choose scopes from the target repository and keep subjects under 72 characters.
- For substantive `feat` and `fix` changes, use `Background`, `Solution`,
  `Changes`, and `Validation` body sections to explain the problem, approach,
  implementation, and exact check outcomes. Name blocked or unrun checks and
  their reasons. Mark incompatible public contracts with `!` and a
  `BREAKING CHANGE:` explanation.
- Preserve independently reviewable or revertible logical changes. Iterations
  that complete the same change may be combined through the approved merge
  strategy; keep reverts separate. This does not authorize rewriting published
  history, force-pushing, or bypassing hooks.
- Link related issues according to the target branch's closure policy. Local
  commits do not authorize a push; an explicit push or PR request does.
