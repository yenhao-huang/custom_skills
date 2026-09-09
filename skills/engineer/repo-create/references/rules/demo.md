# Issue Acceptance Demo Rules

Use this reference when writing `docs/rules/demo.md`. Every resolved issue must
have an acceptance package prepared in its issue worktree and linked from its
PR before it is reported as accepted. In-progress packages may exist but must
state failed, blocked, or unrun criteria honestly. A closed issue or open PR is
not proof that acceptance passed.

## Directory And Stable Ordering

```text
demo/
    issues-<view-id>-<issue-id>/
        reports.md
        reproduce.md
        detail/
```

Use exactly this directory name, with no trailing hyphen or optional title.
`issue-id` is the positive decimal GitHub issue number without leading zeros.
Use one package per issue in a repository; update the same package on follow-up
runs and retain relevant prior evidence under distinct run names in `detail/`.

`view-id` is the six-character, lowercase base36 encoding of
`(36**6 - 1) - issue-id`, left-padded with zeroes. The digit alphabet is
`0123456789abcdefghijklmnopqrstuvwxyz`; `zzzzzz` represents 2,176,782,335.
This is integer subtraction followed by encoding, not string subtraction.

```python
def demo_directory(issue_id: int) -> str:
    width = 6
    maximum = 36**width - 1
    if type(issue_id) is not int or not 1 <= issue_id <= maximum:
        raise ValueError("issue_id must be an integer from 1 to 2176782335")
    value = maximum - issue_id
    alphabet = "0123456789abcdefghijklmnopqrstuvwxyz"
    digits = []
    for _ in range(width):
        value, digit = divmod(value, 36)
        digits.append(alphabet[digit])
    view_id = "".join(reversed(digits))
    return f"issues-{view_id}-{issue_id}"
```

| Issue ID | Directory |
| --- | --- |
| 1 | `issues-zzzzzy-1` |
| 35 | `issues-zzzzz0-35` |
| 36 | `issues-zzzzyz-36` |
| 2,176,782,335 | `issues-000000-2176782335` |

The frontend must sort canonical directory names ascending using ordinal/ASCII
comparison with numeric/natural sorting disabled. Fixed width and this alphabet
then put larger issue numbers first, including base36 digit boundaries. Do not
sort the decimal suffix as text. A frontend may alternatively sort the parsed
issue number numerically descending. Names remain stable when new issues arrive;
never derive the key from current issue count, time, or completion order.
Reject out-of-range IDs instead of wrapping or truncating them. If the range is
ever exhausted, define a versioned naming migration and update all consumers
before changing width; mixed widths do not preserve this sorting contract.

## reports.md: Human Acceptance Summary

Keep the top level concise and easy to scan. Prefer compact tables and bullets
rather than long prose. Use this order:

1. **Results and insights** at the very top: acceptance verdict, the most
   important measured changes, and 2-5 focused insights. State what the results
   mean, remaining limitations, and whether each insight is measured or inferred.
2. **Results table**: criterion/experiment, baseline when applicable, observed
   result, unit, target, PASS/FAIL/BLOCKED/NOT RUN, and a link to evidence. Show
   only headline measurements here, with sample size or uncertainty when relevant.
3. **Issue and change summary**: issue/PR links, tested source commit, environment
   identifier, run date, and short bullets describing what changed.
4. **Review and reproduction links**: link `reproduce.md` and the relevant
   `detail/` artifacts; list unresolved criteria and follow-up actions.

Put per-case results, complete experiment tables, logs, traces, screenshots,
configurations, and methodology in `detail/`, linked next to each claim. Do not
bury important failures in detail, paste full logs into the summary, or fabricate
metrics. For non-experimental work, report observable acceptance checks instead
of inventing an experiment. Distinguish tested code from later report-only edits.

## reproduce.md: Developer Review And Execution

A reviewer must be able to inspect the change and run it without guessing.
Record the tested source commit, relevant changed paths, prerequisites, supported
OS/runtime/tool versions, inputs/fixtures and their provenance, working directory,
required non-secret environment variables, exact script paths/commands, outputs,
and success/failure checks. Use links to maintained scripts rather than copying
logic into documentation. Reference repository startup scripts under `scripts/`
and actual test/result-rendering scripts at their established paths; list any
small issue-specific fixtures or review helpers under `detail/`.

Document two separate initialization paths followed by a shared run sequence:

| Path | Required behavior |
| --- | --- |
| A. Existing environment (default) | Provide the actual command to activate/start/attach to the already provisioned venv, container, or service. Identify its location/name, versions and health checks. The reviewer does not create an environment or install dependencies in this path. |
| B. From scratch | Give exact commands to create an isolated environment, install pinned dependencies from maintained lockfiles/manifests, prepare documented inputs, and start required services. Record versions, health checks, and the resources created. |

If A is unavailable, report the missing environment clearly and offer B
explicitly; do not silently install or recreate anything as the default. Do not
invent environment names, ports, credentials, or claim preprovisioning succeeded.
Keep existing shared environments intact. Scope any cleanup instructions for B
to resources that path created.

After either initialization path, provide the same ordered commands:

1. **Run test script(s)**: exact invocation, input/config/seed as applicable,
   expected exit status and assertions, output directory, and result files.
2. **Run result-display script(s)**: exact invocation consuming those result
   files, expected table/chart/page output, and how the reviewer opens or reads
   it. For console-only checks, name the script that displays the saved summary.
3. **Compare with reports.md**: map acceptance criteria and headline results to
   the generated evidence. Explain tolerances and expected variability.

Record which path and script sequence was actually executed and its outcome.
Validate both paths where available; mark any unrun path with its concrete
reason. Do not claim reproducibility from documentation inspection alone.

## detail/ And Acceptance Gate

Store detailed experimental evidence in named run subdirectories when needed.
Keep small reviewable evidence and scripts in Git; link large generated assets
through the repository's artifact policy with stable identifiers/checksums.
Redact secrets and private data. Avoid machine-specific absolute links in
committed reports. OpenSpec-based projects should link the package to the change,
requirements/tasks, and file-change record rather than maintaining conflicting
acceptance criteria.

Before claiming the issue is accepted, verify:

- The directory name matches the issue ID and ordering formula.
- All three required entries exist and evidence links resolve.
- Headline results and insights precede details; failures remain visible.
- Every acceptance criterion maps to actual evidence and the tested source.
- Both initialization paths and the test -> result-display sequence are concrete;
  executed checks passed, and all limitations or unrun paths are disclosed.
- PR links point to the package and the relevant issue; `git diff --check` passes.

A package intended for humans is contributor-maintained issue evidence. It does
not replace or implicitly authorize changes to `docs/human/` governed by
`human-docs.md`. When adopting these rules in an existing repository, document
migration scope explicitly; do not invent historical demos or claim retroactive
validation for older closed issues.
