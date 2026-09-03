# Cron Migration

- OpenClaw job ID: `c86c0db9-0f6f-45c3-b2a4-45267b282743`
- Original expression: `0 3 * * *`
- Timezone: `Asia/Taipei`
- Intended cadence: every day at 03:00
- Original delivery mode: none. Let the Codex automation record the result in
  its task thread.

## Codex Automation Prompt

```text
Use $daily-reuters-ai-digest to create today's grounded Reuters AI digest in the active workspace. Write a no-confirmed-news report when necessary and return only the output path summary.
```
