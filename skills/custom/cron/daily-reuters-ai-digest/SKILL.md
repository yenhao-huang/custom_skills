---
name: daily-reuters-ai-digest
description: Read the latest Reuters artificial-intelligence coverage and write a grounded Traditional Chinese daily Markdown digest under the current workspace. Use for the migrated Reuters AI cron, a manual daily digest, or repair of a missing Reuters report.
---

# Daily Reuters AI Digest

## Workflow

1. Read `STATE.md`; for a new execution, reset it from
   `references/template/STATE.template.md`. Read `references/cron.md` for
   scheduled-task metadata.
2. Resolve today's date in `Asia/Taipei` and open
   `https://www.reuters.com/technology/artificial-intelligence/`.
3. If the page does not expose enough current stories, search Reuters for the
   latest matching artificial-intelligence coverage and verify direct article
   URLs before using them.
4. Select 3-8 current, confirmable items. For each, include the original title,
   direct URL, a two- to four-sentence Traditional Chinese summary, and why it
   matters.
5. Create or update `daily/tech/reuters/YYYY-MM-DD.md` relative to the active
   workspace. If no new story can be confirmed, still write the file and state
   `未找到可確認的新 Reuters AI 新聞`.
6. Verify the file and update `STATE.md` with the date, story count, source
   status, and output path.

## Rules

- Prefer the Reuters AI page before broader search.
- Do not fabricate headlines, dates, article details, or URLs.
- Do not modify unrelated daily files.

## Output

Return only a short statement naming the file written and whether confirmed new
stories were found.
