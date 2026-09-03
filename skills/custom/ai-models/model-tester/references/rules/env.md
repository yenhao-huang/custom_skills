# Environment Rules

- Primary language: Python, shell, JSON, and Markdown
- Runtime version: inspect environments under `~/Desktop/python-venvs`
- Package manager: use the selected existing environment's manager
- Frameworks: llama.cpp or llama-server, Hugging Face, project evaluation utilities
- Service manager: explicit llama-server process and observable terminal session
- Required services: local model weights or authorized API, datasets, sufficient compute and disk

Do not install dependencies or create an environment unless the user separately requests setup. Use a 180-second evaluation timeout by default.
