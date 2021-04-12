FROM ubuntu:18.04

RUN apt update

# Set this up front because it is strange
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Chicago
RUN apt install -y tzdata

# Communication pieces
RUN apt install -y git curl 

# Common build pieces
RUN apt install -y cmake g++ gfortran cmake-curses-gui ccache

# Python requirements - all Python 3
RUN apt install -y python3-pip python3-dev

# Extra build dependencies due to GPU dependency
RUN apt install -y xorg-dev libgl1-mesa-dev xvfb

# Build tools necessary for other builds - performance tests and coverage
RUN apt install -y valgrind lcov gcovr

# Apparently the Docker Ubuntu doesn't have lsb_release which Decent CI uses for the Linux distro information
RUN apt install -y lsb-release

# Also need to get Ruby, which will also get the Gem command
RUN apt install -y ruby

# Python dependencies - installed into system Python 3
RUN pip3 install boto beautifulsoup4 soupsieve bs4

# Then Ruby dependencies
RUN gem install activesupport octokit

# Set up CI root repository
RUN mkdir /ci_root

# Now run everything from inside there from now on
WORKDIR /ci_root

# Make a run directory so it is ready to go for later
RUN mkdir /ci_root/ci

# Clone the CI run script into /ci_root/ci_script
RUN git clone https://gist.github.com/c51580a92556ef344216c22ec390aa31.git ci_script

# Change to the run script directory
WORKDIR /ci_root/ci_script

# Kick it off with bash
ENTRYPOINT /bin/bash

# To build this docker image:
# sudo docker build . -t myoldmopar/decent_ci_ubuntu_1804

# To run this docker image:
# sudo docker run -e LANG=C.UTF-8 -it myoldmopar/decent_ci_ubuntu_1804

# Then just run the decent ci command line in the docker and let it go
# xvfb-run ruby run_ci.rb /ci_root/ci {AMAZON_ARGUMENTS} false {GITHUB_TOKEN} NREL/EnergyPlus
