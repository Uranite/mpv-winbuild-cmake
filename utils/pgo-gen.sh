#!/bin/sh
cmake -DTARGET_ARCH=x86_64-w64-mingw32 \
-DGCC_ARCH=native \
-DSINGLE_SOURCE_LOCATION=../src_packages \
-DCOMPILER_TOOLCHAIN=clang \
-DLLVM_ENABLE_LTO=OFF \
-DENABLE_CCACHE=OFF \
-DCLANG_PACKAGES_LTO=ON \
-DCLANG_PACKAGES_PGO=GEN \
-DCLANG_FLAGS="-mprefer-vector-width=256" \
-G Ninja \
-B /build
./utils/download.sh
