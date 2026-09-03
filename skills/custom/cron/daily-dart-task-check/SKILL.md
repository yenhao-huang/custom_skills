---
name: daily-dart-task-check
description: Query the connected Dart task-management MCP and produce the daily Traditional Chinese status summary for today, rag, model-tester, pretrievalagent, and esg contest. Use for the migrated daily Dart cron, manual task briefings, or reruns of a missing summary.
---

# Daily Dart Task Check

## Workflow

1. Read `STATE.md`; for a new execution, reset it from
   `references/template/STATE.template.md`. Read `references/cron.md` for
   scheduled-task metadata and `references/rules/env.md` for the connector
   requirement.
2. Resolve today's date in `Asia/Taipei`.
3. Confirm a Dart MCP server or connector is available. If unavailable, stop
   without inventing tasks and report the missing integration.
4. List tasks relevant to today, then search or filter for these exact project
   or label concepts: `today`, `rag`, `model-tester`, `pretrievalagent`, and
   `esg contest`.
5. Normalize each result to task name, status (`done`, `in-progress`, or
   `todo`), and assignee when present. Mark a section `無任務` when no matching
   task exists.
6. Update `STATE.md` with the query date, connector used, result count, and
   completion status.

## Rules

- Treat Dart as the source of truth and preserve returned task names.
- Do not silently substitute Claude CLI or another task system for the Dart
  MCP integration.
- Distinguish no matching tasks from a connector or query failure.

## Output

Use this exact section structure:

```markdown
## 今日 Dart 任務摘要（YYYY-MM-DD）
### today checked
- ...
### rag
- ...
### model-tester
- ...
### pretrievalagent
- ...
### esg contest
- ...
```
