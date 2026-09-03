# Evaluation Presets

## Default

- mode: local
- thinking: off
- text: `mmlu`, `gsm8k`, `geo-mmlu-high-school`,
  `law-mmlu-professional`, `opseval`
- vision: `ocr`, `classification`, `detection`
- items per benchmark: 100
- timeout: 180 seconds

## Smoke

- mode: local
- thinking: off
- benchmark: `gsm8k`
- items: 5
- timeout: 180 seconds

## Fast API

- mode: API
- thinking: off unless the API cannot disable it
- benchmarks: `gsm8k`, `truthfulqa`
- items per benchmark: 10
- timeout: 180 seconds

Do not assume a particular model name. Resolve it from the user's request and
the current local inventory.
