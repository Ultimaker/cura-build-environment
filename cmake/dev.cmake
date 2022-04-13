# Copyright (c) 2022 Ultimaker B.V.
# Cura's build system is released under the terms of the AGPLv3 or higher.

add_custom_target(create-dev-env COMMENT "Create development virtual environment")
add_dependencies(create-dev-env install-python-requirements Arcus Savitar pynest2d Charon fdm_materials)