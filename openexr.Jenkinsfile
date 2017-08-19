node('centos6') {
    // TODO: test it was built with correct dependencies
    // readelf -p .comment /opt/openexr/2.2.0/bin/exrenvmap
    stage('Prep') {
        checkout scm
    }
    // yum install zlib-static
    // I tried to build zlib, but couldn't get openexr to look in a nonstandard location for it
    stage('ilmbase') {
        withEnv(['CC=/opt/gcc/4.8.3/bin/gcc', 'CXX=/opt/gcc/4.8.3/bin/g++']) {
            sh './build http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.2.0.tar.gz /opt/ilmbase/2.2.0 "--disable-shared"'
        }
    }
    stage('openexr') {
        withEnv([
            'LD_LIBRARY_PATH=/opt/ilmbase/2.2.0/lib',
            'CC=/opt/gcc/4.8.3/bin/gcc',
            'CXX=/opt/gcc/4.8.3/bin/g++'
            ]) {

            sh './build http://download.savannah.nongnu.org/releases/openexr/openexr-2.2.0.tar.gz /opt/openexr/2.2.0 "--with-ilmbase-prefix=/opt/ilmbase/2.2.0 --disable-shared"'
        }
    }
}
