#!/bin/bash

set -e
DEFAULT_USER_ID=3142

# Ensure host and container have the same user ID. This is to allow both sides
# to read and write the shared directories.
if [ -v USER_ID ] && [ "$USER_ID" != "$DEFAULT_USER_ID" ]; then
    echo "Update user ID to match your host's user ID ($USER_ID)."
    echo "This operation can take a while..."

    usermod --uid $USER_ID user

    # Ensure all files in the home directory are owned by the new user ID
    find /home/user -user $DEFAULT_USER_ID -exec chown -h $USER_ID {} \;
fi

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
