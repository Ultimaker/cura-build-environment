#!/bin/bash
if [[ -z "${BUILD_ENV_PATH}" ]]; then
    echo "BUILD_ENV_PATH is not defined. Could not find where cura-build-environment is installed."
    exit 1
fi

# Execute command
exec "$@"
