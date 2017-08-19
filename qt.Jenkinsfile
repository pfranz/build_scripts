// build deps
// yum install git perl python binson flex gperf ruby icu yum-builddep perl-version libxcb libxcb-devel xcb-util xcb-util-devel
// yum install freetype-devel
// touch .git
node('centos6') {
    stage('Prep') {
        sh "curl -s -L -O https://github.com/autodesk-forks/qtbase/archive/v5.6.1-1.tar.gz"
        sh "mv v5.6.1-1.tar.gz qtbase-5.6.1-1.tar.gz"
        sh "curl -s -L -O https://github.com/autodesk-forks/qtx11extras/archive/v5.6.1-1.tar.gz"
        sh "mv v5.6.1-1.tar.gz qtx11extras-5.6.1-1.tar.gz"

        sh "rm -rf qtbase-5.6.1-1 || true"
        sh "rm -rf qtx11extras-5.6.1-1 || true"

        sh "tar zxf qtbase-5.6.1-1.tar.gz"
        sh "tar zxf qtx11extras-5.6.1-1.tar.gz"
    }
    stage('qtbase') {
        //withEnv(['CC=/opt/gcc/4.8.3/bin/gcc', 'CXX=/opt/gcc/4.8.3/bin/g++']) {
            dir('qtbase-5.6.1-1') {
                // -qt-xcb gets around:
                // "The test for linking against libxcb and support libraries failed!"

                // https://bugreports.qt.io/browse/QTBUG-48626
                sh 'touch .git'

                sh './configure -confirm-license -opensource -static -nomake examples -nomake tests -no-libjpeg -no-libpng -no-xcb -no-xkbcommon -no-harfbuzz  --prefix=/opt/qtbase/5.6.1-1'
                sh 'make'
                // sh 'make check'
                sh 'mkdir -p /opt/qtbase/5.6.1-1 || true'
                sh 'rm -rf /opt/qtbase/5.6.1-1/* || true'
                sh 'make install'
            }
        //}
    }
}
