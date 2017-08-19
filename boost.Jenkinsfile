node('centos6') {

    // env.BRANCH_NAME == 'master'
    // redundant, but more clear
    def version = params.version
    def version_with_underscores = version.replaceAll("\\.", '_')
    stage('Preparation') {
        sh "curl -s -L -O https://downloads.sourceforge.net/project/boost/boost/${version}/boost_${version_with_underscores}.tar.gz".toString()
        sh "rm -rf boost_${version_with_underscores} || true".toString()
        sh "tar zxf boost_${version_with_underscores}.tar.gz".toString()
    }
    stage('Build') {
        // skipped quite a few few libs because of failures like missing python or bzip2
        dir("boost_${version_with_underscores}".toString()) {
            withEnv(['PATH+PATH=/opt/gcc/4.8.3/bin']) {
            //L:{
                sh "./bootstrap.sh --prefix=/opt/boost/${version}".toString()
                sh "mkdir -p /opt/boost/${version} || true".toString()
                sh "rm -rf /opt/boost/${version}/* || true".toString()
                sh "./b2 -q -s NO_BZIP2=1 install --without-math --without-python --without-mpi link=static"
            }
        }
    }
    stage('Results') {
    }
}
