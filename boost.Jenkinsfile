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
stage('Publish?') {
    input "Publish tarball to GitHub?"
}
node('centos6') {
    stage('Create tarball') {
        dir('/opt/boost/1.61.0') {
            sh 'tar czf /vagrant/boost-1.61.0-gcc4.8.3-linux.tar.gz *'
        }
    }
    stage('Publish') {
        withCredentials([string(credentialsId: 'GITHUB_TOKEN', variable: 'GITHUB_TOKEN')]) {
            sh '/root/bin/publish_to_github boost/1.61.0-gcc4.8.3-linux-`date +%Y%m%d` " #latest #linux #VRP2017" /vagrant/boost-1.61.0-gcc4.8.3-linux.tar.gz'
        }
    }
}
