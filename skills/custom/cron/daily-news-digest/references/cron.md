# Cron Migration

- OpenClaw job ID: `865e50d8-e5c1-4fc4-afe0-73901bdbf7e0`
- Original expression: `30 2 * * *`
- Timezone: `Asia/Taipei`
- Intended cadence: every day at 02:30
- Original delivery: an OpenClaw channel announcement. Delivery identifiers
  are intentionally omitted; configure delivery in Codex separately.

## Codex Automation Prompt

```text
Use $daily-news-digest to create, save, commit, and push today's AI, Taiwan finance, and US market digests. Follow the skill's push hard guard and report the three file paths and git result.
```
