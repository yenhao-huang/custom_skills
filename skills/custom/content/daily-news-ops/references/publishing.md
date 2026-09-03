# Digest Publishing Contract

## Naming

Calculate `SORTKEY = 99999999 - YYYYMMDD` and use:

- `~/Desktop/daily/ainews/SORTKEY-YYYY-MM-DD-AI-News.md`
- `~/Desktop/daily/financenews/SORTKEY-YYYY-MM-DD-Finance-News.md`
- `~/Desktop/daily/usstocknews/SORTKEY-YYYY-MM-DD-US-Stock-News.md`
- `~/Desktop/daily/tech/SORTKEY-YYYY-MM-DD-Tech-Blogs.md`

Do not create new files with legacy suffix-date names.

## Content Fallback

- Daily news: write 4-8 AI items, 6-10 Taiwan finance items, and 6-10 US
  market items in Traditional Chinese.
- Tech blogs: process NVIDIA, Google Research, Google Developers, OpenAI, Meta,
  Apple ML Research, and Anthropic Engineering independently.
- Put a direct article URL with each entry and a consolidated source list at
  the bottom. If a source fails, mark it `抓取失敗` and continue.

## Git

Run Git only in `~/Desktop/daily`:

1. Inspect changes, then run `git add -A`.
2. Commit with `chore: add daily news YYYY-MM-DD` or
   `chore: add tech blogs YYYY-MM-DD`; skip an empty commit.
3. Push the current branch.
4. Verify with `git rev-parse --short HEAD` and `git status --short`.
