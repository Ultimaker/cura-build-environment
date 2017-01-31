// Only rebuild the environment when we actually want to rebuild it.
timeout(time: 5, unit: 'DAYS')
{
    input 'This will rebuild the Cura build environment. This is a long process that will block all Cura build slaves from building until it is done. Continue?'
}

// This will trigger a build of cura-build-environment on each node with the
// label 'cura'. This is done because we need cura-build-environment working on
// all the slaves since it contains all the dependencies for the other projects.
def jobs = [:]
def nodes = nodeNames('cura')
for(int i = 0; i < nodes.size(); ++i) {
    def name = nodes[i];

    jobs[name] = {
        node(name) {
            stage('Prepare') {
                step([$class: 'WsCleanup'])

                checkout scm
            }

            stage('Build') {
                dir('build') {
                    if(isUnix()) {
                        sh "cmake .. -DCMAKE_INSTALL_PREFIX=/opt/ultimaker/cura-build-environment -DCMAKE_BUILD_TYPE=Release"
                        sh "make"
                    } else {
                        bat "../env_win64.bat && cmake .. -DCMAKE_INSTALL_PREFIX=C:/cura-build-environment -DCMAKE_BUILD_TYPE=Release -G 'NMake Makefiles'"
                        bat "nmake"
                    }
                }
            }
        }
    }
}

parallel jobs

@NonCPS
def nodeNames(label) {
    return Jenkins.instance.nodes.findAll({ node -> node.labelString.contains(label) }).collect({ node -> node.name })
}
