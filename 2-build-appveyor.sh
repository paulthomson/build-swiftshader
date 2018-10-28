#!/bin/bash
set -x
set -e
set -u

cd "${CLONE_DIR}"

BUILD_DIR="${INSTALL_DIR}-build"

mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"
cmake -G "${CMAKE_GENERATOR}" .. "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}" ${CMAKE_OPTIONS}
cmake --build . --config "${CMAKE_BUILD_TYPE}"
cmake "-DCMAKE_INSTALL_PREFIX=../${INSTALL_DIR}" "-DBUILD_TYPE=${CMAKE_BUILD_TYPE}" -P cmake_install.cmake
cd ..

# SwiftShader doesn't install anything, so copy files manually.

mkdir -p "${INSTALL_DIR}/lib"

cp "${BUILD_DIR}/libEGL"* "${INSTALL_DIR}/lib/"
cp "${BUILD_DIR}/libGLES"* "${INSTALL_DIR}/lib/"

find "${INSTALL_DIR}"
