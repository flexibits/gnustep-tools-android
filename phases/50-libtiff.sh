#!/bin/bash

set -e # make any subsequent failing command exit the script

. `dirname $0`/../scripts/common.sh

PROJECT=libtiff
URL=http://download.osgeo.org/libtiff/tiff-4.7.1.tar.gz

# load environment and prepare project
if ! prepare_project $PROJECT $URL; then
  exit 0
fi

. "$ROOT_DIR"/scripts/toolchain.sh

echo -e "\n### Running configure"
./configure \
  --host=${ANDROID_TARGET} \
  --prefix="${INSTALL_PREFIX}" \
  --disable-jbig \
  --disable-lzma \
  --disable-webp \
  --disable-zstd

echo -e "\n### Building"
make -j${MAKE_JOBS}

echo -e "\n### Installing"
make install
