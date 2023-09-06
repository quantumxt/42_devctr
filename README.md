# 42_devctr

<a href="LICENSE" ><img src="https://img.shields.io/github/license/quantumxt/42_devctr?style=for-the-badge"/></a>

A minimal C development docker environment with vim. (`norminette` &amp; 42Header for `vim` included!)

## Setup

### Prerequistes

Ensure that docker is installed beforehand. More information on installing docker could be found [here](https://www.digitalocean.com/community/tutorial-collections/how-to-install-and-use-docker).

### Username

Update `username` in `config/vimrc` to your own username, which would be used in the 42Header when inserted via `vim`.

```vim
...
let g:user42 = '[YOUR_USERNAME]'
let g:mail42 = '[YOUR_USERNAME]@student.42.fr'
...
```

Next, ensure that the scripts are executable.

```bash
cd 42_devctr
sudo chmod +x build.sh
sudo chmod +x run_devctr.sh
```

## Build

Build the docker image via `build.sh`. It would take some time to build the image.

```bash
cd 42_devctr
./build.sh
```

## Run

Once the build has been completed, run the container via `run_devctr.sh`.

```bash
cd 42_devctr
./run_devctr.sh
```

> **Tip:** To exit the docker image, run `exit`.
>

## Tools available

- vim
- tmux
- gdb
- valgrind
- norminette