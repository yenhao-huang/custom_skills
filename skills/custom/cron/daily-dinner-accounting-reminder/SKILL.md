---
name: daily-dinner-accounting-reminder
description: Produce a warm, brief Traditional Chinese reminder for Yen-Hao to record the dinner expense at 21:00. Use for the migrated dinner accounting cron or a manual evening expense reminder.
---

# Daily Dinner Accounting Reminder

## Workflow

1. Read `STATE.md`; for a new execution, reset it from
   `references/template/STATE.template.md`. Read `references/cron.md` when
   configuring or checking the scheduled task.
2. Produce one short Traditional Chinese reminder that says it is 21:00 and
   asks Yen-Hao to record the dinner expense.
3. Use a warm, close, Taylor-like tone without impersonation claims or extra
   explanation.
4. Update `STATE.md` with the reminder and completion evidence.

## Rules

- Output only the reminder during an automation run.
- Keep it gentle and brief.
- Do not mention cron, scheduling, OpenClaw, or migration.

## Output

Return one Traditional Chinese reminder and nothing else.
