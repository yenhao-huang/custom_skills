---
name: repo-create
description: Create or refine repository governance docs through discussion with the user. Use when Codex needs to help set up a repo, define AGENTS.md and docs/rules including Git workflow rules, establish human-owned roadmap and changelog docs, or teach repository management.
---

# Repo Create

Use this skill to help a user design and create the management layer for a
repository before or while code is added. The core output is a small set of
repo-governance documents that explain how developers and agents should work in
the repo.

## Workflow

1. Inspect the repository first:
   - Read existing `AGENTS.md`, `README.md`, `docs/`, `.gitignore`, dependency
     files, and visible top-level directories.
   - Preserve existing conventions unless the user asks to replace them.
2. Read `STATE.md`; for a new run, reset it from
   `references/template/STATE.template.md`, then mark the active step
   `in_progress`.
3. Discuss scope with the user when it is not already clear:
   - Ask what the repo is for, who will maintain it, expected languages,
     runtime services, and what directories should be allowed.
   - If the user gave enough direction, proceed with conservative defaults and
     state the assumptions.
4. Create or update `AGENTS.md`:
   - Explain the repo purpose, operating rules, validation commands, and git
     hygiene.
   - Teach the user where the important docs live and how to update them.
   - Point agents to `docs/rules/filetree.md` before directory changes and to
     `docs/rules/environment.md` before environment changes.
   - Route Git operations to the relevant file in `docs/rules/git/` and human
     documentation mutations to `docs/rules/human-docs.md`.
5. Create or update `docs/rules/`:
   - `filetree.md`: allowed directory tree, directory roles, creation rules,
     generated-file rules, and how to propose new directories.
   - `environment.md`: language/runtime versions, package managers, services,
     secrets, data/model storage, and validation commands.
   - `git/branch.md`, `git/commit.md`, `git/issues.md`,
     `git/pull-request.md`, and `git/changelog.md`: focused Git workflow rules.
     Read the matching bundled references before drafting each file and preserve
     existing constraints and inbound links when reorganizing rules.
   - `human-docs.md`: ownership, confirmation, structure, and evidence rules.
     Read `references/rules/human-docs.md` before creating or changing this rule;
     its mutation also requires confirmation covering the proposed batch.
6. Propose the human documentation batch:
   - Use `docs/human/roadmap.md` and `docs/human/changelog/<YYYY-Www>.md`
     for confirmed direction and weekly history. Preserve existing paths unless
     migration is authorized.
   - Show exact paths and the proposed batch before seeking confirmation. Proceed
     when an existing explicit instruction already covers that batch; otherwise
     await confirmation before any mutation, including initial creation or moves.
   - After the authorized write, read back the files and check evidence. Code or
     PR completion alone does not authorize updates to human-owned docs.
7. Validate the docs:
   - Check links and paths against the actual repo, including navigation changed
     by any Git-rule or human-doc migration. Distinguish proposed paths from
     files already created; report any batch still awaiting confirmation.
   - Run the smallest relevant validation command if the repo defines one.
   - Inspect `git diff --check` before committing or handing off.
8. Mark completed or blocked steps in `STATE.md` with evidence before the final
   response.

## Reference

- Read `references/governance-docs.md` when writing or revising the actual
  `AGENTS.md`, `docs/rules/`, or human documentation content.
- Read `references/rules/filetree.md` before creating or moving governance
  files.
- Read `references/rules/env.md` before writing environment assumptions.
- Read the matching Git reference before writing that rule:
  [branches](references/rules/git/branch.md),
  [commits](references/rules/git/commit.md),
  [issues](references/rules/git/issues.md),
  [pull requests](references/rules/git/pull-request.md), and
  [release changelogs](references/rules/git/changelog.md).
- Read [human documentation](references/rules/human-docs.md) before proposing or
  changing human-owned docs or their rule.
- Read `references/rules/state-rules.md` before changing `STATE.md`.

## Rules

- Do not invent services, package managers, credentials, ports, model paths, or
  deployment targets. Mark unknowns as decisions for the user.
- Do not overwrite existing repo instructions without preserving their required
  constraints.
- Keep governance docs practical: prefer rules that agents and developers can
  follow during day-to-day changes.
- If creating a new repo from scratch, create the governance docs before adding
  broad implementation structure.

## Output

Final responses should include:

- Which governance docs were created or updated.
- The assumptions or user decisions encoded in those docs.
- Validation commands and results.
- Any remaining decisions the user still needs to make.
