#!/bin/sh
#
# If QMAKE_MACOSX_DEPLOYMENT_TARGET is defined in the environment,
# modify the configuration scripts in Qt (qtbase/mkspecs/) to use
# that as the target OSX version.
#

if [ -z "${QMAKE_MACOSX_DEPLOYMENT_TARGET}" ]; then
    echo "QMAKE_MACOSX_DEPLOYMENT_TARGET not defined, do nothing"
    exit
fi

grep -r 'QMAKE_MACOSX_DEPLOYMENT_TARGET = ' ./qtbase/mkspecs | cut -d':' -f1 | xargs sed -i '' 's/^\(QMAKE_MACOSX_DEPLOYMENT_TARGET =\)\(.*\)$/\1 '"${QMAKE_MACOSX_DEPLOYMENT_TARGET}"'/g'
