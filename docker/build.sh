#!/bin/bash
#
# This script is used to build cura-build-environment in docker container with
# CentOS 7 x86_64 as the base image.
#
# Usage:
#   <src_path>
# Arguments:
#   - src_path : the cura-build-environment source directory.
#

set -e

# Check and set arguments
SRC_PATH="$1"
if [[ -z "${SRC_PATH}" ]]; then
    echo "Missing <src_path>."
    exit 1
fi

# Set up environment variables
source /opt/rh/devtoolset-7/enable
export PATH="${CURA_BUILD_ENV_PATH}/bin:${PATH}"
export PKG_CONFIG_PATH="${CURA_BUILD_ENV_PATH}/lib/pkgconfig:${PKG_CONFIG_PATH}"

# Build
cmake3 "${SRC_PATH}" \
    -DCMAKE_BUILD_TYPE="${CURA_BUILD_ENV_BUILD_TYPE}" \
    -DCMAKE_INSTALL_PREFIX="${CURA_BUILD_ENV_PATH}" \
    -DCMAKE_PREFIX_PATH="${CURA_BUILD_ENV_PATH}" \
    -DCURA_ARCUS_BRANCH_OR_TAG="${CURA_ARCUS_BRANCH_OR_TAG}" \
    -DCURA_SAVITAR_BRANCH_OR_TAG="${CURA_SAVITAR_BRANCH_OR_TAG}"
make
