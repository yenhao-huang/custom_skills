# Local Model Selection

- Model root: `~/Desktop/models/`
- Result root: `~/Desktop/model-tester/results/`

Before listing choices, scan the actual model root and derive available models
at runtime. Do not maintain a stale static inventory in this skill.

Use the user's model when specified. Otherwise list compatible local options
and select the default preset only when its model exists. After selection,
record model repository, short kebab-case abbreviation, actual weight path,
format or quantization, revision when known, and file integrity result.

When required weights or projector files are absent, use `$download-models` and
continue only after successful verification.
