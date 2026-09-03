# Cron Migration

- OpenClaw job ID: `53ce2e60-5222-405b-89a5-d16f221004de`
- Original expression: `0 3 * * *`
- Timezone: `Asia/Taipei`
- Intended cadence: every day at 03:00
- Original delivery: none specified. Let the Codex automation surface the
  result in its task thread.

## Codex Automation Prompt

```text
Use $daily-dart-task-check to query Dart for today's tracked projects and return the required Traditional Chinese sectioned summary. If Dart is unavailable, report that integration blocker without inventing tasks.
```
