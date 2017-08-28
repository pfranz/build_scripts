node('centos6') {
    stage('Prep') {
        checkout scm
    }
    // test compiler
    // /opt/python/2.7.13/bin/python -c 'import sys; print(sys.version)' | grep -q 'GCC 4.8.3'
    // $? should equal 0
    stage('python') {
        withEnv(['CC=/opt/gcc/4.8.3/bin/gcc', 'CXX=/opt/gcc/4.8.3/bin/g++']) {
            sh './build.sh https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz /opt/python/2.7.13'
        }
    }
}
stage('Publish?') {
    input "Publish tarball to GitHub?"
}
node('centos6') {
    stage('Create tarball') {
        dir('/opt/python/2.7.13') {
            sh 'tar czf /vagrant/python-2.7.13-gcc4.8.3-linux.tar.gz *'
        }
    }
    stage('Publish') {
        withCredentials([string(credentialsId: 'GITHUB_TOKEN', variable: 'GITHUB_TOKEN')]) {
            sh '/root/bin/publish_to_github python/2.7.13-gcc4.8.3-linux-`date +%Y%m%d` " #latest #linux #VRP2017" /vagrant/python/2.7.13-gcc4.8.3-linux.tar.gz'
        }
    }
}
