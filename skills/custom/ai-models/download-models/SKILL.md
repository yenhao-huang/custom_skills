---
name: download-models
description: Download complete Hugging Face model repositories or selected files into ~/Desktop/models through the existing HF CLI environment, using tmux for observable long-running transfers and updating the local model inventory. Use when the user asks to download, resume, or verify model weights locally.
---

# Download Models

## Workflow

1. Read `STATE.md`; reset it from `references/template/STATE.template.md` for a
   new run. Read `references/runtime.md` before starting a transfer.
2. Resolve the exact Hugging Face repository, optional revision and file list,
   short model abbreviation, and destination under
   `~/Desktop/models/<model-name>/`.
3. Check existing destination files, available disk space, HF CLI availability,
   authentication requirements, and whether a tmux session with the chosen
   name already exists. Skip complete files unless the user requests overwrite.
4. Show the exact `hf download` command and destination before starting.
5. Start or deliberately reuse a named tmux session, activate
   `~/Desktop/python-venvs/hf-cli`, and run the download there. Tell the user
   the exact commands for listing and attaching to the session.
6. Monitor progress and report meaningful updates during the transfer. In an
   interactive task, update at least once per minute when observable; never
   leave the user without status for more than two minutes.
7. Verify the downloaded files and revision when available. Update
   `~/Desktop/models/Readme.md` without removing existing inventory entries.
8. Record the repository, destination, tmux session, command, verification, and
   final status in `STATE.md`.

## Rules

- Prefer `hf download`; use explicit trailing filenames for partial downloads.
- Never print tokens or embed credentials in commands, logs, or state.
- Do not redownload complete files without explicit instruction.
- Do not claim completion before the download and file verification finish.

## Output

Report the command, tmux session and attach command, destination, verified files
or revision, and any skipped or failed items.
