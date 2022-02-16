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
export PATH="${CURA_BUILD_ENV_PATH}/bin:/usr/local/bin:${PATH}"
export PKG_CONFIG_PATH="${CURA_BUILD_ENV_PATH}/lib/pkgconfig:${PKG_CONFIG_PATH}"
export LD_LIBRARY_PATH="${CURA_BUILD_ENV_PATH}/lib:${LD_LIBRARY_PATH}"

# Execute command
exec "$@"
