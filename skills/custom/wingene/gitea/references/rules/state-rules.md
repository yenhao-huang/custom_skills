# State Rules

Before each new Gitea workflow, reset `STATE.md` from
`references/template/STATE.template.md`.

Use only these statuses:

```text
pending
in_progress
completed
blocked
skipped
```

Mark a step `in_progress` before performing it. Mark it `completed` only with
non-secret evidence such as the resolved origin, helper mode, HTTP status,
issue number, or issue URL. Never record credential values in state.
