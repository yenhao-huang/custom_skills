#!/usr/bin/env bash
set -euo pipefail

RUNTIME_DIR="/tmp/claude-sandbox-runtime"
CONTAINER_NAME="claude-docker"
IMAGE="claude-sandbox"
MODEL_DIR="/mnt/share_data_78/howard/models"
DATA_DIR="/mnt/share_data_78/howard/data"

# Prepare runtime directory
mkdir -p "${RUNTIME_DIR}/ssh" "${RUNTIME_DIR}/claude-home/.claude"
cp ~/.claude/.credentials.json "${RUNTIME_DIR}/claude-home/.claude/.credentials.json"
cp ~/.claude/settings.json     "${RUNTIME_DIR}/claude-home/.claude/settings.json"
cp ~/.ssh/id_ed25519           "${RUNTIME_DIR}/ssh/id_ed25519"
cp ~/.ssh/id_ed25519.pub       "${RUNTIME_DIR}/ssh/id_ed25519.pub"
cp ~/.ssh/known_hosts          "${RUNTIME_DIR}/ssh/known_hosts"
chmod 600 "${RUNTIME_DIR}/claude-home/.claude/.credentials.json"
chmod 600 "${RUNTIME_DIR}/ssh/id_ed25519"

# Remove existing container if present
docker rm -f "${CONTAINER_NAME}" 2>/dev/null || true

# Start container
docker run -d \
  --name "${CONTAINER_NAME}" \
  --restart unless-stopped \
  -v "${RUNTIME_DIR}/claude-home:/claude-home" \
  -v "${RUNTIME_DIR}/ssh:/claude-home/.ssh:ro" \
  -v "/tmp2/howard:/workspace" \
  -v "${MODEL_DIR}:/models" \
  -v "${DATA_DIR}:/data" \
  -w /workspace \
  --network host \
  --entrypoint sleep \
  "${IMAGE}" infinity

# Enter Claude
REL=$(realpath --relative-to="/tmp2/howard" "$(pwd)" 2>/dev/null || echo ".")
[[ "$REL" == ..* ]] && REL="."
docker exec -it \
  -w "/workspace/${REL}" \
  --user "$(id -u):$(id -g)" \
  -e HOME=/claude-home \
  "${CONTAINER_NAME}" claude "$@"
