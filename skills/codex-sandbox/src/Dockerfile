FROM node:20-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-client \
    git \
    sudo \
    curl \
    ca-certificates \
  && rm -rf /var/lib/apt/lists/*

RUN npm install -g @openai/codex@0.125.0

ARG UID=1000
ARG GID=1000
ARG USERNAME=howard

RUN groupadd -g "${GID}" "${USERNAME}" \
 && useradd -m -u "${UID}" -g "${GID}" -s /bin/bash "${USERNAME}" \
 && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USERNAME} \
 && chmod 0440 /etc/sudoers.d/${USERNAME}

WORKDIR /workspace

USER ${USERNAME}
