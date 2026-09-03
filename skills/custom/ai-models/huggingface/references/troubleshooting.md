# Troubleshooting

1. Capture the complete error without exposing secrets.
2. Record Python, `transformers`, `huggingface_hub`, `datasets`, `diffusers`,
   and `torch` versions that are relevant to the failing path.
3. Reduce to the smallest reproducible model, asset, and input.
4. Check model-task class, tokenizer or processor pairing, revision, missing
   files, gated access, dtype, device placement, and memory.
5. Change one variable at a time and rerun the reproduction.

Common interpretations:

- Missing config or weights: wrong repository, revision, or incomplete files.
- Tokenizer or processor mismatch: load from the intended model revision.
- Device or dtype mismatch: align tensors and supported precision.
- Repository not found: verify spelling, privacy, gating, and authentication.
- `402 Payment Required`: treat as billing or quota, not model capability.
