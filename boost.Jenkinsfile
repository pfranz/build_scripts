node('centos6') {
    stage('Prep') {
        checkout scm
    }
    stage('boost') {
        withEnv(['PATH+PATH=/opt/gcc/4.8.3/bin']) {
            sh './build_boost.sh https://downloads.sourceforge.net/project/boost/boost/1.61.0/boost_1_61_0.tar.gz /opt/boost/1.61.0'
        }
    }
}
