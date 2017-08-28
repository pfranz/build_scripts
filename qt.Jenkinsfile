// build deps
// yum install git perl python binson flex gperf ruby icu yum-builddep perl-version libxcb libxcb-devel xcb-util xcb-util-devel
// yum install freetype-devel
// touch .git
// https://github.com/autodesk-forks/qtx11extras/archive/v5.6.1-1.tar.gz
node('centos6') {
    stage('Prep') {
        checkout scm
    }
    stage('qtbase') {
        // https://bugreports.qt.io/browse/QTBUG-48626
        sh 'rm -rf extract/qtbase-5.6.1-1 || true'
        sh 'mkdir -p extract/qtbase-5.6.1-1'
        sh 'touch extract/qtbase-5.6.1-1/.git'
        sh 'rm -rf build/qtbase-5.6.1-1 || true'

        withEnv(['PATH+PATH=/opt/gcc/4.8.3/bin']) {
            sh './build.sh https://github.com/autodesk-forks/qtbase/archive/v5.6.1-1.tar.gz /opt/qtbase/5.6.1-1 "-confirm-license -opensource -static -nomake examples -nomake tests -no-libjpeg -no-libpng -no-xcb -no-xkbcommon -no-harfbuzz" false'
        }
    }
}
stage('Publish?') {
    input "Publish tarball to GitHub?"
}
node('centos6') {
    stage('Create tarball') {
        dir('/opt/qtbase/5.6.1-1') {
            sh 'tar czf /vagrant/qtbase-5.6.1-1-gcc4.8.3-linux.tar.gz *'
        }
    }
    stage('Publish') {
        withCredentials([string(credentialsId: 'GITHUB_TOKEN', variable: 'GITHUB_TOKEN')]) {
            sh '/root/bin/publish_to_github qtbase-5.6.1-1-gcc4.8.3-linux-`date +%Y%m%d` " #latest #linux #VRP2017" /vagrant/qtbase-5.6.1-1-gcc4.8.3-linux.tar.gz'
        }
    }
}
