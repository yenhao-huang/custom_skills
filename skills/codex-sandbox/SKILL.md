---
name: codex-sandbox
description: Use when the user asks to create, set up, build, update, or run a Codex sandbox. Use this skill's bundled src/ directory as the canonical Codex sandbox source path, including src/Dockerfile and src/build_and_exec.sh. Create or update a bash script the user can execute later to build the Docker image, prepare SSH files, start a persistent Codex sandbox container, and enter it. Do not execute Docker commands unless the user explicitly asks. Trigger on requests such as "建立 codex sandbox", "create a codex sandbox", "幫我開 codex sandbox", or "make a sandbox for Codex".
---

# Codex Sandbox

When the user asks to create or update a Codex sandbox, use the bundled `src/` directory beside this `SKILL.md` as the source of truth.

Expected skill layout:

```text
codex-sandbox/
├── SKILL.md
└── src/
    ├── Dockerfile
    ├── README.md
    ├── build_and_exec.sh
    └── shell/
```

The normal deliverable is a `.sh` file the user can run later. Do not run it yourself unless the user explicitly requests execution.

## Path Rules

- Treat `src/` as the Codex sandbox project root.
- Use `src/Dockerfile` as the Docker build definition.
- Use `src/build_and_exec.sh` as the default script to update when working inside this installed skill.
- If the user wants a sandbox in another project, copy or adapt files from this skill's `src/` path into the target path instead of using stale repo paths.
- Put generated runtime files in the target project's `.runtime/` directory. This includes generated sandbox shell scripts such as `.runtime/build_codex_sandbox.sh` and prepared SSH files under `.runtime/.ssh`.
- Do not place generated sandbox scripts at the target project root unless the user explicitly requests that location.
- When adding `.runtime/` files to a target project, ensure the target project's `.gitignore` contains `.runtime/`.
- Do not refer to the old skill name `codex-sandbox-script`.

## Required Questions

Before writing the script, ask these questions unless the user already provided the answers:

1. Do you want to mount a model directory? If yes, ask for the host path and container path. Default container path: `/models`.
2. Do you want to mount a data directory? If yes, ask for the host path and container path. Default container path: `/data`.
3. Besides the workspace, SSH directory, model directory, and data directory, do you need any extra mounted directories? If yes, ask for each mount as `host_path:container_path` or `host_path:container_path:ro`.

If the user wants to proceed without answering, create the script with empty `MODEL_DIR`, `DATA_DIR`, and `EXTRA_MOUNTS` variables so they can configure mounts later.

## Workflow

1. Locate this skill's `src/` directory beside `SKILL.md`; confirm `src/Dockerfile` exists.
2. Ask the required mount questions above before editing files, unless the user already answered them.
3. Update `src/build_and_exec.sh` when editing the installed skill. When creating a sandbox for another project, create a new `.runtime/build_codex_sandbox.sh`-style script in the user's requested target directory and base it on `src/build_and_exec.sh`.
4. Ensure the target project's `.gitignore` contains `.runtime/` before or while adding generated `.runtime/` files. Preserve existing `.gitignore` contents.
5. Make the script executable with `chmod +x <script>`.
6. Keep paths configurable through environment variables, with safe defaults.
7. Include `set -euo pipefail`.
8. Derive the default container name from the target repo directory as `codex-sandox-${REPO_SLUG}`, where `REPO_SLUG` is lowercased, strips a trailing `_forked` or `-forked`, and replaces non-alphanumeric characters with `-`. If a container with the chosen name already exists, stop and remove it before starting a new one.
9. Build `codex-sandbox:local` using the host UID, GID, and username.
10. Prepare an SSH directory under `.runtime/.ssh` if SSH keys exist on the host. Copy `id_ed25519`, `id_ed25519.pub`, and `known_hosts` only when present; set strict permissions.
11. Write the script so that, when the user runs it later, it starts a detached container that sleeps forever and mounts the workspace, SSH directory, optional model/data directories, and any extra mount directories.
12. Write the script so that, when the user runs it later, it ends with `docker exec -it "${CONTAINER_NAME}" bash` and lands inside the container.
13. Stop after creating and syntax-checking the `.sh` file. Do not run the script or any Docker commands unless the user explicitly asks you to run it.

## Script Template

Use this structure unless the repo already has stronger conventions:

