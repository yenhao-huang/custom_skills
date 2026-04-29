---
name: sandox-tutorial
description: tutorial for installation of skill and mcp
---

## 下載 skill

```
git clone git@github.com:yenhao-huang/custom_skills.git
mkdir ~/.agents
mv custom_skills/skills ~/.agents/skills
```

## 設定環境
安裝 vllm、llama-server (gpu 版本)

## 設定 mcp
* github mcp

howard@bc797f0862c6:/codex-sandbox$ vim ~/.codex/config.toml
howard@bc797f0862c6:/codex-sandbox$ vim ~/.bashrc

## 設定 AGENTS.md

```
# Repository Agent Instructions

## Environment Setup Rule

Before installing or changing any development environment, package manager state, CLI, Python runtime, virtual environment, or pip dependency, agents must first read the Dev skill environment manual:

`dev skill reference/convention.md`

This applies to actions such as:

- Creating, deleting, repairing, or replacing `.venv` or any other virtual environment.
- Running `pip install`, `pip uninstall`, `python -m pip`, `conda`, `mamba`, `uv`, or equivalent package commands.
- Installing local CLIs, agent runners, model-serving tools, or helper scripts.
- Changing `.env`, PATH, Python runtime variables, model paths, or environment activation flow.
- Installing dependencies for tests, CI, model serving, or data/evaluation pipelines.

If `dev skill reference/convention.md` cannot be found or read, do not proceed with environment installation or mutation. Report that the environment manual is missing and ask for the correct path or contents.

## Existing Environment

Prefer the repository's existing environment and activation conventions over creating a new one. Do not create a dedicated or replacement environment unless the convention manual explicitly allows it or the user explicitly approves it after being told why the existing environment cannot be used.

## Scope Control

Keep environment changes local to the repository and avoid global installs. Do not modify unrelated files while changing environment setup.

## Generation Workflow

When the user asks to generate retriever questions, `gen_ques`, or an LLM generation run, do not stop after the first failed attempt. Wrap the run in the repo-local Ralph loop:

```bash
python core/cli/ralph_loop.py --config configs/ralph/gen_ques_for_retriever.json
```

The loop must retry up to its configured attempt count, run recovery commands after failed attempts, and only report success after verification passes. If the first attempt fails because a service, model endpoint, or helper process is missing, use the recovery phase to start or validate it before the next attempt.
```