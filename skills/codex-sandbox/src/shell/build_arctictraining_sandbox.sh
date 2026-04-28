#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SANDBOX_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
REPO_ROOT="$(cd "${SANDBOX_DIR}/.." && pwd)"

IMAGE_NAME="${IMAGE_NAME:-codex-sandbox:local}"
CONTAINER_NAME="${CONTAINER_NAME:-codex-sandbox-arctictraining}"
USERNAME="${USERNAME:-$(id -un)}"
HOST_UID="${HOST_UID:-$(id -u)}"
HOST_GID="${HOST_GID:-$(id -g)}"
CONTAINER_HOME="${CONTAINER_HOME:-/home/${USERNAME}}"
CONTAINER_WORKDIR="${CONTAINER_WORKDIR:-/workspace}"
WORKSPACE_DIR="${WORKSPACE_DIR:-/tmp2/howard/PRetrieval/ArcticTraining}"
SSH_DIR="${SSH_DIR:-${REPO_ROOT}/.runtime/ssh}"
MODEL_DIR="${MODEL_DIR:-/mnt/share_data_78/howard/models}"
DATA_DIR="${DATA_DIR:-/mnt/share_data_78/howard/data}"
CONTAINER_MODEL_DIR="${CONTAINER_MODEL_DIR:-/models}"
CONTAINER_DATA_DIR="${CONTAINER_DATA_DIR:-/data}"
EXTRA_MOUNTS="${EXTRA_MOUNTS:-}"

if [[ ! -d "${WORKSPACE_DIR}" ]]; then
  echo "WORKSPACE_DIR does not exist: ${WORKSPACE_DIR}" >&2
  exit 1
fi

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
  --build-arg UID="${HOST_UID}" \
  --build-arg GID="${HOST_GID}" \
  --build-arg USERNAME="${USERNAME}" \
  -t "${IMAGE_NAME}" \
  "${SANDBOX_DIR}"

docker_args=(
  run -d
  --user "${HOST_UID}:${HOST_GID}"
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
