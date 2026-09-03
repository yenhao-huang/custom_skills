---
name: finance-glossary
description: Maintain the personal Traditional Chinese finance terminology glossary at its fixed local path, placing new terms near the top, updating duplicates in place, and publishing changes through Git. Use when adding, revising, or reorganizing finance terms.
---

# Finance Glossary

## Workflow

1. Read `STATE.md`; reset it from `references/template/STATE.template.md` for a
   new run. Confirm the target and Git rules in `references/target.md`.
2. Read the current glossary before editing. Preserve the title
   `# 專有名詞彙整` and all unrelated entries.
3. Update an existing term in place, or add a new concise Traditional Chinese
   definition at the top of `## 3) 其他新名詞（新到舊）`.
4. Check for duplicate terms and verify the section ordering.
5. Stage only the glossary file, commit with
   `docs: update finance glossary terms` when changed, and push.
6. Record the edited terms, commit hash or `no changes`, and push result in
   `STATE.md`.

## Rules

- Do not move new terms to the bottom.
- Do not overwrite the file or unrelated entries.
- Do not create duplicate definitions for the same term.
- Do not report publishing complete before push succeeds.

## Output

Report the updated terms, target path, commit hash or `no changes`, and push
status.
