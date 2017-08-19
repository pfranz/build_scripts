node('centos6') {
    // TODO: test it was built with correct dependencies
    // readelf -p .comment /opt/openexr/2.2.0/bin/exrenvmap
    stage('Prep') {
    //    checkout scm
        sh "curl -s -L -O http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.2.0.tar.gz"
        sh "curl -s -L -O http://download.savannah.nongnu.org/releases/openexr/openexr-2.2.0.tar.gz"

        sh "rm -rf ilmbase-2.2.0 || true"
        sh "rm -rf openexr-2.2.0 || true"

        sh "tar zxf ilmbase-2.2.0.tar.gz"
        sh "tar zxf openexr-2.2.0.tar.gz"
    }
    // yum install zlib-static
    // I tried to build zlib, but couldn't get openexr to look in a nonstandard location for it
    stage('ilmbase') {
        withEnv(['CC=/opt/gcc/4.8.3/bin/gcc', 'CXX=/opt/gcc/4.8.3/bin/g++']) {
        //L:{
            dir('ilmbase-2.2.0') {
                sh './configure --prefix=/opt/ilmbase/2.2.0 --disable-shared'
                sh 'make'
                // sh 'make check'
                sh 'mkdir -p /opt/ilmbase/2.2.0 || true'
                sh 'rm -rf /opt/ilmbase/2.2.0/* || true'
                sh 'make install'
            }
        }
    }
    stage('openexr') {
        withEnv([
            'LD_LIBRARY_PATH=/opt/ilmbase/2.2.0/lib',
            'CC=/opt/gcc/4.8.3/bin/gcc',
            'CXX=/opt/gcc/4.8.3/bin/g++'
            ]) {
            dir('openexr-2.2.0') {
                sh './configure --prefix=/opt/openexr/2.2.0 --with-ilmbase-prefix=/opt/ilmbase/2.2.0 --disable-shared'
                sh 'make'
                // sh 'make check'
                sh 'mkdir -p /opt/openexr/2.2.0 || true'
                sh 'rm -rf /opt/openexr/2.2.0/* || true'
                sh 'make install'
            }
        }
    }
}
