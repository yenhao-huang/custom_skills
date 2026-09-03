---
name: notion-mcp-ops
description: Read, append, update, or restructure Notion pages from local source files through the connected Notion integration, with permission checks and post-write verification. Use for personal Notion publishing and synchronization workflows that must preserve existing content and linked subpages.
---

# Notion MCP Operations

## Workflow

1. Read `STATE.md`; reset it from `references/template/STATE.template.md` for a
   new run. Identify the target page, source files, desired structure, and
   whether the user requested append, update, or full replacement.
2. Confirm the Notion connector is available with a harmless read or search.
   If it is unavailable or unauthenticated, stop and report the exact setup or
   permission blocker.
3. Read the current target and all named local source files. Preserve existing
   linked subpages and unrelated sections.
4. Apply the smallest requested write. Use full replacement only when the user
   explicitly requests a full rewrite.
5. Read the affected page again and verify the expected headings, content, and
   links. Record target, operation type, and verification evidence in
   `STATE.md`.

## Rules

- Use the connected Notion tools directly; do not launch another Codex CLI
  process to perform the same operation.
- Treat local files as source of truth when the user supplies them.
- Never delete a page or database unless explicitly requested.
- If permissions fail, ask the user to share the target with the connected
  Notion account rather than retrying blind writes.

## Output

Return the page URL, operation performed, verified result, and any skipped or
blocked content.
