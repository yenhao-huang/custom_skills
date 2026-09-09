# Target Repository Release Changelog Rules

Use this reference when writing `docs/rules/git/changelog.md`. Contributor-owned
release records are distinct from human-owned weekly notes governed by
[human-docs.md](../human-docs.md); writing one does not authorize updating the other.

When the target repository uses versioned release records, a useful default is
`changelog/vMAJOR.MINOR.PATCH.md`, one file per selected version. Preserve its
existing release convention instead of inventing a version or release schedule.
Use these sections:

1. `Change commits`: full before/after commit SHAs and the boundary semantics.
2. `Roadmap progress reached`: only progress supported by merged code, accepted
   evidence, or an explicit human decision; describe incomplete work plainly.
3. `Issues and corresponding pull requests`: evidence links, their relationship,
   and the result. Group by meaningful change type, with features and fixes first;
   keep tables readable and mark missing links rather than inventing them.

Both boundary SHAs must resolve in the repository. The after boundary is the
last implementation or integration commit included, not a later changelog-only
commit containing the record itself. For a whole-history baseline, identify the
root boundary as inclusive. Verify issue/PR links, integration status, and
`git diff --check` before committing. An open PR or branch name does not prove
roadmap completion. These records do not authorize tags, releases, or changes to
the human-owned roadmap.
