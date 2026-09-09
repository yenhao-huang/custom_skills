# File Tree Rules

Read target AGENTS.md, docs/rules/filetree.md, and conventions before editing.
Use bundled conventions only where the target has no conflicting structure.
For new projects, use src/ for application code and shared utilities, scripts/
for startup code, test/ for tests, and observability/ for monitoring/tracing.
Scaffold agreed locations before feature work; avoid speculative directories.

Resolve OpenSpec artifact paths through the CLI. Record planned and actual
file changes in change evidence. Inspect the final file list and diff without
moving or deleting unrelated work.

The skill itself keeps SKILL.md and STATE.md at its root, references under
references/, reusable rules under references/rules/, and the template under
references/template/STATE.template.md. Optional helper code belongs under
references/scripts/ rather than the skill root.
