#!/bin/bash
cmake -DTARGET_ARCH=x86_64-w64-mingw32 \
-DGCC_ARCH=native \
-DSINGLE_SOURCE_LOCATION=../src_packages \
-DCOMPILER_TOOLCHAIN=clang \
-DLLVM_ENABLE_LTO=Thin \
-DENABLE_CCACHE=ON \
-DLLVM_ENABLE_CCACHE=ON \
-DCLANG_PACKAGES_LTO=ON \
-DCLANG_PACKAGES_PGO=OFF \
-DLLVM_ENABLE_PGO=USE \
-DLLVM_PROFDATA_FILE="/build/llvm.profdata" \
-DCLANG_FLAGS="-mprefer-vector-width=512" \
-G Ninja \
-B /build
./utils/download.sh
