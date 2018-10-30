#!/bin/bash
set -x
set -e
set -u

cd "${CLONE_DIR}"

BUILD_DIR="${INSTALL_DIR}-build"

mkdir -p "${BUILD_DIR}"
cd "${BUILD_DIR}"
cmake -G "${CMAKE_GENERATOR}" .. "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}" -DCMAKE_OSX_ARCHITECTURES=x86_64 ${CMAKE_OPTIONS}
cmake --build . --config "${CMAKE_BUILD_TYPE}"
cmake "-DCMAKE_INSTALL_PREFIX=../${INSTALL_DIR}" "-DBUILD_TYPE=${CMAKE_BUILD_TYPE}" -P cmake_install.cmake
cd ..

find "${BUILD_DIR}"

# SwiftShader doesn't install anything, so copy files manually.

mkdir -p "${INSTALL_DIR}/lib"

cp "${BUILD_DIR}/${CMAKE_BUILD_TYPE}/libEGL"* "${INSTALL_DIR}/lib/"
cp "${BUILD_DIR}/${CMAKE_BUILD_TYPE}/libGLES"* "${INSTALL_DIR}/lib/"
