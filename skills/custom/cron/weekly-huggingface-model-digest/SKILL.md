---
name: weekly-huggingface-model-digest
description: Rank this month's newly published Hugging Face text-generation, text-to-image, and text-to-audio models by likes and save a Traditional Chinese Top 5 survey for each category. Use for the migrated weekly model cron, a manual weekly model survey, or a missing report rerun.
---

# Weekly Hugging Face Model Digest

## Workflow

1. Read `STATE.md`; for a new execution, reset it from
   `references/template/STATE.template.md`. Read `references/cron.md` for
   scheduled-task metadata.
2. Resolve the current month and timestamp in `Asia/Taipei`. Inspect the newest
   existing report under `~/Desktop/daily/huggingface-model-survey/` and retain
   its heading and field structure when it is readable.
3. Query current Hugging Face model metadata and keep only models whose
   `createdAt` falls in the current month. Group by `text-generation`,
   `text-to-image`, and `text-to-audio`.
4. Sort each category by likes descending and retain at most five models. Do
   not replace this with a download-count or all-time popularity ranking.
5. For each model, record publication time, likes, model size (or `未知`), key
   features, training dataset when available, and the direct Hugging Face model
   URL. If a model is explicitly marked uncensored, state `移除 safety 限制`
   and report whether evidence confirms a `claude-4.6-opus-dataset` fine-tune.
6. Write the report to
   `~/Desktop/daily/huggingface-model-survey/YYYY-MM-DD_HH-MM.md`, creating the
   parent directory if needed.
7. Verify the file and update `STATE.md` with the query filters, category
   counts, and saved path.

## Rules

- Use current, source-backed metadata; do not infer an uncensored label,
  dataset, size, or publication date without evidence.
- If a field is unavailable, write `未知` instead of fabricating it.
- Use `### 1) 模型名` style headings and bulleted model fields.
- If writing fails, report the exact error and a concrete retry suggestion.

## Output

Report the full saved path and briefly note any category with fewer than five
qualifying models.
