// Only rebuild the environment when we actually want to rebuild it.
timeout(time: 5, unit: 'DAYS')
{
    input 'This will rebuild the Cura build environment. This is a long process that will block all Cura build slaves from building until it is done. Continue?'
}

// This will trigger a build of cura-build-environment on each node with the
// label 'cura'. This is done because we need cura-build-environment working on
// all the slaves since it contains all the dependencies for the other projects.
def jobs = [:]
def nodes = node_names('cura')
for(int i = 0; i < nodes.size(); ++i) {
    def name = nodes[i];

    jobs[name] = {
        node(name) {
            stage('Prepare') {
                step([$class: 'WsCleanup'])

                // Clean up the previous installation
                try {
                    if(isUnix()) {
                        sh "rm -r /opt/ultimaker/cura-build-environment/${env.BRANCH_NAME}"
                    } else {
                        bat "rmdir /S /Q C:\\ultimaker\\cura-build-environment\\${env.BRANCH_NAME}"
                    }
                } catch(e) {
                    // Ignore
                }

                checkout scm
            }

            stage('Build') {
                if(isUnix()) {
                    dir('build') {
                        // Build and install the new environment
                        sh "cmake .. -DCMAKE_INSTALL_PREFIX=/opt/ultimaker/cura-build-environment/${env.BRANCH_NAME} -DCMAKE_PREFIX_PATH=/opt/ultimaker/cura-build-environment/${env.BRANCH_NAME} -DCMAKE_BUILD_TYPE=Release -DINCLUDE_DEVEL=ON"
                        sh "make"
                    }
                } else {
                    bat """
                        subst Q: .
                        Q:
                        mkdir build && cd build
                        call ../env_win64.bat
                        cmake .. -DCMAKE_INSTALL_PREFIX=C:/ultimaker/cura-build-environment/${env.BRANCH_NAME} -DCMAKE_PREFIX_PATH=/opt/ultimaker/cura-build-environment/${env.BRANCH_NAME} -DCMAKE_BUILD_TYPE=Release -G "NMake Makefiles" -DINCLUDE_DEVEL=ON
                        nmake
                        C:
                        subst /D Q:
                    """
                }
            }
        }
    }
}

parallel jobs
