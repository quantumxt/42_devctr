FROM ubuntu:22.04

RUN apt update && apt install git tmux vim build-essential gdb valgrind python3-pip -y

# Get norminette
RUN python3 -m pip install --upgrade pip setuptools
RUN python3 -m pip install norminette==3.3.52

# Prep env
COPY ./config/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Add user
ENV USERNAME user
RUN useradd -s /bin/bash -m -G sudo $USERNAME && echo "$USERNAME:$USERNAME" | chpasswd

# Copy vim config
COPY ./config/vimrc /home/user/.vimrc

# Add 42 header
WORKDIR /tmp
RUN git clone https://github.com/42Paris/42header
RUN mkdir -p /home/user/.vim/plugin
RUN mv /tmp/42header/plugin/stdheader.vim /home/user/.vim/plugin

USER $USERNAME
ENTRYPOINT ["/entrypoint.sh"]
