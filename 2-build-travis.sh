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
# SwiftShader doesn't install anything, but third party projects do, so skip the install step.
# cmake "-DCMAKE_INSTALL_PREFIX=../${INSTALL_DIR}" "-DBUILD_TYPE=${CMAKE_BUILD_TYPE}" -P cmake_install.cmake
cd ..

# SwiftShader doesn't install anything, so copy files manually.

mkdir -p "${INSTALL_DIR}/lib"

OUTPUT_SYSTEM="$(uname)"

# Copy the contents of the output directory into lib.
cp -r "${BUILD_DIR}/${OUTPUT_SYSTEM}/." "${INSTALL_DIR}/lib/"

find "${INSTALL_DIR}"
