node('centos6') {
    stage('Prep') {
        checkout scm
    }
    // test compiler
    // /opt/python/2.7.13/bin/python -c 'import sys; print(sys.version)' | grep -q 'GCC 4.8.3'
    // $? should equal 0
    stage('python') {
        withEnv(['CC=/opt/gcc/4.8.3/bin/gcc', 'CXX=/opt/gcc/4.8.3/bin/g++']) {
            sh './build https://www.python.org/ftp/python/2.7.13/Python-2.7.13.tgz /opt/python/2.7.13'
        }
    }
}
