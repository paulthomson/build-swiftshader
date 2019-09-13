#!/bin/bash
set -x
set -e
set -u

GITHUB_RELEASE_TOOL_USER="c4milo"
GITHUB_RELEASE_TOOL_VERSION="v1.1.0"
GITHUB_RELEASE_TOOL_ARCH="windows_amd64"

mkdir temp
cd temp

curl -fsSL -o github-release.tar.gz "https://github.com/${GITHUB_RELEASE_TOOL_USER}/github-release/releases/download/${GITHUB_RELEASE_TOOL_VERSION}/github-release_${GITHUB_RELEASE_TOOL_VERSION}_${GITHUB_RELEASE_TOOL_ARCH}.tar.gz"

7z x github-release.tar.gz
7z x github-release.tar

curl -fsSL -o ninja-win.zip https://github.com/ninja-build/ninja/releases/download/v1.8.2/ninja-win.zip
7z x ninja-win.zip

cd ..


git clone https://swiftshader.googlesource.com/SwiftShader
cd "${CLONE_DIR}"
git checkout $(cat ../COMMIT_ID)
git submodule init
git submodule update
cd third_party
rm -rf marl
git clone https://github.com/ben-clayton/marl.git
cd marl
git checkout fix-25

