FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
  git \
  curl \
  zsh \
  sudo

RUN useradd -m -s /bin/bash testuser && \
  echo "testuser:test123" | chpasswd && \
  echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER testuser
WORKDIR /home/testuser

COPY --chown=testuser:testuser . /home/testuser/dotfiles

CMD ["/bin/bash"]
