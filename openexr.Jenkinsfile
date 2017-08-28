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
            sh './build.sh http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.2.0.tar.gz /opt/ilmbase/2.2.0 "--disable-shared"'
        }
    }
    stage('openexr') {
        withEnv([
            'LD_LIBRARY_PATH=/opt/ilmbase/2.2.0/lib',
            'CC=/opt/gcc/4.8.3/bin/gcc',
            'CXX=/opt/gcc/4.8.3/bin/g++'
            ]) {

            sh './build.sh http://download.savannah.nongnu.org/releases/openexr/openexr-2.2.0.tar.gz /opt/openexr/2.2.0 "--with-ilmbase-prefix=/opt/ilmbase/2.2.0 --disable-shared"'
        }
    }
}
stage('Publish?') {
    input "Publish tarball to GitHub?"
}
node('centos6') {
    stage('Create tarball') {
        dir('/opt/ilmbase/2.2.0') {
            sh 'tar czf /vagrant/ilmbase-2.2.0-gcc4.8.3-linux.tar.gz *'
        }
        dir('/opt/openexr/2.2.0') {
            sh 'tar czf /vagrant/openexr-2.2.0-gcc4.8.3-linux.tar.gz *'
        }
    }
    stage('Publish') {
        withCredentials([string(credentialsId: 'GITHUB_TOKEN', variable: 'GITHUB_TOKEN')]) {
            sh '/root/bin/publish_to_github openexr-2.2.0-gcc4.8.3-linux-`date +%Y%m%d` " #latest #linux #VRP2017" /vagrant/ilmbase-2.2.0-gcc4.8.3-linux.tar.gz /vagrant/openexr-2.2.0-gcc4.8.3-linux.tar.gz'
        }
    }
}
