FROM node:20-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-client \
    git \
    sudo \
    curl \
    ca-certificates \
    build-essential \
    pkg-config \
    python3-dev \
    python3 \
    python3-pip \
    python3-venv \
    git-lfs \
    rsync \
    less \
    vim \
    nano \
    tmux \
    jq \
    ripgrep \
    fd-find \
    tree \
    unzip \
    zip \
    procps \
    psmisc \
    lsof \
    net-tools \
    iputils-ping \
    dnsutils \
  && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3 /usr/local/bin/python \
 && ln -s /usr/bin/pip3 /usr/local/bin/pip \
 && ln -s /usr/bin/fdfind /usr/local/bin/fd

RUN python -m pip install --no-cache-dir --break-system-packages \
    uv \
    virtualenv \
    ipython \
    pytest \
    pytest-cov \
    ruff \
    black \
    mypy \
    pre-commit \
    requests \
    pyyaml \
    rich \
    numpy \
    pandas \
    tqdm \
    pillow

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
