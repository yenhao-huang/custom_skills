# Cron Migration

- OpenClaw job ID: `187b6700-a705-4047-a3a8-0de01c06774a`
- Original expression: `37 7 * * *`
- Timezone: `Asia/Taipei`
- Intended cadence: every day at 07:37
- Migration note: the OpenClaw job name described a randomized 07:00-08:00
  slot, but the stored active schedule was fixed at 07:37. This skill preserves
  the active schedule without claiming randomization.

## Codex Automation Prompt

```text
Use $morning-exercise-reminder to send today's exercise and LeetCode morning check-in. Output only the reminder.
```
