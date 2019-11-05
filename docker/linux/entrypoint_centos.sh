#!/bin/bash
#
# The entrypoint script for the cura-build-environment CentOS docker image.
#

set -ex

if [[ -z "${CURA_BUILD_ENV_PATH}" ]]; then
    echo "CURA_BUILD_ENV_PATH is not defined. Could not find where cura-build-environment is installed."
    exit 1
fi

# Sets up the environment variables.
source /opt/rh/devtoolset-7/enable
export PATH="${CURA_BUILD_ENV_PATH}/bin:${PATH}"
export PKG_CONFIG_PATH="${CURA_BUILD_ENV_PATH}/lib/pkgconfig:${PKG_CONFIG_PATH}"

# Execute command
exec "$@"
