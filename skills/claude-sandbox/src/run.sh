#!/bin/bash
# Run Claude Code in a persistent Docker container.
# Usage: claude-docker [claude args...]

CONTAINER_NAME="claude-docker"
RUNTIME_DIR="/tmp/claude-sandbox-runtime"

_start_container() {
  mkdir -p "${RUNTIME_DIR}/ssh" "${RUNTIME_DIR}/claude-home/.claude"
  cp "${HOME}/.claude/.credentials.json" "${RUNTIME_DIR}/claude-home/.claude/.credentials.json"
  cp "${HOME}/.claude/settings.json"     "${RUNTIME_DIR}/claude-home/.claude/settings.json"
  cp "${HOME}/.ssh/id_ed25519"           "${RUNTIME_DIR}/ssh/id_ed25519"
  cp "${HOME}/.ssh/id_ed25519.pub"       "${RUNTIME_DIR}/ssh/id_ed25519.pub"
  cp "${HOME}/.ssh/known_hosts"          "${RUNTIME_DIR}/ssh/known_hosts"
  chmod 600 "${RUNTIME_DIR}/claude-home/.claude/.credentials.json"
  chmod 600 "${RUNTIME_DIR}/ssh/id_ed25519"
  chown -R "$(id -u):$(id -g)" "${RUNTIME_DIR}/claude-home"

  docker run -d \
    --name "${CONTAINER_NAME}" \
    --restart unless-stopped \
    -v "${RUNTIME_DIR}/claude-home:/claude-home" \
    -v "${RUNTIME_DIR}/ssh:/claude-home/.ssh:ro" \
    -v "/tmp2/howard:/workspace" \
    -w /workspace \
    --network host \
    --entrypoint sleep \
    claude-sandbox infinity
}

# Start container if not running
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "Starting claude-sandbox container..."
  # Remove exited container if exists
  docker rm -f "${CONTAINER_NAME}" 2>/dev/null || true
  _start_container
fi

# Work out the path inside the container
REL_PATH=$(realpath --relative-to="/tmp2/howard" "${PWD}" 2>/dev/null)
if [[ "$REL_PATH" == ..* ]]; then
  echo "Warning: current directory is outside /tmp2/howard, defaulting to /workspace"
  WORKDIR="/workspace"
else
  WORKDIR="/workspace/${REL_PATH}"
fi

docker exec -it -w "${WORKDIR}" \
  --user "$(id -u):$(id -g)" \
  -e HOME=/claude-home \
  "${CONTAINER_NAME}" claude "$@"
