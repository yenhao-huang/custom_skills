FROM node:20-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-client \
    git \
    ca-certificates \
  && rm -rf /var/lib/apt/lists/*

RUN npm install -g @anthropic-ai/claude-code@2.1.119

WORKDIR /workspace

ENTRYPOINT ["claude", "--permission-mode", "bypassPermissions"]