```bash
#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
REPO_NAME="$(basename "${PROJECT_DIR}")"
REPO_SLUG="$(printf '%s' "${REPO_NAME}" | sed -E 's/(_forked|-forked)$//I; s/[^A-Za-z0-9]+/-/g; s/^-+|-+$//g' | tr '[:upper:]' '[:lower:]')"

IMAGE_NAME="${IMAGE_NAME:-codex-sandbox:local}"
CONTAINER_NAME="${CONTAINER_NAME:-codex-sandox-${REPO_SLUG}}"
USERNAME="${USERNAME:-$(id -un)}"
CONTAINER_HOME="${CONTAINER_HOME:-/home/${USERNAME}}"
CONTAINER_WORKDIR="${CONTAINER_WORKDIR:-/workspace}"
BUILD_CONTEXT="${BUILD_CONTEXT:-/home/howard/.agents/skills/codex-sandbox/src}"
WORKSPACE_DIR="${WORKSPACE_DIR:-${PROJECT_DIR}}"
SSH_DIR="${SSH_DIR:-${SCRIPT_DIR}/.ssh}"
MODEL_DIR="${MODEL_DIR:-}"
DATA_DIR="${DATA_DIR:-}"
CONTAINER_MODEL_DIR="${CONTAINER_MODEL_DIR:-/models}"
CONTAINER_DATA_DIR="${CONTAINER_DATA_DIR:-/data}"
EXTRA_MOUNTS="${EXTRA_MOUNTS:-}"
GPU_DEVICES="${GPU_DEVICES:-all}"

mkdir -p "${SSH_DIR}"

if [[ -f "${HOME}/.ssh/id_ed25519" ]]; then
  cp "${HOME}/.ssh/id_ed25519" "${SSH_DIR}/"
fi
if [[ -f "${HOME}/.ssh/id_ed25519.pub" ]]; then
  cp "${HOME}/.ssh/id_ed25519.pub" "${SSH_DIR}/"
fi
if [[ -f "${HOME}/.ssh/known_hosts" ]]; then
  cp "${HOME}/.ssh/known_hosts" "${SSH_DIR}/"
fi

chmod 700 "${SSH_DIR}"
if [[ -f "${SSH_DIR}/id_ed25519" ]]; then
  chmod 600 "${SSH_DIR}/id_ed25519"
fi
if [[ -f "${SSH_DIR}/id_ed25519.pub" ]]; then
  chmod 644 "${SSH_DIR}/id_ed25519.pub"
fi
if [[ -f "${SSH_DIR}/known_hosts" ]]; then
  chmod 644 "${SSH_DIR}/known_hosts"
fi

if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  docker stop "${CONTAINER_NAME}"
  docker rm "${CONTAINER_NAME}"
fi

docker build \
  --build-arg UID="$(id -u)" \
  --build-arg GID="$(id -g)" \
  --build-arg USERNAME="${USERNAME}" \
  -t "${IMAGE_NAME}" \
  "${BUILD_CONTEXT}"

docker_args=(
  run -d
  --name "${CONTAINER_NAME}"
  -w "${CONTAINER_WORKDIR}"
  -e "HOME=${CONTAINER_HOME}"
  -e "NVIDIA_VISIBLE_DEVICES=${GPU_DEVICES}"
  -e "NVIDIA_DRIVER_CAPABILITIES=compute,utility"
  -v "${WORKSPACE_DIR}:${CONTAINER_WORKDIR}"
  -v "${SSH_DIR}:${CONTAINER_HOME}/.ssh:ro"
)

if [[ -n "${GPU_DEVICES}" && "${GPU_DEVICES}" != "none" ]]; then
  docker_args+=(--gpus "${GPU_DEVICES}")
fi

if [[ -n "${MODEL_DIR}" ]]; then
  docker_args+=(-v "${MODEL_DIR}:${CONTAINER_MODEL_DIR}")
fi
if [[ -n "${DATA_DIR}" ]]; then
  docker_args+=(-v "${DATA_DIR}:${CONTAINER_DATA_DIR}")
fi
if [[ -n "${EXTRA_MOUNTS}" ]]; then
  IFS=',' read -r -a extra_mounts <<< "${EXTRA_MOUNTS}"
  for mount_spec in "${extra_mounts[@]}"; do
    if [[ -n "${mount_spec}" ]]; then
      docker_args+=(-v "${mount_spec}")
    fi
  done
fi

docker "${docker_args[@]}" "${IMAGE_NAME}" sleep infinity
docker exec -it "${CONTAINER_NAME}" bash
```

## Validation

After writing the script:

```bash
bash -n <script>
```

Also verify the target project's `.gitignore` contains:

```gitignore
.runtime/
```

Report the script path and the command the user can run. Do not execute the script or any Docker commands unless the user explicitly asks for execution.
