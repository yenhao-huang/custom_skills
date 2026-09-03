---
name: model-tester
description: Run reproducible local or API-based AI model evaluations across text, architecture, vision, and llama-server speed tasks, preserving per-item responses and source-to-leaderboard traceability. Use when adding a model, rerunning benchmarks, comparing models, diagnosing suspicious scores, or publishing model-evaluation results.
---

# Model Tester

## Workflow

1. Read `STATE.md`; reset it from `references/template/STATE.template.md` for a
   new run. Read `references/models.md`, `references/benchmarks.md`,
   `references/presets.md`, `references/launch-scripts.md`, and
   `references/tips.md` only when their stage is reached.
2. Work only in `~/Desktop/model-tester` or its allowed children. Resolve the
   model, local or API mode, benchmark scope, model abbreviation, and result
   path. Use lowercase kebab-case for new model result directories.
3. Confirm required weights. If local weights are missing, use
   `$download-models`; stop as `blocked` if download or integrity checks fail.
4. Inspect the existing environment and evaluation scripts. Do not create a
   new environment or install packages unless the user separately requests
   setup and the environment policy is known.
5. For local llama-server evaluation, stop the prior model service, launch the
   selected script, and pass the chat-completion ready gate before benchmarking.
   Treat loading, startup crashes, and unavailable services as infrastructure
   states, not model capability results.
6. Unless the user requests another scope, run the no-think default in order:
   - Text-English: `mmlu`, `gsm8k`, `geo-mmlu-high-school`, and
     `law-mmlu-professional`, 100 items each.
   - Text-Arch: `opseval`, 100 items.
   - Vision: OCR, classification, and detection, 100 items each, with 3-5
     image-plus-JSON examples per task.
7. Preserve every item's `idx`, `query`, `gold`, `pred`, `passed`, `skipped`,
   and raw `response`. Keep billing, quota, loading, and transport failures out
   of the scored denominator and label them explicitly.
8. Run the speed sample and capture prompt-eval, eval, and total timing. Write
   model README conclusions, known limitations, launch flags, result JSON, and
   source indexes under `results/<model-abbr>/`.
9. Run the tracked top-level file guard before commit. Inspect, commit, and
   push the evaluation repository when publishing is in scope; verify the
   remote result.
10. Record model, flags, benchmark counts, service readiness, artifact paths,
    score denominators, Git result, and blockers in `STATE.md`.

## Rules

- Default to no-think with `--reasoning off` and
  `--chat-template-kwargs '{"enable_thinking": false}'`. Use thinking only
  when explicitly requested and label every affected artifact.
- Use a 180-second request timeout by default; do not reduce it to an
  aggressive value that creates false regressions.
- Keep tracked repository roots limited to `README.md`, `.gitignore`,
  `eval_speed/`, `results/`, `scripts/`, and `utils/`.
- Never convert environment, quota, or incomplete-run failures into zero
  capability scores.

## Output

Report configuration, readiness, per-benchmark `total`, `scored_total`,
`skipped`, score, artifact paths, speed metrics, known limitations, and Git
publication status.
