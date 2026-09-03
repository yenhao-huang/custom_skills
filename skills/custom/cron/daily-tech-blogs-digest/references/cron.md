# Cron Migration

- OpenClaw job ID: `ceca9739-44a5-4301-a74b-20d91cbca6e4`
- Original expression: `0 2 * * *`
- Original timezone field: not set
- Codex migration timezone: `Asia/Taipei`, matching the job's date contract and
  the surrounding daily-news workflow
- Intended cadence: every day at 02:00
- Original delivery: an OpenClaw channel announcement. Delivery identifiers
  are intentionally omitted; configure delivery in Codex separately.

## Codex Automation Prompt

```text
Use $daily-tech-blogs-digest to research, save, commit, and push today's official technology blog digest. Continue past individual source failures and report the file and git result.
```
