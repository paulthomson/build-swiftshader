#!/bin/bash
set -x
set -e
set -u

shopt -s extglob
shopt -s nullglob

cd swiftshader

CMAKE_BUILD_TYPE="${Configuration}"
# swiftshader does not install anything, so use build directory.
INSTALL_DIR="${PROFILE}-${Platform}-${CMAKE_BUILD_TYPE}-build"
COMMIT_ID="${APPVEYOR_REPO_COMMIT}"

pushd "${INSTALL_DIR}/${Configuration}"
7z a "../../${INSTALL_DIR}.zip" !(llvm.lib)
popd

github-release \
  paulthomson/build-swiftshader \
  "v-${COMMIT_ID}" \
  "${COMMIT_ID}" \
  "$(echo -e "Automated build.\n$(git log --graph -n 3 --abbrev-commit --pretty='format:%h - %s <%an>')")" \
  "${INSTALL_DIR}.zip"

