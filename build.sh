#!/bin/bash

basedir=`pwd`
installdir='/opt'
archivedir="${basedir}/archives"
extractdir="${basedir}/extract"
builddir="${basedir}/build"

error() {
    local parent_lineno="$1"
    local message="$2"
    local code="${3:-1}"
    if [[ -n "$message" ]] ; then
        ehco "Error on or near line ${parent_lineno}: ${message}; exiting with status ${code}"
    else
        echo "Error on or near line ${parent_lineno}: exiting with status ${code}"
    fi
    exit "${code}"
}
trap 'error ${LINENO}' ERR

install() {
    local archiveurl=$1
    local appinstalldir=$2
    local extraconfigureargs=$3

    local do_clean=${4:-true}
    local use_separatebuilddir=${5:-true}

    local downloadfunc=${6:-download}
    local extractfunc=${7:-extract}
    local buildfunc=${8:-build}

    local _tmp
    local apparchivefile
    local appextractdir
    local appbuilddir

    $downloadfunc "$archiveurl" "$do_clean" apparchivefile
    $extractfunc "$apparchivefile" "$do_clean" appextractdir
    _tmp=`basename $apparchivefile`
    appbuilddir=${builddir}/${_tmp%.*.*}
    $buildfunc "$appextractdir" "$appbuilddir" "$extraconfigureargs" "$use_separatebuilddir" "$do_clean"
}

download() {
    local archiveurl=$1
    local do_clean=${2-true}
    local _return=$3
    local archivename=`basename $archiveurl`
    echo "downloading: $archiveurl"

    mkdir -p $archivedir >& /dev/null || true
    cd $archivedir
    if $do_clean; then
        rm -f $archivename || true
    fi
    curl -s -O $1

    eval "$_return=\"$archivedir/$archivename\""
}

extract() {
    local apparchivefile=$1
    local do_clean=${2-true}
    local _return=$3
    local appbasename=`tar tf $apparchivefile | head -n1`
    echo "extracting: $apparchivefile"

    mkdir $extractdir >& /dev/null || true
    cd $extractdir
    if $do_clean; then
        rm -rf $appbasename || true
    fi
    tar xf $apparchivefile

    eval "$_return=\"$extractdir/$appbasename\""
}

build() {
    local appextractdir=$1
    local appbuilddir=$2
    local extraconfigureargs=$3
    local use_separatebuilddir=${4-true}
    local do_clean=${5-true}
    echo "building: "`basename $appbuilddir`

    if [ ! $use_separatebuilddir ]; then
        appbuilddir=$appextractdir
    fi

    if $do_clean && $use_separatebuilddir; then
        rm -rf $appbuilddir || true
    fi
    mkdir -p $appbuilddir >& /dev/null || true
    cd $appbuilddir
    ${appextractdir}/configure \
        --prefix=$appinstalldir \
        $extraconfigureargs
    make
    if $do_clean; then
        rm -rf ${appinstalldir}/* || true
    fi
    sudo make install
}

if [ $# -ne 0 ]; then
    install "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8"
fi
