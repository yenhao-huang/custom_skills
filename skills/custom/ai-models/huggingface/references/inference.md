# Local Inference

1. Inspect the target project's existing Python environment and dependency
   files. If the required environment is absent, report it before installing.
2. Confirm model class, tokenizer or processor, revision, dtype, device, memory,
   and maximum context.
3. Start with the smallest representative input and bounded output length.
4. Verify output type, shape, and obvious truncation or device errors before a
   larger run.

For quick text generation, prefer `transformers.pipeline` when already
available. For constrained hardware, consider a smaller or quantized model and
state the quality tradeoff. Do not add ad hoc global packages.
