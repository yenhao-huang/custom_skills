---
name: notion-daily-learning
description: Append English learning sentences to today's MMDD subsection under a Notion daily section while preserving all prior dates and content. Use when the user asks to add today's English sentence, update the daily learning section, or append content to the configured personal Notion daily page.
---

# Notion Daily Learning

## Workflow

1. Read `STATE.md`; reset it from `references/template/STATE.template.md` for a
   new run. Read `references/target.md` and resolve the configured target page.
2. Resolve today's date in `Asia/Taipei` as `MMDD`.
3. Read the target page and locate `## daily`. If the section does not exist,
   create it without disturbing unrelated content.
4. Locate `### MMDD`. Create it when missing, then append each new sentence as
   a separate line. Do not duplicate identical content already present.
5. Read the updated section again and verify the new lines and preserved prior
   dates. Record the page, date section, and verification result in `STATE.md`.

## Rules

- Append within today's subsection; never overwrite the full page.
- Preserve all existing dates and unrelated blocks.
- Keep the target page identifier out of the public skill repository.

## Output

Report the target page URL, `MMDD` section, appended line count, and verification
result.
