#!/bin/bash
# Build a local apt repository for Python .debs
# Add to the apt sources
# Copyright (c) JetsonHacks 2023

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

# Check to see if this version has been built
dir_path="$HOME/Python-Builds/Python$version-Dist"

if [ -d "$dir_path" ]
then
    deb_files=$(find "$dir_path" -name "*.deb" | wc -l)

    if [ "$deb_files" != "0" ]
    then
        echo "Creating local apt repository from $dir_path .deb files."
    else
        echo "Python version $version has not been built yet."
        exit 1
    fi
else
    echo "Python version $version has not been created yet."
    exit 1
fi
# Copy the .deb files over to /opt/debs/python<version>
# For example, /opt/debs/python3.11
destination="/opt/debs/python$version"
sudo mkdir -p $destination
cd $dir_path
sudo cp *.deb "$destination"
# Create the package file
cd /opt/debs/python$version
sudo sh -c 'dpkg-scanpackages ./ /dev/null | gzip -9c > Packages.gz'
# Create a list file for apt
echo 'deb [trusted=yes] file://'$PWD ' ./' | sudo tee /etc/apt/sources.list.d/python$version-local.list
sudo apt update
