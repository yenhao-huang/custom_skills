---
name: daily-news-ops
description: Coordinate the personal daily-news and official tech-blog digest workflows, write reverse-date Markdown under ~/Desktop/daily, and publish the resulting changes through Git. Use when the user requests either digest, both digests together, a manual rerun, or repair of missing daily output.
---

# Daily News Operations

## Workflow

1. Read `STATE.md`; reset it from `references/template/STATE.template.md` for a
   new run. Read `references/publishing.md` before writing or publishing.
2. Determine the requested workflow:
   - For AI, Taiwan finance, or US-market news, use
     `$daily-news-digest` when available.
   - For official technology blogs, use `$daily-tech-blogs-digest` when
     available.
   - When both are requested, run both workflows and preserve their separate
     output contracts.
3. If a specialized skill is unavailable, follow the fallback requirements in
   `references/publishing.md`; do not silently omit part of the request.
4. Verify every generated path and inspect the Git diff in `~/Desktop/daily`.
5. Commit and push according to the selected workflow. Record file paths,
   commit hash or `no changes`, and push status in `STATE.md`.

## Rules

- Resolve dates in `Asia/Taipei` and use the reverse-date sort key.
- Require direct article URLs and process multi-source digests with per-source
  failure isolation.
- Do not write output inside an OpenClaw workspace.
- Do not report publishing complete until push succeeds. If commit succeeds
  but push fails, report `已 commit、未 push` and the reason.

## Output

Report all generated paths, the commit message and hash or `no changes`, push
status, and failed sources.
