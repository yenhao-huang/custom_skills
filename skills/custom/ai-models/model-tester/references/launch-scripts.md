# Launch Scripts And Readiness

- Script root: `~/Desktop/llama-bash/`
- Target: `~/Desktop/llama-bash/<model-abbr>.sh`

## Model Switch

1. Identify the current llama-server process and exact port.
2. Stop only the old service for that port, then wait 2-5 seconds.
3. Inspect the selected launch script. If missing, adapt the closest existing
   script with the correct model path, port, context, projector, and no-think
   flags; do not overwrite an unrelated script.
4. Launch the service in an observable terminal session or a detached process
   with explicit log path.
5. Poll a minimal `/v1/chat/completions` request. Retry `503 Loading model`
   every 2-3 seconds, up to 30 attempts. `/v1/models` alone is insufficient.
6. Begin evaluation only after HTTP 200 from an actual inference request.

Record script path, launch command, port, log path, and ready signal in the
model README. Treat aborts or crashes as `blocked` infrastructure failures.

For vision models, confirm and pass the required `--mmproj` projector, then run
an image smoke test before the vision benchmarks.
