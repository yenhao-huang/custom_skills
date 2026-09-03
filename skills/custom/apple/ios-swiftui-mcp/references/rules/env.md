# Environment Rules

- Primary language: Markdown instructions, Swift, or project-declared language
- Runtime version: inspect the active Xcode, Swift, and project requirements
- Package manager: use the project's existing SwiftPM or declared manager
- Frameworks: SwiftUI, Photos, Core ML, Qdrant as present in the project
- Service manager: use only services already declared by the project
- Required services: depend on the selected MCP and project configuration

Do not assume versions, ports, credentials, or services. Verify current tool compatibility before recommending or enabling it.
