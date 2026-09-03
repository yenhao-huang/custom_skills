# Target Configuration

Resolve the personal Notion daily page in this order:

1. A page URL or page ID explicitly supplied by the user.
2. The private environment value `NOTION_DAILY_PAGE_URL`.
3. A project-local private configuration already documented by the user.

If no target is available, ask for the page URL and stop before writing. Do not
commit a personal Notion page ID to this repository.
