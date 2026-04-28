---
name: dev
description: Use for software development tasks, especially when the user asks to design, implement, debug, test, refactor, benchmark, or run experiments. Always apply the Superpowers design/develop/test workflow and use ralph-loop for experiment iteration when experiments, benchmarks, ablations, or uncertain technical choices are involved.
---

# Dev

Use this skill for coding work and engineering experiments.

## Required Habits

1. Use Superpowers for the development workflow:
   - `design`: clarify the target behavior, constraints, risks, and smallest useful implementation.
   - `develop`: make scoped changes that fit the existing codebase.
   - `test`: run the most relevant validation and report what passed or could not be run.

2. Use `ralph-loop` for experiments:
   - Use it when the task involves experiments, benchmarks, ablations, model/data comparisons, hyperparameters, performance tuning, or uncertain technical choices.
   - Treat each loop as: hypothesis -> command/config -> result -> decision -> next loop.
   - Keep experiment outputs reproducible by recording commands, changed configs, inputs, metrics, and artifacts.
   - Stop when the result answers the question, the next step is blocked, or the user-provided budget is reached.

## Workflow

### Design

- Read the local context before deciding.
- State the intended change or experiment briefly when the work is non-trivial.
- Prefer existing project conventions over new abstractions.
- Define the validation target before editing or running experiments.

### Develop

- Keep edits narrowly scoped.
- Preserve user changes and avoid unrelated cleanup.
- Use deterministic scripts or config files when an experiment will be repeated.
- For experiment work, isolate outputs under the project's existing output/log directory when one exists.

### Test

- Run focused tests, linters, type checks, or smoke commands that directly cover the change.
- For experiments, summarize the ralph-loop table with command/config, key metric, observation, and next decision.
- If validation cannot run, report the blocker and the best available static check.

## Output Style

Final responses should include:

- What changed or what experiment was run.
- Validation results.
- For ralph-loop work, the final decision and the most relevant metric or artifact path.
