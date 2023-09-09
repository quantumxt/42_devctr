FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install tzdata git tmux vim build-essential gdb valgrind python3-pip -y

# Copy system timezone
COPY ./tz_tmp /tmp/timezone_target
RUN ln -fs /usr/share/zoneinfo/$(cat /tmp/timezone_target) /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata

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

# Copy tools to bin
RUN mkdir -p /home/user/bin
COPY ./tools/checknorm.sh /usr/local/bin/checknorm
COPY ./tools/get_cfiles.sh /usr/local/bin/get_cfiles

USER $USERNAME
ENTRYPOINT ["/entrypoint.sh"]
