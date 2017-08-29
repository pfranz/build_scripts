node('centos6') {
    stage('Prep') {}
    stage('tbb') {
        sh 'curl -L -O https://github.com/01org/tbb/releases/download/4.4.5/tbb44_20160526oss_lin.tgz'
        sh 'rm -rf tbb44_20160526oss || true'
        sh 'tar zxf tbb44_20160526oss_lin.tgz'
        sh 'rm -rf /opt/tbb/4.4_5 || true'
        sh 'mkdir -p /opt/tbb/4.4_5'
        sh 'cp -r tbb44_20160526oss/* /opt/tbb/4.4_5/'
    }
}
