# Target Repository Filetree Rules

Use this reference when `repo-create` writes `docs/rules/filetree.md` for a
target repository. This file is about the target repo's structure, not the
layout of the `repo-create` skill itself.

## Goal

Create a filetree rule that teaches humans and agents:

- Which top-level directories are allowed.
- What each directory is responsible for.
- Where source, tests, docs, configs, scripts, generated outputs, data, and
  experiments belong.
- Which paths are generated or ignored and must not be committed.
- How to propose a new top-level directory.

## Recommended Default Tree

For a new Python/ML/LLM-style repository, start from this conservative shape
unless the user or existing repository conventions say otherwise:

```text
.
    AGENTS.md
    README.md
    .gitignore
    .codex/skills/    # project-local Codex skills
    configs/          # config files, env templates, YAML/JSON defaults
    src/              # application code, APIs, business logic, shared utilities
    scripts/          # startup scripts and service entrypoints
    data/             # project-local temporary or symlinked data only
    docs/
        human/        # create or migrate only with batch confirmation
            roadmap.md
            changelog/
                <YYYY-Www>.md
        rules/
            environment.md
            filetree.md
            human-docs.md
            git/
                branch.md
                commit.md
                issues.md
                pull-request.md
                changelog.md
    exp/              # experiments, spikes, research notes
    external/         # third-party service wrappers or local integrations
    logs/             # local runtime logs, ignored unless explicitly kept
    results/          # evaluation outputs and generated reports
    test/             # tests when the repo does not already use tests/
    observability/    # monitoring, metrics, tracing, and operational dashboards
```

If the existing repository already uses `tests/`, `app/`,
or another established layout, preserve it and document that as the active
layout instead of forcing the default tree.

The human docs subtree is a proposed contract, not permission to create or move
files. Follow [human-docs.md](human-docs.md) for the confirmation boundary.
Where versioned release records are part of the agreed workflow, document a
separate top-level `changelog/` according to [git/changelog.md](git/changelog.md).
It has a different purpose and ownership from `docs/human/changelog/`.

## Required Sections In docs/rules/filetree.md

When writing the target repo's `docs/rules/filetree.md`, include:

1. `Allowed Structure`: a tree that matches actual or agreed directories.
2. `Directory Roles`: concise purpose for each directory.
3. `Creation Rules`: what must happen before adding directories.
4. `Generated Files`: paths that must not be committed.
5. `Change Procedure`: update `filetree.md` in the same change when the
   directory contract changes.

## Design Rules

- Do not create aspirational directories unless the user agrees they are part of
  the initial repo contract.
- Prefer the existing repo's conventions over generic defaults.
- Keep implementation code, tests, configs, docs, and generated artifacts in
  separate directories.
- Do not mix runtime output with source files.
- For model or dataset-heavy repos, prefer external/global storage with
  environment-variable paths or symlinks rather than committing large assets.
- For nested tools or subprojects, give them their own local `AGENTS.md` and
  `docs/rules/filetree.md` only when they have distinct rules.

## Example Creation Rule

```markdown
Before adding a new top-level directory, update `docs/rules/filetree.md` in the
same change with the directory's purpose, allowed contents, and validation
expectations. Do not add convenience directories that duplicate an existing
role.
```
