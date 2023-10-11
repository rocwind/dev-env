# dev-env

Docker-based development environment.

- Dockerfile: image that includes nodejs, go, rust. Based on latest Ubuntu LTS image
- docker-run: Python 3 script that launch Docker container and run commands inside
  - Maps the current directory into container, e.g. `docker-run ls` can list files of current host directory
  - Works for desktop platforms MacOS, Linux and Windows

## Get started

1. Install python3 and Docker
2. Clone this repo or download `docker-run`, `docker-run.cmd` to local directory, add the directory to "PATH" environment variable
   - `docker-run.cmd` is only for Windows
3. Go to workspace directory, run `docker-run <some command with the dev tools>`, e.g. `docker-run npm install http-server`
