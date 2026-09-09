---
name: dev
description: Use for development, debugging, refactoring, testing, benchmarks, and project setup. Follow issue selection or creation, an isolated worktree on an issue-specific agent/fix branch, plan, dev, test, and PR delivery. Use OpenSpec skills for requirements, implementation tasks, tests, and file-change records while preserving project conventions.
---

# Dev

Use this skill for requested codebase changes and engineering experiments.
Answer conceptual questions directly when no repository changes are needed.

## Workflow

1. **Get or create an issue.** Read AGENTS.md, contribution instructions,
   docs/rules/, the bundled [convention](references/convention.md), and the
   target's references/convention.md when present. Existing project rules and
   explicit user instructions take precedence over defaults. Use github-issues
   to read the specified issue or search for a matching issue before creating
   one scoped to this change. Record its URL, requirements, acceptance criteria,
   and validation constraints. Follow repository ownership rules. Read
   [state rules](references/rules/state-rules.md), initialize run state, and
   update it after each stage. If an issue cannot be obtained, record the
   blocker before branching or implementation.
2. **Open an isolated worktree.** Fetch and verify the integration base; inspect
   local changes, `git worktree list`, and existing issue branches/PRs. Use
   `agent/fix-<issue-id>` for every task type, substituting the actual issue ID.
   Create with `git worktree add -b agent/fix-<issue-id> <path> <base-ref>`.
   The path is a separate directory outside the primary checkout, not the branch
   name. Reuse an existing branch with `git worktree add <path>
   agent/fix-<issue-id>` or its already attached worktree after checking ownership.
   Do not duplicate active worktrees or force access to another contributor's
   work. Verify the root and branch; perform subsequent edits and checks there.
3. **Plan.** Read and use openspec-propose to create a change, or continue the
   issue's existing OpenSpec change. Define requirements and acceptance
   scenarios, design decisions, planned file changes, implementation tasks,
   and tests. Follow CLI-resolved paths, schema, dependencies, and apply
   prerequisites in [OpenSpec workflow](references/openspec-workflow.md).
   Link the issue and change in run state. For new projects, map planned files
   to the active convention before scaffolding. Continue into development when
   ready if implementation is already authorized.
4. **Dev.** Read and use openspec-apply-change, including its context files and
   task instructions. Implement scoped tasks, preserve unrelated work, and
   mark only completed tasks. When behavior or scope changes, update affected
   OpenSpec artifacts and the test plan. Record added, modified, renamed, and
   deleted paths with their purpose and related task/requirement. For experiments,
   record commands, inputs, configs, metrics, artifacts, and decisions. Use
   checkpoints for long-running processing where restarting would be costly.
5. **Test.** Run tests, regression checks, lint, type checks, or smoke commands
   appropriate to the acceptance scenarios. Validate the OpenSpec change with
   the installed CLI's supported command; spec validation does not replace code
   tests. Record exact commands, outcomes, evidence paths, and reasons for
   blocked/unrun checks in the change artifacts and run state. Check the final
   file tree and `git diff --check`. Fix failures in the same worktree and rerun
   affected checks. Leave unmet acceptance tasks incomplete and report blockers.
6. **Open a PR.** Use git-commit for a focused commit and github-pr-workflow to
   inspect the complete base-to-head diff and publish the issue branch when
   authorized. Reuse the issue's PR for follow-ups. Link the issue and OpenSpec
   change; summarize behavior, changed files, tests, and blockers. Read back the
   PR URL, head SHA, base, draft state, and checks. Keep the worktree for review
   and CI fixes. Report pending merge accurately; PR creation does not authorize
   merging or archiving the change.

## References

- [Convention](references/convention.md): default project structure and setup.
- [File tree](references/rules/filetree.md): placement and final tree checks.
- [Environment](references/rules/env.md): tool and runtime prerequisites.
- [OpenSpec workflow](references/openspec-workflow.md): skills and evidence.
- [State rules](references/rules/state-rules.md) and
  [template](references/template/STATE.template.md): resumable tracking.

## Rules

- Preserve user changes and established project conventions. Do not move code
  solely to fit a new-project default.
- Do not fabricate issue IDs, test results, artifact paths, or CI success.
- Keep credentials, model weights, datasets, and runtime logs out of commits.
- Do not bypass hooks, force-push, rewrite published history, merge, or delete
  worktrees without authorization for that operation.
- A PR request authorizes its required branch push. Otherwise finish a reviewable
  local result and report the publication boundary.
- Respect confirmation rules for human-owned docs; implementation completion
  does not implicitly authorize their mutation.

## Output

Report the issue, branch/worktree, OpenSpec change and evidence locations,
behavior and file changes, validation outcomes, and PR URL or blocker.
Distinguish implementation finished, PR opened, and change merged.
