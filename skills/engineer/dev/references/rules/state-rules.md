# State Rules

Read STATE.md before a run. Initialize new work from the state template;
preserve evidence when resuming the same issue. For concurrent runs, keep a
separate copy in the issue worktree's documented run-state location and record
that path rather than overwriting a shared skill installation or another run.

Use pending, in_progress, completed, blocked, or skipped. Mark a stage
in_progress before acting and completed only with concrete evidence. Name
blocked/skipped reasons. Track issue, verified base, branch, worktree, OpenSpec
change and resolved artifacts, file changes, tests, and PR state. Reopen stages
when edits invalidate evidence. PR delivery is not merge completion. Keep live
run details out of reusable templates and unrelated skill commits.
