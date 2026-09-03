# Environment Rules

- Primary language: Python, shell, and Markdown
- Runtime version: inspect the target project's declared Python version
- Package manager: use the target project's existing dependency manager
- Frameworks: Hugging Face Hub, Transformers, Datasets, or Diffusers as requested
- Service manager: none unless the target project declares one
- Required services: Hugging Face network access and authentication for gated or private assets

Do not install globally or invent dependency versions. Report a missing environment before any requested setup.
