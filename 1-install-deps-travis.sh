#!/bin/bash
set -x
set -e
set -u

sudo mkdir -p /data/bin
sudo chmod uga+rwx /data/bin

GITHUB_RELEASE_TOOL_USER="c4milo"
GITHUB_RELEASE_TOOL_VERSION="v1.1.0"


if [ "$(uname)" == "Darwin" ];
then
  brew install ninja md5sha1sum
  GITHUB_RELEASE_TOOL_ARCH="darwin_amd64"
fi

if [ "$(uname)" == "Linux" ];
then
  sudo apt-get update
  sudo apt-get -y install cmake ninja-build
  GITHUB_RELEASE_TOOL_ARCH="linux_amd64"
fi

pushd /data/bin
wget "https://github.com/${GITHUB_RELEASE_TOOL_USER}/github-release/releases/download/${GITHUB_RELEASE_TOOL_VERSION}/github-release_${GITHUB_RELEASE_TOOL_VERSION}_${GITHUB_RELEASE_TOOL_ARCH}.tar.gz"
tar xf "github-release_${GITHUB_RELEASE_TOOL_VERSION}_${GITHUB_RELEASE_TOOL_ARCH}.tar.gz"
popd

git clone https://github.com/paulthomson/swiftshader.git
cd "${CLONE_DIR}"
git checkout $(cat ../COMMIT_ID)
git submodule init
git submodule update

