# Benchmark Catalog

## Default Evaluation

- Text-English: `mmlu`, `gsm8k`, `geo-mmlu-high-school`,
  `law-mmlu-professional`
- Text-Arch: `opseval`
- Vision: `ocr`, `classification`, `detection`

Run 100 items for each benchmark independently. The earlier OpenClaw reference
that said 20 items was stale and conflicted with the mandatory workflow; 100 is
the canonical default. Preserve every raw response.

## Optional Built-ins

- `truthfulqa`
- `humaneval`
- `fast-textgen-evalset` at `~/Desktop/datasets/fast-textgen-evalset`

Only change benchmarks or item counts when the user requests a partial, smoke,
fast, or custom run. State the changed denominator in every summary.
