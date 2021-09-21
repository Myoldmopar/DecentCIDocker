# Decent CI Docker Image Specification
[![](https://img.shields.io/github/workflow/status/myoldmopar/DecentCIDocker/Publish%20Docker%20image?label=docker%20hub)](https://hub.docker.com/repository/docker/myoldmopar/decent_ci_ubuntu)

# Directions
 - You'll need Docker:
   - However you prefer, see: https://docs.docker.com/engine/install/ubuntu/
 - Clone the repo:
   - `git clone https://github.com/Myoldmopar/DecentCIDocker`
 - Create your own runner.sh script
   - Template is available in the root of the repo as `runner.sh.template`
   - Copy into the root of the repo as just `runner.sh`
   - Add your own commands and/or tokens to this new file, which is purposefully under Git-ignore control
 - Build the Docker image:
   - `sudo docker build . -t myoldmopar/decent_ci_ubuntu_1804`
   - If you get weird APT issues, try a full rebuild by adding `--no-cache` to the end of that command line
 - Run the Docker image:
   - `sudo docker run -e LANG=C.UTF-8 -it myoldmopar/decent_ci_ubuntu_1804`
 - Once inside the Docker image, run your script:
   - `./runner.sh`
