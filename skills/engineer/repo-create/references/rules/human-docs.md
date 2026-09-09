# Target Repository Human Documentation Rules

Use this reference when writing `docs/rules/human-docs.md` and proposing the
human-owned documentation structure. Adapt existing paths without discarding
their content or authorization boundaries.

## Ownership And Confirmation

`docs/human/` is the human-owned view of confirmed direction and change history.
Agents may read and summarize it without approval. Before any mutation,
show the exact paths and summarize the proposed batch, then obtain explicit
human confirmation for that batch. Mutation includes creation, editing,
appending, formatting, renaming, moving, and deletion of files or directories.
Read the changed files back and report the result.

An existing explicit instruction covering that exact batch is sufficient; do
not ask again. A general code, issue, PR, merge, or release request does not
implicitly authorize these documents, and a past batch does not authorize later
changes. Changes to `docs/rules/human-docs.md` itself follow the same confirmation
boundary. Continue other authorized governance work while a batch is pending.

## Structure And Content

```text
docs/human/
    roadmap.md
    changelog/
        <YYYY-Www>.md
```

- `roadmap.md`: human-confirmed priorities, milestones, and non-goals. Do not
  invent dates, commitments, or progress.
- `changelog/<YYYY-Www>.md`: evidence-based weekly notes, using the ISO week-year
  and week number, including at calendar-year boundaries.

For existing human docs, inspect inbound links
and propose any migration as an explicit batch; update affected navigation in
the same approved change. Do not silently move files or create a competing copy.
Preserve established paths when migration has not been requested or confirmed.

Weekly notes are separate from contributor-maintained, commit-bounded release
records described in [git/changelog.md](git/changelog.md).
