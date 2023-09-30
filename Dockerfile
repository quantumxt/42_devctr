FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y tzdata git tmux vim build-essential cmake clang \
                                 libbsd-dev gdb lsb-release \
                                 curl sudo \
                                 python3-pip python3-venv
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
RUN useradd -s /bin/bash -m -G sudo $USERNAME && echo "$USERNAME:$USERNAME" | chpasswd && adduser $USERNAME sudo

# Copy vim config
COPY ./config/vimrc /home/user/.vimrc

# Setup
WORKDIR /tmp

# Valgrind installation
RUN curl -O https://sourceware.org/pub/valgrind/valgrind-3.21.0.tar.bz2
RUN tar -xvf valgrind-3.21.0.tar.bz2
RUN cd valgrind-3.21.0 && bash ./configure
RUN cd valgrind-3.21.0 && make && make install

# Add 42 header
RUN git clone https://github.com/42Paris/42header.git
RUN mkdir -p /home/user/.vim/plugin
RUN mv /tmp/42header/plugin/stdheader.vim /home/user/.vim/plugin

# Add gtest
RUN git clone https://github.com/google/googletest.git -b v1.14.0
RUN cd /tmp/googletest && mkdir build           # Create a directory to hold the build output.
WORKDIR /tmp/googletest/build
RUN cmake .. -DBUILD_GMOCK=OFF   # Generate native build scripts for GoogleTest.
RUN make
RUN make install	# Install /usr/local

USER $USERNAME

# Add francinette
WORKDIR /home/$USERNAME
RUN bash -c "$(curl -fsSL https://raw.github.com/xicodomingues/francinette/master/bin/install.sh)"
RUN echo "alias paco="$HOME"/francinette/tester.sh" >> /home/$USERNAME/.bashrc

# Get the Helios tools & install them
WORKDIR /home/$USERNAME
RUN git clone https://github.com/quantumxt/helios.git
RUN cd /home/$USERNAME/helios && . ./install.sh

ENTRYPOINT ["/entrypoint.sh"]
