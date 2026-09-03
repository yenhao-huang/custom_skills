# Download Runtime

- HF environment: `~/Desktop/python-venvs/hf-cli`
- Model root: `~/Desktop/models/`
- Inventory: `~/Desktop/models/Readme.md`
- Default command:
  `hf download <repo-id> --local-dir <destination> [files...]`

Use a short kebab-case tmux session name. Before creating it, run
`tmux list-sessions` and avoid replacing an unrelated session.

Useful user commands:

```bash
tmux list-sessions
tmux attach -t <session-name>
```

If the existing HF environment or CLI is missing, report that prerequisite;
do not create or install a replacement unless the user separately requests it.
