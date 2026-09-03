---
name: ios-swiftui-mcp
description: Select and verify MCP tools for Swift, SwiftUI, Xcode, profiling, previews, and Apple documentation, and apply the personal apple_query_any_img photo-search project context. Use for iOS tool selection, SwiftUI development workflows, or the ColNomic and Qdrant iPhone photo-search project.
---

# iOS SwiftUI MCP Guide

## Workflow

1. Read `STATE.md`; reset it from `references/template/STATE.template.md` for a
   new run. Identify whether the request is tool selection or work on
   `~/Desktop/apple_query_any_img`.
2. For the photo-search project, inspect the live project before assuming its
   structure, runtime, or current plan. Read `references/photo-search-survey.md`
   only when competitive or architecture context is relevant.
3. For MCP recommendations, verify current repository activity,
   compatibility, installation method, permissions, and supported Codex client
   before recommending a tool. Treat the reference list as a dated snapshot.
4. Prefer an already configured, least-privilege tool that directly supports
   the requested Apple documentation, build, preview, test, simulator, or
   profiling action.
5. Execute or document the selected workflow and verify its observable output,
   such as build result, screenshot, test report, profiling trace, or retrieved
   documentation.
6. Record project path, selected tool, compatibility evidence, operation, and
   validation in `STATE.md`.

## Rules

- Do not assume an MCP server supports Codex because it supports another
  client.
- Do not reuse stale star counts as current popularity evidence.
- Do not install or enable an MCP server unless the user requests setup; when
  setup is requested, document exact rollback and validate the lifecycle.
- Preserve the user's existing project layout rather than depending on the
  excluded `project-convention` skill.

## Output

Return the chosen approach, verified compatibility, commands or actions,
result evidence, and any project-specific caveats.
