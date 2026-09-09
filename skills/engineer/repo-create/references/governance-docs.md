# Repository Governance Docs

Use these patterns when creating or updating repo-management docs. Adapt them to
the actual repository instead of copying blindly.

## AGENTS.md

Purpose: teach developers and agents how to operate in the repo.

Recommended sections:

- `Repository Purpose`: what the repo is for and what success looks like.
- `Start Here`: files to read before making changes.
- `Directory Rules`: require reading `docs/rules/filetree.md` before creating,
  moving, or deleting directories.
- `Environment Rules`: require reading `docs/rules/environment.md` before
  installing packages, changing runtimes, starting services, or assuming paths.
- `Git Rules`: route branch, commit, issue, PR, and release-record work to the
  matching document under `docs/rules/git/`.
- `Human Documentation`: require reading `docs/rules/human-docs.md` before
  proposing changes to confirmed features, roadmap, or weekly history. Code or
  PR completion may prompt a proposal but does not authorize a document mutation.
- `Validation`: common test, lint, type-check, build, or smoke commands.
- `Git Hygiene`: preserve unrelated changes, stage scoped files only, and use
  focused commits.

Keep `AGENTS.md` short enough to read before every task. Put detailed rules in
`docs/rules/`.

## docs/rules/filetree.md

Purpose: define which directories are allowed and what each directory is for.

Include:

- Current top-level tree.
- Role of each directory.
- Where source, tests, docs, configs, generated outputs, scripts, data, and
  experiments belong.
- Which generated directories are ignored and must not be committed.
- Rule that new top-level directories require updating `filetree.md` in the same
  change.

Avoid:

- Aspirational directories that do not exist and are not part of the agreed
  structure.
- Framework-default paths that conflict with the repo's chosen organization.

Use `references/rules/filetree.md` for the fuller target-repo design rules.

## docs/rules/environment.md

Purpose: define runtime and service assumptions.

Include:

- Primary languages and required versions.
- Package managers and lockfiles.
- Virtual environment rules.
- Service manager such as Docker Compose, if any.
- Required local services, ports, and health checks when known.
- Where secrets, datasets, models, logs, and generated artifacts should live.
- Commands for setup and validation.

Mark unknowns explicitly, for example:

```text
Decision needed: choose Python version before adding runtime-specific tooling.
```

## docs/rules/git/

Purpose: define version-control behavior for humans and agents.

Use separate documents so each operation loads the relevant rules:

| Target document | Purpose | Bundled reference |
| --- | --- | --- |
| `branch.md` | Branch roles, isolated work, and cleanup | [branch.md](rules/git/branch.md) |
| `commit.md` | Scoped staging, commit messages, and history | [commit.md](rules/git/commit.md) |
| `issues.md` | Scope, evidence, ownership, and issue lifecycle | [issues.md](rules/git/issues.md) |
| `pull-request.md` | Base/head, checks, publication, and merge authority | [pull-request.md](rules/git/pull-request.md) |
| `changelog.md` | Commit-bounded release traceability | [changelog.md](rules/git/changelog.md) |

Inspect the target's current branch and release conventions before adapting
these patterns. If migrating `docs/rules/git.md`, preserve its required rules,
update inbound references in `AGENTS.md` and other docs, and avoid leaving two
conflicting sources of truth.

## docs/rules/human-docs.md And docs/human/

Purpose: distinguish human-confirmed features, priorities, and weekly history
from implementation records. Use [human-docs.md](rules/human-docs.md) for the
confirmation workflow, including changes to the rule itself.

The proposed human documentation set is:

- `docs/human/feature-list.md`: confirmed features and supporting evidence.
- `docs/human/roadmap.md`: human-confirmed priorities, milestones, and non-goals.
- `docs/human/changelog/<YYYY-Www>.md`: evidence-based ISO-week notes.

Keep speculative plans out of the confirmed feature list. Do not invent dates,
commitments, or completion. Propose updates when major features change, but write
only within a confirmed batch. Existing `docs/feature-list.md` content and its
links must be preserved unless a migration is explicitly authorized.

Release records, when used, belong to the separately governed `changelog/` and
do not replace or implicitly authorize the human weekly notes.

## Source Pattern

The Git directory split and human documentation boundary are adapted from
[npu-pynq governance rules](https://github.com/yenhao-huang/npu-pynq/tree/main/docs/rules).
Its hardware-specific scopes, branch names, deployment gates, and release
procedures are not defaults for unrelated repositories.
