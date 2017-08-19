node('centos6') {
    // The order these are built matters

    stage('Prep') {
        checkout scm
    }
    stage('Build libiconv') {
        sh './build.sh https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz /opt/libiconv/1.14 "--enable-static --disable-shared"'
    }
    stage('Build gmp') {
        // sudo yum install gcc-c++ -y
        sh './build.sh https://gmplib.org/download/gmp/gmp-5.1.3.tar.bz2 /opt/gmp/5.1.3 "--enable-cxx --enable-static --disable-shared"'
    }
    stage('Build mpfr') {
        sh './build.sh https://ftp.gnu.org/gnu/mpfr/mpfr-3.1.2.tar.bz2 /opt/mpfr/3.1.2 "--with-gmp=/opt/gmp/5.1.3 --enable-static --disable-shared"'
    }
    stage('Build mpc') {
        sh './build.sh https://ftp.gnu.org/gnu/mpc/mpc-1.0.2.tar.gz /opt/mpc/1.0.2 "--with-gmp=/opt/gmp/5.1.3 --with-mpfr=/opt/mpfr/3.1.2 --enable-static --disable-shared"'
    }
    stage('Build ppl') {
        sh './build.sh http://bugseng.com/products/ppl/download/ftp/releases/1.1/ppl-1.1.tar.bz2 /opt/ppl/1.1 "--with-gmp=/opt/gmp/5.1.3 --enable-static --disable-shared"'
    }
    stage('Build cloog') {
        // NOTE: gmp build dir, not install dir
        sh './build.sh https://www.bastoul.net/cloog/pages/download/cloog-0.18.0.tar.gz /opt/cloog/0.18.0 "--with-gmp-builddir=`pwd`/build/gmp-5.1.3 --with-gmp=build --enable-static --disable-shared"'
    }
    stage('Build gcc') {
        // sudo yum install glibc-devel.i686 -y
        // static linking gcc so we don't need to set LD_LIBRARY_PATH to run gcc
        // setting LD_LIBRARY_PATH because it fails to find mpc library on cent6
        withEnv(['LD_LIBRARY_PATH=/opt/cloog/0.18.0/lib:/opt/gmp/5.1.3/lib:/opt/mpc/1.0.2/lib:/opt/mpfr/3.1.2/lib:/opt/ppl/1.1/lib']) {
            sh './build.sh https://ftp.gnu.org/gnu/gcc/gcc-4.8.3/gcc-4.8.3.tar.bz2 /opt/gcc/4.8.3 "--disable-cloog-version-check --disable-ppl-version-check --enable-cloog-backend=isl --enable-gold --enable-languages=c,c++ --enable-lto --enable-libssp --disable-shared --with-cloog=/opt/cloog/0.18.0 --with-gmp=/opt/gmp/5.1.3 --with-mpc=/opt/mpc/1.0.2 --with-mpfr=/opt/mpfr/3.1.2 --with-ppl=/opt/ppl/1.1"'
        }
    }
}
