# 42_devctr

<a href="LICENSE" ><img src="https://img.shields.io/github/license/quantumxt/42_devctr?style=for-the-badge"/></a>

<img alt="GitHub Workflow Status" src="https://img.shields.io/github/actions/workflow/status/quantumxt/42_devctr/docker-image.yml?style=for-the-badge">

A C development docker environment. (`norminette` &amp; 42Header for `vim` included!)

## Preinstalled Utilities

### Essentials
- git
- vim
- tmux
- curl
- cmake

### Debugging
- gdb
- valgrind 3.21.0

### Formatting
- norminette
- 42 Header for `vim`
- [helios](https://github.com/quantumxt/helios) custom tools

### Testing
- gtest
- francinette

### Python3
- python3-pip
- python3-venv

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

## Running only paco

Enter the directory to be checked:
```bash
cd <your_directory_to check>
```

After that, run `checkme`:
```bash
checkme
```


## Run the development environment

Once the build has been completed, run the container via `run_devctr.sh`.

```bash
cd 42_devctr
./run_devctr.sh
```

> **Tip:** To exit the docker image, run `exit`.

## Sample

The `workspace` directory would be attached to the docker container when running, which contains sample file/structure of how you could import you project into docker. Feel free to add or remove the files inside.

## Changelog

- [Changelog](CHANGELOG.md)
