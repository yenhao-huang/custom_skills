# OpenSpec Workflow

Read openspec-propose for planning and openspec-apply-change for implementation.
Use openspec-explore when investigation is needed to resolve requirements.

## Resolve The Change

Check the CLI and repository OpenSpec setup before planning. If a required
skill or CLI is missing, report the concrete prerequisite and use the project's
documented setup; do not silently substitute untracked notes or claim it ran.
Select an existing issue-linked change when known; otherwise inspect
`openspec list --json` before creating one. Clarify ambiguous matches.

Follow the selected skill's store guidance. For registered stores, discover the
ID and preserve supported `--store <id>` flags. Do not assume all artifacts live
inside the code worktree.

Use `openspec status --change <name> --json` and
`openspec instructions <artifact-id> --change <name> --json`. Follow returned
planning scope, change root, output paths, dependencies, and templates. Generate
artifacts in dependency order until all apply prerequisites are ready.

## Requirements, Implementation, Tests, And File Changes

For a spec-driven schema, the usual artifacts are proposal, specifications,
design, and tasks. Other schemas may differ: follow CLI output rather than
hard-coding names or inventing unsupported artifact types.

- Specifications define required behavior and testable acceptance scenarios.
- Proposal/design records the issue, scope, constraints, decisions, and planned
  file changes with reasons.
- Tasks connect requirements to implementation and tests. Follow
  `openspec instructions apply --change <name> --json` and read all returned
  context files. Mark implementation and validation tasks separately; written
  code alone does not prove acceptance scenarios passed.
- Record actual file changes and validation in schema-appropriate task/design
  sections or a repository-approved evidence document linked from the change.
  Include path, operation (add/modify/rename/delete), purpose, requirement/task,
  and validation. Reconcile against `git diff --name-status <base>...HEAD` after
  committing; also inspect staged/unstaged diffs and untracked files before it.
  Exclude unrelated local files.
- Record exact test commands, inputs/configs, outcomes, and artifact paths.
  Label failed, blocked, and unrun checks honestly. For documentation-only
  changes, explain why runtime tests are unnecessary and record static checks.

Use `openspec validate --help` to select the installed version's supported
change validation syntax; record the actual command and outcome. Rerun affected
tests after fixes and keep the plan, task status, and evidence consistent.

## Later Lifecycle

Link issue/change, file-change evidence, and tests in the PR. Keep the worktree
for fixes while integration is pending. Use openspec-sync-specs or
openspec-archive-change only at the repository's authorized lifecycle point,
reading the selected skill first. PR creation alone does not authorize syncing,
archival, merging, or cleanup.
