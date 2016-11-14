node('cura && linux') {
    def workspace = pwd()

    stage('Prepare') {
        checkout scm
    }

    stage('Build') {
        def build_dir = pwd(tmp: true)
        dir(build_dir) {
            sh "cmake ${workspace} -DCMAKE_INSTALL_PREFIX=/opt/ultimaker/cura-build-environment"
            sh "make"
        }
    }
}
