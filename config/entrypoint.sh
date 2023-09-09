#!/bin/bash

set -e

cd /home/user/workspace

# If no command is provided, set bash to start interactive shell
if [ -z "$1" ]; then
    set - "/bin/bash" -l
fi

# Set color
export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Run the provided command using user
echo "   __ __ ___      ____            ________      "
echo "  / // /|__ \    / __ \___ _   __/ ____/ /______"
echo " / // /___/ /   / / / / _ \ | / / /   / __/ ___/"
echo "/__  __/ __/   / /_/ /  __/ |/ / /___/ /_/ /    "
echo "  /_/ /____/  /_____/\___/|___/\____/\__/_/     "
echo ""                              
exec "$@"
