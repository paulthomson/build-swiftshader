#!/bin/bash
set -x
set -e
set -u

shopt -s extglob
shopt -s nullglob

cd swiftshader

# swiftshader does not install anything, so use build directory.
INSTALL_DIR="${BUILD_PLATFORM}-${CMAKE_BUILD_TYPE}-build"
COMMIT_ID="${TRAVIS_COMMIT}"

cd "${INSTALL_DIR}"
zip -r ../"${INSTALL_DIR}.zip" *.so *.dylib
cd ..

github-release \
  paulthomson/build-swiftshader \
  "v-${COMMIT_ID}" \
  "${COMMIT_ID}" \
  "$(echo -e "Automated build.\n$(git log --graph -n 3 --abbrev-commit --pretty='format:%h - %s <%an>')")" \
  "${INSTALL_DIR}.zip"


