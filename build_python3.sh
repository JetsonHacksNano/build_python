#!/bin/bash
# Build Python3 for Ubuntu 18.04 - JetPack 4.X
# Copyright JetsonHacks 2023
# Build Python 3.9, 3.10, or 3.11 for JetPack 4.x (Jetson Linux - Ubuntu 18.04 - bionic )

# Default version
version="3.11"

help_message="Usage: $0 [-v|--version version_number] [-h|--help]
Options:
  -v, --version  Provide a version number (3.9, 3.10, or 3.11).
  -h, --help     Show this help message."

# Parse command-line options
OPTIONS=$(getopt -o v:h --longoptions version:,help -- "$@")
eval set -- "$OPTIONS"

while true; do
    case "$1" in
        -v|--version)
            version="$2"
            shift 2
            ;;
        -h|--help)
            echo "$help_message"
            exit 0
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Incorrect options provided"
            echo "$help_message"
            exit 1
            ;;
    esac
done

# Validate the provided version number
if [[ "$version" != "3.9" ]] && [[ "$version" != "3.10" ]] && [[ "$version" != "3.11" ]]; then
    echo "The version number $version is not supported. Please provide a correct version (3.9, 3.10, or 3.11)."
    exit 1
fi
echo "Building Python version: $version"

sudo apt update
sudo apt-get build-dep python3
sudo apt install -y pkg-config
# Install main dependencies
sudo apt install -y build-essential gdb lcov pkg-config \
      libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
      libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
      lzma lzma-dev tk-dev uuid-dev zlib1g-dev
# Install Python 3 extra dependencies
sudo apt install -y quilt sharutils libdb-dev blt-dev libbluetooth-dev \
      time xvfb python3-sphinx texinfo
sudo apt install -y devscripts git git-buildpackage
mkdir -p ~/Python-Builds
cd ~/Python-Builds
mkdir Python$version-Dist
cd Python$version-Dist
git clone https://github.com/JetsonHacksNano/python$version.git
cd python$version

git checkout ubuntu/bionic
gbp buildpackage --git-ignore-branch