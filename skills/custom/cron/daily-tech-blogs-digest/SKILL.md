---
name: daily-tech-blogs-digest
description: Research the latest official NVIDIA, Google, OpenAI, Meta, Apple, and Anthropic posts, write a resilient Traditional Chinese daily digest with reverse-date naming, then commit and push it. Use for the migrated tech-blog cron, manual reruns, or missing digest repair.
---

# Daily Tech Blogs Digest

## Workflow

1. Read `STATE.md`; for a new execution, reset it from
   `references/template/STATE.template.md`. Read `references/cron.md` for
   scheduled-task metadata.
2. Resolve today's `Asia/Taipei` date and calculate
   `SORTKEY = 99999999 - YYYYMMDD`.
3. Process each source independently so one failure does not stop the run:
   - NVIDIA Developer Blog: `https://developer.nvidia.com/blog`
   - Google Research: `https://research.google/blog/`
   - Google Developers: `https://developers.googleblog.com/`
   - OpenAI News: `https://openai.com/news/` and its RSS feed
   - Meta Newsroom: `https://about.fb.com/news/`
   - Apple Machine Learning Research: `https://machinelearning.apple.com/research`
   - Anthropic Engineering: `https://www.anthropic.com/engineering`
4. For each source, select 1-3 recent noteworthy posts. Record the title, date
   when available, a two- or three-sentence Traditional Chinese summary, a
   direct article URL, and one sentence on impact. If there is no clear update,
   say `無明顯更新`; if retrieval fails, say `抓取失敗` with a short reason.
5. Add three `今日整體趨勢` bullets and write
   `~/Desktop/daily/tech/SORTKEY-YYYY-MM-DD-Tech-Blogs.md`, creating the parent
   directory if needed.
6. In `~/Desktop/daily`, inspect the diff, run `git add -A`, commit with
   `chore: add tech blogs YYYY-MM-DD` when changes exist, and push. Do not
   create an empty commit.
7. Verify the output path, `git rev-parse --short HEAD`, and
   `git status --short`; update `STATE.md` with per-source status and git
   evidence.

## Rules

- Use canonical article URLs. A homepage may appear only in a source overview,
  never as the link for an individual post.
- If an NVIDIA article URL is unavailable from the listing, search its exact
  title within `developer.nvidia.com/blog`; otherwise mark the URL unconfirmed.
- Do not wrap all sources in one fail-fast script.
- Do not fabricate posts or links.
- Do not report completion before push succeeds. If commit succeeds but push
  fails, report `已 commit、未 push` and the reason.

## Output

Report the output path, commit message and hash or `no changes`, push result,
and any failed sources.
