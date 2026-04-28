# claude-sandbox

Claude Code running in an isolated Docker container with `bypassPermissions` mode built in — no manual permission prompts.

Docker Hub: [yenhao123/claude-sandbox](https://hub.docker.com/r/yenhao123/claude-sandbox)

---

## First-time Setup

### 1. Clone this repo

```bash
git clone https://github.com/yenhao-huang/sandbox_utils.git
cd sandbox_utils/claude-sandbox
```

### 2. Pull image

```bash
docker pull yenhao123/claude-sandbox:latest
docker tag yenhao123/claude-sandbox:latest claude-sandbox
```

### 3. Copy Claude credentials

```bash
# Copy from another machine, or log in to generate
scp oldmachine:~/.claude/.credentials.json ~/.claude/.credentials.json
chmod 600 ~/.claude/.credentials.json
```

### 4. Prepare runtime directory

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

### 5. Start container

```bash
RUNTIME_DIR="/tmp/claude-sandbox-runtime"
MODEL_DIR="/mnt/share_data_78/howard/models"
DATA_DIR="/mnt/share_data_78/howard/data"

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

---

## Daily Usage

```bash
cd /your/project
docker exec -it \
  -w "/workspace/$(realpath --relative-to="/tmp2/howard" "$(pwd)")" \
  --user "$(id -u):$(id -g)" \
  -e HOME=/claude-home \
  claude-docker claude
```

The container runs persistently (`--restart unless-stopped`). If the container is not running, repeat step 5 to start it again.

---

## How It Works

- Runtime files (`credentials.json`, `settings.json`, SSH keys) are copied to `/tmp/claude-sandbox-runtime/` and mounted into the container.
- `/tmp2/howard` is mounted as `/workspace`; the working directory inside the container mirrors your current path on the host.
- Claude runs as the host user (non-root) via `--user $(id -u):$(id -g)` so `bypassPermissions` is not blocked.
- `HOME` is set to `/claude-home` where credentials are placed at `/claude-home/.claude/`.

---

## Upgrading the Image

```bash
# After editing the Dockerfile
docker build -t claude-sandbox .
docker tag claude-sandbox yenhao123/claude-sandbox:<new-version>
docker tag claude-sandbox yenhao123/claude-sandbox:latest
docker push yenhao123/claude-sandbox:<new-version>
docker push yenhao123/claude-sandbox:latest
```

---

## Tags

| Tag | Description |
|-----|-------------|
| `latest` | Latest build |
| `2.1.119-bypass` | Claude Code 2.1.119 with bypassPermissions entrypoint |
