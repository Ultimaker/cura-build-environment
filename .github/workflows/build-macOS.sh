#!/bin/sh

# Set the necessary variables
now=$(date '+%Y%m%d_%H%M%S')
export CURABUILDENVIRONMENT_NAME="master-${now}"
export CURABUILDENVIRONMENT_BRANCH_OR_TAG="master"
export ARCUS_BRANCH_OR_TAG="master"
export SAVITAR_BRANCH_OR_TAG="master"

# Better to hardcode these values, since we always want to support
# macOS versions higher than 10.14 (Mojave)
export CURA_TARGET_OSX_VERSION="10.14"
export CURA_OSX_SDK_VERSION="10.15"

#export GIT_SSL_NO_VERIFY=false  # no need for .gitconfig file!

# Prepare source and environment directories
env_root_dir="/Users/ultimaker/build/env/${CURABUILDENVIRONMENT_NAME}"
environment_dir="${env_root_dir}/install"

git clone -b "${CURABUILDENVIRONMENT_BRANCH_OR_TAG}" https://github.com/ultimaker/cura-build-environment "${env_root_dir}"
cd "${env_root_dir}"

# Initialize environment variables
source env_osx.sh

mkdir -p "${env_root_dir}"/build
cd "${env_root_dir}"/build

# GCC
gcc_root_dir=/usr/local/Cellar/gcc/10.2.0_4
export PATH="${gcc_root_dir}/bin:/usr/local/bin:${PATH}"
export PKG_CONFIG_PATH="${gcc_root_dir}/lib/pkgconfig:${PKG_CONFIG_PATH}"
export CPATH="${gcc_root_dir}/include:${CPATH}"
export LIBRARY_PATH="${gcc_root_dir}/lib:${LIBRARY_PATH}"

# Make sure that the build process will use the built python and qmake binaries.
export PATH="${environment_dir}/bin:${PATH}"
export PKG_CONFIG_PATH="${environment_dir}/lib/pkgconfig:${PKG_CONFIG_PATH}"
export CPATH="${environment_dir}/include:${CPATH}"
export LIBRARY_PATH="${environment_dir}/lib:${LIBRARY_PATH}"
export CLIPPER_PATH="${environment_dir}"

CMAKE_EXTRA_ARGS=""
if [ -n "${CMAKE_OSX_DEPLOYMENT_TARGET}" ]; then
    CMAKE_EXTRA_ARGS="${CMAKE_EXTRA_ARGS} -DCMAKE_OSX_DEPLOYMENT_TARGET=${CMAKE_OSX_DEPLOYMENT_TARGET}"
fi
if [ -n "${CMAKE_OSX_SYSROOT}" ]; then
    CMAKE_EXTRA_ARGS="${CMAKE_EXTRA_ARGS} -DCMAKE_OSX_SYSROOT=${CMAKE_OSX_SYSROOT}"
fi

cmake -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH="${environment_dir}" \
    -DCMAKE_INSTALL_PREFIX="${environment_dir}" \
    -DCURA_ARCUS_BRANCH_OR_TAG="${ARCUS_BRANCH_OR_TAG}" \
    -DCURA_SAVITAR_BRANCH_OR_TAG="${SAVITAR_BRANCH_OR_TAG}" \
    -DCURA_OSX_SDK_VERSION="${CURA_OSX_SDK_VERSION}" \
    -DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS}" \
    -DCMAKE_VERBOSE_MAKEFILE=ON \
    ${CMAKE_EXTRA_ARGS} \
    "${env_root_dir}"
make
