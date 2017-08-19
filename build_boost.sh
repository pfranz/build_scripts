#!/bin/bash

source build.sh

# skipped quite a few few libs because of failures like missing python or bzip2
build_boost() {
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
    ${appextractdir}/bootstrap.sh \
        --prefix=$appinstalldir \
        $extraconfigureargs
    if $do_clean; then
        rm -rf ${appinstalldir}/* || true
    fi
    ${appextractdir}/b2 -q -s NO_BZIP2=1 install --without-math --without-python --without-mpi link=static
}

if [ $# -ne 0 ]; then
    # does boost support a separate build dir?
    install "$1" "$2" "$3" true false "" "" build_boost
fi
