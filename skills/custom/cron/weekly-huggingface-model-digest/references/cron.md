# Cron Migration

- OpenClaw job ID: `5b4aca04-dffb-4d70-99e1-f9ce66164dcc`
- Original expression: `0 3 * * 1`
- Timezone: `Asia/Taipei`
- Intended cadence: every Monday at 03:00
- Original delivery: an OpenClaw announcement with no portable destination.
  Configure delivery in Codex separately.

## Codex Automation Prompt

```text
Use $weekly-huggingface-model-digest to rank this month's new Hugging Face models in the three required categories and save the weekly Traditional Chinese report. Return the full output path.
```
