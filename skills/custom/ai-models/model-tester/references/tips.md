# Model Tester Failure Guards

## Context Alignment

When testing a 16,384-token condition, make both settings explicit:

- server: `--ctx-size 16384`
- evaluator: `--max-tokens 16384`

Inspect the running process commands before trusting the label on a result.

## Result Layout

- Text JSON: `results/<model-abbr>/text/results/`
- Vision JSON: `results/<model-abbr>/vision/results/`
- Vision examples: `results/<model-abbr>/vision/examples/<benchmark>/`
- Other tasks: `results/<model-abbr>/<task>/results/`
- Model README: `results/<model-abbr>/README.md`
- Source indexes: `results/<model-abbr>/text_sources.json` and
  `results/<model-abbr>/vision_sources.json`

Never write model-specific tracked artifacts into a top-level model directory.

## Scoring

- `402 Payment Required`: mark `skipped`; exclude from accuracy denominator.
- `503 Loading model`: pause evaluation and return to the ready gate.
- Transport failure: retry within the request policy and preserve the error in
  `response`; do not automatically score it incorrect.
- Missing projector: report unsupported current configuration, not failed
  visual capability.

## Vision

Use the actual dataset directories under
`~/Desktop/datasets/vision-dataset/`. Convert CMYK inputs to RGB before PNG
conversion, add request retries, and preserve 3-5 examples per benchmark.
