#!/bin/bash
#
# This script builds the cura-build-environment with the CentOS 8 or Debian Buster base docker image.
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
export PATH="${CURA_BUILD_ENV_PATH}/bin:${PATH}"
export PKG_CONFIG_PATH="${CURA_BUILD_ENV_PATH}/lib/pkgconfig:${PKG_CONFIG_PATH}"
export LD_LIBRARY_PATH="${CURA_BUILD_ENV_PATH}/lib:${LD_LIBRARY_PATH}"

# Build
cmake "${SRC_PATH}" \
    -DCMAKE_BUILD_TYPE="${CURA_BUILD_ENV_BUILD_TYPE}" \
    -DCMAKE_INSTALL_PREFIX="${CURA_BUILD_ENV_PATH}" \
    -DCMAKE_PREFIX_PATH="${CURA_BUILD_ENV_PATH}" \
    -DCURA_ARCUS_BRANCH_OR_TAG="${CURA_ARCUS_BRANCH_OR_TAG}" \
    -DCURA_SAVITAR_BRANCH_OR_TAG="${CURA_SAVITAR_BRANCH_OR_TAG}"
make
