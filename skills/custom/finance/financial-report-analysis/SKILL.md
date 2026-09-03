---
name: financial-report-analysis
description: Analyze company financial reports with current Yahoo Finance data, show three-to-five-year numeric evidence for valuation, income statement, balance sheet, and cash-flow checks, then save and publish a Traditional Chinese report. Use for company comparisons, financial screening, 財報整理, or 財報指標檢查.
---

# Financial Report Analysis

## Workflow

1. Read `STATE.md`; reset it from `references/template/STATE.template.md` for a
   new run. Read `references/indicators.md` before calculating or judging an
   indicator.
2. Resolve the requested companies and reporting period. Use current Yahoo
   Finance summary, financials, balance-sheet, cash-flow, and key-statistics
   pages; cross-check ambiguous units or periods before calculation.
3. Collect at least three annual periods and prefer five for revenue, gross
   profit, net income, total assets, total liabilities, operating cash flow,
   investing cash flow, and free cash flow.
4. Calculate every requested ratio from displayed inputs. Apply the checks in
   `references/indicators.md` and label each result `✅` or `❌`.
5. Write the Traditional Chinese report under
   `~/Desktop/Daily/survey/financial_reports/<company-group>/`, preserving
   existing files unless replacement is requested.
6. Inspect the repository diff, commit with
   `chore: add financial report focus YYYY-MM-DD` when changes exist, and push.
7. Verify saved paths, commit hash or `no changes`, and push status; record the
   evidence in `STATE.md`.

## Rules

- Show the actual numbers, units, periods, formulas, and source URLs behind
  every indicator result.
- Do not mix quarterly and annual figures in the same ratio.
- Treat missing or incomparable data as unavailable, not as a pass or fail.
- Do not report publishing complete before push succeeds. Report
  `已 commit、未 push` if only the commit succeeded.

## Output

Include company and ticker, Yahoo Finance URLs, three-to-five-year tables,
calculation traces, indicator results, saved paths, and Git result.
