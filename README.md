# build_python
Create .deb files for later versions of Python (3.9,3.10,3.11) for Jetson Linux - Ubuntu 18.04 - bionic

The JetsonHacksNano repository holds Python 3.9, Python 3.10 and Python 3.11 source code forked from the Deadsnakes account: https://github.com/deadsnakes Deadsnakes creates a repository to hold both new and old versions of Python for Ubuntu.

When Ubuntu 18.04 (Bionic) reached EOL, the repository removed Python builds for that versions. Because the Jetsons using JetPack 4.X still use Ubuntu 18.04, we keep the more recent versions of Python (3.9, 3.10 and 3.11) source code in the JetsonHacksNano account which include the Deadsnakes debian packaging scripts.

In order to build the .deb files for a Python release:
```
$ bash ./build_python3.sh
```

The resulting .deb files will be in ~/Python-Builds/Python<version>-Dist where <version> is the Python version selected, such as 3.11. Use the version flag to select which version to build. For example:
```
$ bash ./build_python3.sh --version 3.10
```
The default build is Python3.11, the last supported version from Deadsnakes.

You can add the .deb files individually. There is a convenience script to build an apt repository on a local file:
```
$ bash ./make_apt_repository.sh
```
Like the build_python script, there is a <version> flag.This script will copy the .deb files from the version specified to /opt/apt/python<version>, e.g. /opt/apt/python3.11. Also, the script places a .list file in /etc/apt/sources.list.d
After the script is complete, you can use apt as normal. For example:
```
$ sudo apt install python3.11-full
```
Will install the full Python 3.11 environment, with the exception of things full dev and debug files. For example, it does not install python3.11-dev

## Notes
### June 2023, Initial Release
- Tested on Jetson Nano 4GB, Python 3.11
- After building, make a backup of the .deb files at least. You will need to modify the apt_repository file to install the .deb files if you want to do a standalone install on another machine.

