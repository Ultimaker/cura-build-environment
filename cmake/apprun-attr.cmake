# Copyright (c) 2022 Ultimaker B.V.
# Cura's build system is released under the terms of the AGPLv3 or higher.

file(COPY${CMAKE_SOURCE_DIR}/packaging/cura.sh
     DESTINATION ${ULTIMAKER_CURA_PATH}
     FILE_PERMISSIONS OWNER_READ OWNER_WRITE GROUP_WRITE GROUP_READ WORLD_READ OWNER_EXECUTE)