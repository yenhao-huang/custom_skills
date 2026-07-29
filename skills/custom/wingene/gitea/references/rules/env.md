# Environment Rules

## Runtime

Primary language: shell commands, with Python 3 allowed for in-memory API
requests.

Runtime version: system `git`, `python3`, and standard-library HTTP modules.

Package manager: none.

Frameworks: Gitea REST API and Git credential protocol.

Service manager: none.

Required services: the `origin` Gitea instance resolved from the repository.

## Constraints

- Do not install packages for this workflow.
- Do not assume `python` exists; use `python3` when a script is needed.
- Inspect `/api/v1/version` and `/swagger.v1.json` for version-dependent APIs.
- Keep secrets out of process output and repository files.
