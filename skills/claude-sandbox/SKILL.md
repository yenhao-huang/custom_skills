---
name: claude-sandbox
description: Use when the user asks to set up, start, or enter a Claude Code sandbox Docker container. Guide using docker pull, docker run, and docker exec commands to launch an isolated Claude Code environment with bypassPermissions. Trigger on "開 claude sandbox", "start claude sandbox", "run claude in docker", "create claude sandbox", "進 claude 容器".
---

# Claude Sandbox

Run Claude Code in an isolated Docker container with `bypassPermissions` mode -- no permission prompts.

## On Skill Load

**When this skill is loaded, immediately generate `shell/start.sh` in the `claude-sandbox` project directory and write the full setup + run script into it.** Do not wait for the user to ask.

Use this template:

```bash
#!/usr/bin/env bash
set -euo pipefail

RUNTIME_DIR="/tmp/claude-sandbox-runtime"
CONTAINER_NAME="claude-docker"
IMAGE="claude-sandbox"
MODEL_DIR="/tmp2/share_data"
DATA_DIR="/mnt/share_data_78"

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
```

After writing the file, run `chmod +x shell/start.sh` and report the path to the user.

## Setup (First-time)

### Pull image

```bash
docker pull yenhao123/claude-sandbox:latest
docker tag yenhao123/claude-sandbox:latest claude-sandbox
```

### Prepare runtime directory

```bash
RUNTIME_DIR="/tmp/claude-sandbox-runtime"
mkdir -p "${RUNTIME_DIR}/ssh" "${RUNTIME_DIR}/claude-home/.claude"
cp ~/.claude/.credentials.json "${RUNTIME_DIR}/claude-home/.claude/.credentials.json"
cp ~/.claude/settings.json     "${RUNTIME_DIR}/claude-home/.claude/settings.json"
cp ~/.ssh/id_ed25519           "${RUNTIME_DIR}/ssh/id_ed25519"
cp ~/.ssh/id_ed25519.pub       "${RUNTIME_DIR}/ssh/id_ed25519.pub"
cp ~/.ssh/known_hosts          "${RUNTIME_DIR}/ssh/known_hosts"
chmod 600 "${RUNTIME_DIR}/claude-home/.claude/.credentials.json"
chmod 600 "${RUNTIME_DIR}/ssh/id_ed25519"
```

### Start container

```bash
RUNTIME_DIR="/tmp/claude-sandbox-runtime"
MODEL_DIR="/tmp2/share_data"
DATA_DIR="/mnt/share_data_78"

docker run -d \
  --name claude-docker \
  --restart unless-stopped \
  -v "${RUNTIME_DIR}/claude-home:/claude-home" \
  -v "${RUNTIME_DIR}/ssh:/claude-home/.ssh:ro" \
  -v "/tmp2/howard:/workspace" \
  -v "${MODEL_DIR}:/models" \
  -v "${DATA_DIR}:/data" \
  -w /workspace \
  --network host \
  --entrypoint sleep \
  claude-sandbox infinity
```

## Daily Usage

Run from your project directory:

```bash
docker exec -it \
  -w "/workspace/$(realpath --relative-to="/tmp2/howard" "$(pwd)")" \
  --user "$(id -u):$(id -g)" \
  -e HOME=/claude-home \
  claude-docker claude
```

## Check / Restart Container

```bash
# Check if running
docker ps --filter name=claude-docker

# Stop and remove
docker stop claude-docker && docker rm claude-docker

# Restart: re-run the docker run command in Setup
```

## Build Custom Image

```bash
docker build -t claude-sandbox .
docker tag claude-sandbox yenhao123/claude-sandbox:<version>
docker push yenhao123/claude-sandbox:<version>
```

## Key Design

| Detail | Value |
|--------|-------|
| Container name | `claude-docker` |
| Runtime dir | `/tmp/claude-sandbox-runtime` |
| Workspace mount | `/tmp2/howard` -> `/workspace` |
| Credentials | `/claude-home/.claude/` |
| User | host UID:GID (non-root) |
| Restart policy | `unless-stopped` |
