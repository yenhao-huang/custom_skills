---
name: daily-news-digest
description: Create the daily Traditional Chinese AI, Taiwan finance, and US market news digests, save them under the personal daily repository with reverse-date filenames, then commit and push the result. Use for the migrated daily news cron, a manual rerun, or repair of a missing daily digest.
---

# Daily News Digest

## Workflow

1. Read `STATE.md`; for a new execution, reset it from
   `references/template/STATE.template.md` and mark context preparation in
   progress. Read `references/cron.md` when this run comes from or will update
   a scheduled task.
2. Resolve today's date in `Asia/Taipei` and calculate
   `SORTKEY = 99999999 - YYYYMMDD`.
3. Research current, verifiable stories and retain direct article URLs:
   - AI: 4-8 items covering models or products, policy, investment, and
     research.
   - Taiwan finance: 6-10 items covering the market, sectors, companies,
     macro policy, and international links.
   - US markets: 6-10 items covering major indices, sectors, large companies,
     the Fed, inflation, employment, and international links.
4. Write Traditional Chinese Markdown to these exact paths, creating only
   missing parent directories:
   - `~/Desktop/daily/ainews/SORTKEY-YYYY-MM-DD-AI-News.md`
   - `~/Desktop/daily/financenews/SORTKEY-YYYY-MM-DD-Finance-News.md`
   - `~/Desktop/daily/usstocknews/SORTKEY-YYYY-MM-DD-US-Stock-News.md`
5. In `~/Desktop/daily`, inspect the diff, run `git add -A`, commit with
   `chore: add daily news YYYY-MM-DD` when changes exist, and push the current
   branch. If there are no changes, record that fact without creating an empty
   commit.
6. Verify all three paths, run `git rev-parse --short HEAD` and
   `git status --short`, then update `STATE.md` with the files, commit result,
   and push result.

## Rules

- Each item must include a title, a one- or two-sentence summary, and a direct
  source link.
- Do not reuse legacy filename forms such as `AI-News-YYYY-MM-DD.md`.
- Do not fabricate current events, dates, prices, or URLs.
- Do not report completion before push succeeds. If commit succeeds but push
  fails, report `已 commit、未 push` and the exact failure.

## Output

Report the three file paths, the commit message and hash or `no changes`, and
whether push succeeded. Keep the handoff concise.
