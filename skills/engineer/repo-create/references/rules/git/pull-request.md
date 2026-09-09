# Target Repository Pull Request Rules

Use this reference when writing `docs/rules/git/pull-request.md`.

1. Confirm authentication, the exact remote repository, the non-default head,
   and the actual integration base. Read contribution rules and PR templates.
2. Inspect the entire base-to-head diff and commit list. Run the repository's
   applicable validation and name each blocked or unrun check with its reason.
   For issue work, apply [demo acceptance rules](../demo.md): link the issue
   package, verify reports/reproduction/detail evidence, and disclose failed or
   unrun checks before claiming acceptance.
3. Describe the problem, resulting behavior, linked issues, exact validation
   results, compatibility impact, and remaining risks. Keep independently useful
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
