---
name: solve-issue
description: Resolve a GitHub issue end to end by reading its requirements, implementing and testing the change, reviewing the result, committing it, creating a pull request, and following through on CI and review. Use when the user asks to solve, fix, implement, or continue work on a specific GitHub issue.
license: MIT; adapted from canpok1/claude-code-plugins
---

# Solve Issue

Resolve one GitHub issue through a verified pull request. Treat the issue
number or URL supplied by the user as the target; if none is supplied, identify
the issue from the current conversation or ask the user before changing code.

## Workflow

1. Read `STATE.md`, reset it from `references/template/STATE.template.md` for
   a new run, and record the repository and target issue.
2. Use `github-issues` to fetch the issue, labels, comments, linked work, and
   current state. Stop and ask before proceeding if the issue is closed, cannot
   be identified, or has materially ambiguous requirements.
3. Read the full discussion before writing any code: every comment, linked or
   merged pull request, duplicate-issue link, and commit that references the
   issue number. Pay particular attention to the original reporter's own
   follow-up comments — reporters often post a workaround, root cause, or a
   working fix themselves after opening the issue, and that can be the
   fastest path to a correct answer or proof the issue no longer needs work.
   Determine whether the issue is already resolved — fixed on a branch,
   closed via a merged PR, declared a duplicate, resolved by a workaround the
   reporter confirmed works, or otherwise handled by someone else.
   - If already resolved: do not implement anything. Record the finding and
     its evidence (comment or PR link) in `STATE.md` as the run's outcome.
     If this issue was chosen from a backlog or list rather than pinned by
     the user, pick the next unresolved candidate from that list and repeat
     this check; if the user pinned this specific issue, report the finding
     to the user and ask how to proceed instead of silently substituting a
     different issue.
   - If not resolved, continue to implementation — but reuse the reporter's
     workaround or diagnosis as a starting point when it points to the fix.
5. Read the repository instructions and use `dev` to investigate, implement,
   and test the smallest complete change that satisfies the issue.
6. Push the branch to the user's own fork or internal repository (e.g.
   `yenhao-huang/TensorRT-LLM`) for validation. This push is always allowed —
   it is private-equivalent scratch work, not a community-facing action.
7. Stop and ask the user for explicit, per-issue go-ahead before using
   `github-pr-workflow` to open a pull request against the upstream/community
   repository. Publishing to the community is a separate decision from
   solving the issue: report that the fix is implemented, committed, pushed
   to the user's own fork, and validated, then wait for confirmation before
   opening the PR. Do not open the PR on the strength of an earlier blanket
   "proceed autonomously" instruction, a prior run's approval, or a `/loop`
   or similar automation request — none of those constitute consent for
   *this* issue's PR. Only proceed without asking again if the user's
   instruction for this run explicitly names opening/publishing the PR itself
   (not just solving the issue) as pre-authorized.
8. Once the user confirms, use `github-pr-workflow` to open the pull request
   that links the issue and reports validation evidence.
9. Monitor CI and review feedback, address failures or actionable comments,
   and merge only when the user explicitly requested merging or repository
   policy clearly grants that authority.
10. Summarize the result, validation, pull request state, and any follow-up or
    residual risk. Mark the run complete in `STATE.md` only when the requested
    lifecycle is actually finished.

## Guardrails

- Use a purpose-built installed skill for each workflow phase when available.
- Keep concise work notes in `STATE.md` at meaningful checkpoints so later
  turns can resume without reconstructing context.
- After a command returns empty or unexpected output, run a read-only state
  check before taking the next mutating action. For example, retry `gh issue
  view` or `gh pr view` with `--json`, inspect `git status` after file-moving
  commands, and verify a remote branch before deleting it.
- If code changes, make each commit a coherent logical unit and validate it in
  proportion to risk.
- Committing and pushing to the user's own fork/internal repository is always
  in scope and does not require asking first. Opening, updating the target
  of, or otherwise publishing a pull request against the upstream/community
  repository always requires the user's explicit, per-issue confirmation
  first — treat it the same as merging or force-pushing: a consequential,
  public, hard-to-reverse action that needs its own sign-off, never inferred
  from being told to "solve" or "fix" the issue.
- Do not merge, close an issue, force-push, delete a branch, or perform another
  consequential remote action unless the user's request or established
  repository workflow authorizes it.
- Never start implementation before reading the issue's comments and linked
  work in full. An issue whose discussion shows it is already fixed,
  duplicated, or resolved elsewhere is a bypass, not a coding task: record it
  and move to the next candidate instead of re-solving already-solved work.

## Provenance

Adapted from `plugins/base-tools/skills/solve-issue` in
`canpok1/claude-code-plugins` at commit
`04f81f5ffc0d83dab157171203520e1d635742cb`. See
`references/LICENSE.txt` for the upstream MIT license.
