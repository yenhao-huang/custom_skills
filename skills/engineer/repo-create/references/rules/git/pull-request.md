# Target Repository Pull Request Rules

Use this reference when writing `docs/rules/git/pull-request.md`.

1. Confirm authentication, the exact remote repository, the non-default head,
   and the actual integration base. Read contribution rules and PR templates.
2. Inspect the entire base-to-head diff and commit list. Run the repository's
   applicable validation and name each blocked or unrun check with its reason.
   For issue work, apply [demo acceptance rules](../demo.md): link the issue
   package, verify reports/reproduction/detail evidence, and disclose failed or
   unrun checks before claiming acceptance.
3. Use the PR description format below to describe the problem, resulting
   behavior, linked issues, validation, compatibility impact, and remaining
   risks. Keep independently useful
   commits distinct; use the repository's approved squash strategy for iterations
   that complete one logical change. Do not rewrite published history to do so.
4. Push and create or update the PR only when publication is authorized. An
   explicit request to create or update a PR authorizes its necessary branch
   push. Continue review and CI fixes in the same branch and worktree.
5. Read the PR back and report its URL, base/head, draft state, and current checks.
   Claim CI success only for verified checks on the current head SHA.

Creating a PR does not authorize merging it, publishing a release, or updating
human-owned documentation. Follow the target repository's merge and release
authority. Record a pending review or merge accurately; an open PR does not
prove the change is integrated. If a release is separately authorized, verify
its source commit, tag, validation, and release notes against
[changelog.md](changelog.md).

## PR Description Format

Use these five headings in this order: `功能與交付範圍`, `測試`, `結果`,
`相關證據`, and `建議`. Preserve explicit user instructions and mandatory
target-repository templates; when a repository requires different headings,
map this content into its template rather than creating conflicting rules.

Lead with a short description of the concrete problem and resulting behavior.
Describe the complete PR, not the conversation or only its latest commit.
Scale the detail to the change, but keep the five sections. If a section is not
applicable, say so briefly instead of inventing content.

- **功能與交付範圍**: Explain what changes, the included features or fixes,
  affected interfaces, and issue-to-deliverable relationships. A table is useful
  when a PR covers several issues or supersedes earlier PRs.
- **測試**: List commands or checks actually run and their outcomes. Identify
  the tested revision and environment when relevant. Separate historical
  evidence from current-head checks; disclose failures, blocked checks, and
  unrun checks with reasons.
- **結果**: Explain what the checks establish about behavior, acceptance, or
  measured performance. Include limitations, compatibility effects, and
  remaining risks. Do not treat passing tests as proof of unrelated quality
  improvements, or an open PR as an integrated result.
- **相關證據**: Link relevant reports, reproduction instructions, detailed
  artifacts, and CI runs. Prefer links pinned to the reviewed revision. Mark
  local-only evidence paths clearly; do not imply reviewers can access them.
- **建議**: State concrete next actions, such as review, post-merge issue
  closure, rollout prerequisites, or follow-up work. Put intended issue-closing
  directives here, one per line, using `Closes #<issue>` with a real issue number.
  Use `Refs #<issue>` for partial work. Closing directives describe the intended
  effect of merging; they do not authorize an immediate manual closure or merge.
  Verify the target repository's base-branch closure behavior.

### Copyable Template

Replace all placeholders before publishing. The issue numbers below are examples,
not issues to close or reference automatically.

```markdown
Describe the concrete problem and the resulting behavior in one or two sentences.

## 功能與交付範圍

- Describe the delivered change and the issue or requirement it addresses.

## 測試

- Command/check, tested revision or environment, and actual outcome.
- Failed, blocked, or unrun checks and their reasons, if any.

## 結果

- Observed behavior or metrics, acceptance status, and material limitations.

## 相關證據

- Links to reports, reproduction instructions, detailed evidence, or CI runs.

## 建議

- Concrete reviewer or follow-up action; state pending merge accurately.

Closes #123
Refs #456
```

For example, `Closes #123` is appropriate only when this PR fully resolves issue
123 and merging is intended to close it. A suggestion to review or merge remains
a suggestion; follow the repository's separate human-approval requirements.
