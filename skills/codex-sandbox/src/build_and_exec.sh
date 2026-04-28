if docker ps -a --format '{{.Names}}' | grep -q '^codex-sandbox$'; then
    docker stop codex-sandbox
    docker rm codex-sandbox
fi

docker build \
  --build-arg UID="$(id -u)" \
  --build-arg GID="$(id -g)" \
  --build-arg USERNAME=howard \
  -t codex-sandbox:local \
  .

# 建立永久 container
docker run -d \
    --name codex-sandbox \
    -w /workspace \
    -e HOME=/home/howard \
    -v /tmp2/howard/side_project/RAG:/workspace \
    -v /tmp2/howard/side_project/sandbox_utils/.runtime/ssh:/home/howard/.ssh:ro \
    -v /mnt/share_data_78/howard/models/:/models \
    -v /mnt/share_data_78/howard/data/:/data \
    codex-sandbox:local \
    sleep infinity

# 進入 container
docker exec -it codex-sandbox bash
