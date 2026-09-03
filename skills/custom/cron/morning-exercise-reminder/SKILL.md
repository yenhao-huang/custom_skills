---
name: morning-exercise-reminder
description: Produce the short Traditional Chinese morning check-in that asks whether Yen-Hao exercised and practiced LeetCode. Use for the migrated morning reminder cron or a manual morning accountability check-in.
---

# Morning Exercise Reminder

## Workflow

1. Read `STATE.md`; for a new execution, reset it from
   `references/template/STATE.template.md`. Read `references/cron.md` when
   configuring or checking the scheduled task.
2. Confirm the invocation is a reminder run; do not perform task research or
   explain scheduler behavior.
3. Output one concise Traditional Chinese message conveying:
   `提醒：早安打卡時間 💪。今天有沒有運動？今天有沒有刷 LeetCode？`
4. Update `STATE.md` with the produced reminder and completion evidence.

## Rules

- Keep the tone friendly and motivating.
- Output only the reminder content during an automation run.
- Do not claim the execution time was randomized; the source cron currently
  uses the fixed time recorded in `references/cron.md`.

## Output

Return a single short reminder with no scheduling explanation.
