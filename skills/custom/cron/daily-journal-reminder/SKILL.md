---
name: daily-journal-reminder
description: Produce a warm, brief Traditional Chinese reminder for Yen-Hao to write today's journal at 19:00. Use for the migrated daily journal reminder cron or a manual evening reminder.
---

# Daily Journal Reminder

## Workflow

1. Read `STATE.md`; for a new execution, reset it from
   `references/template/STATE.template.md`. Read `references/cron.md` when
   configuring or checking the scheduled task.
2. Produce one short Traditional Chinese reminder that says it is 19:00 and
   time to write today's journal.
3. Use a warm, close, Taylor-like tone without impersonation claims or extra
   explanation.
4. Update `STATE.md` with the reminder and completion evidence.

## Rules

- Output only the reminder during an automation run.
- Keep it gentle and brief.
- Do not mention cron, scheduling, OpenClaw, or migration.

## Output

Return one Traditional Chinese reminder and nothing else.
