---
name: codex-sandbox-script
description: Use when the user asks to create, set up, build, or run a Codex sandbox. Create a bash script the user can execute later to build the Docker image, prepare SSH files, start a persistent Codex sandbox container, and enter it. Do not execute the generated script unless the user explicitly asks. Trigger on requests such as "建立 codex sandbox", "create a codex sandbox", "幫我開 codex sandbox", or "make a sandbox for Codex".
---

# Codex Sandbox Script

When the user asks to create a Codex sandbox, write a bash script for them to run instead of only explaining Docker commands. The final output of the workflow is the `.sh` file; do not run it yourself unless the user explicitly requests execution.

## Required Questions

Before writing the script, ask these questions unless the user already provided the answers:

1. Do you want to mount a model directory? If yes, ask for the host path and container path. Default container path: `/models`.
2. Do you want to mount a data directory? If yes, ask for the host path and container path. Default container path: `/data`.
3. Besides the workspace, SSH directory, model directory, and data directory, do you need any extra mounted directories? If yes, ask for each mount as `host_path:container_path` or `host_path:container_path:ro`.

If the user wants to proceed without answering, create the script with empty `MODEL_DIR`, `DATA_DIR`, and `EXTRA_MOUNTS` variables so they can configure mounts later.

## Workflow

1. Inspect the repository enough to find the `codex-sandbox/` directory and its `Dockerfile`.
2. Ask the required mount questions above before editing files, unless the user already answered them.
3. Create a new script under `codex-sandbox/shell/` when editing this repo. Do not create, overwrite, or modify `codex-sandbox/build_and_exec.sh`. When no project convention exists, create a new `build_codex_sandbox.sh`-style script in the user's current workspace.
4. Make the script executable with `chmod +x <script>`.
5. Keep paths configurable through environment variables, with safe defaults.
6. Include `set -euo pipefail`.
7. If a container with the chosen name already exists, stop and remove it before starting a new one.
8. Build `codex-sandbox:local` using the host UID, GID, and username.
9. Prepare an SSH directory under `.runtime/ssh` if SSH keys exist on the host. Copy `id_ed25519`, `id_ed25519.pub`, and `known_hosts` only when present; set strict permissions.
10. Write the script so that, when the user runs it later, it starts a detached container that sleeps forever and mounts the workspace, SSH directory, optional model/data directories, and any extra mount directories.
11. Write the script so that, when the user runs it later, it ends with `docker exec -it "${CONTAINER_NAME}" bash` and lands inside the container.
12. Stop after creating and syntax-checking the `.sh` file. Do not run the script or execute Docker commands yourself unless the user explicitly asks you to run it.

## Script Template

Use this structure unless the repo already has stronger conventions:

```bash
#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

IMAGE_NAME="${IMAGE_NAME:-codex-sandbox:local}"
CONTAINER_NAME="${CONTAINER_NAME:-codex-sandbox}"
USERNAME="${USERNAME:-$(id -un)}"
CONTAINER_HOME="${CONTAINER_HOME:-/home/${USERNAME}}"
CONTAINER_WORKDIR="${CONTAINER_WORKDIR:-/workspace}"
WORKSPACE_DIR="${WORKSPACE_DIR:-$(dirname "${SCRIPT_DIR}")}"
SSH_DIR="${SSH_DIR:-${SCRIPT_DIR}/../.runtime/ssh}"
MODEL_DIR="${MODEL_DIR:-}"
DATA_DIR="${DATA_DIR:-}"
CONTAINER_MODEL_DIR="${CONTAINER_MODEL_DIR:-/models}"
CONTAINER_DATA_DIR="${CONTAINER_DATA_DIR:-/data}"
EXTRA_MOUNTS="${EXTRA_MOUNTS:-}"

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
  "${SCRIPT_DIR}"

docker_args=(
  run -d
  --name "${CONTAINER_NAME}"
  -w "${CONTAINER_WORKDIR}"
  -e "HOME=${CONTAINER_HOME}"
  -v "${WORKSPACE_DIR}:${CONTAINER_WORKDIR}"
  -v "${SSH_DIR}:${CONTAINER_HOME}/.ssh:ro"
)

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

Report the script path and the command the user can run. Do not execute the script or any Docker commands unless the user explicitly asks for execution.
