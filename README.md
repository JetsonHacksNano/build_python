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

## Notes
### June 2023, Initial Release
- Tested on Jetson Nano 4GB, Python 3.11

