ExternalProject_Add(llvm-host-libcxx
    DEPENDS
        llvm-host-compiler-rt-builtin
    DOWNLOAD_COMMAND ""
    UPDATE_COMMAND ""
    SOURCE_DIR ${LLVM_SRC}
    LIST_SEPARATOR ,
    CONFIGURE_COMMAND ${EXEC} CONF=1 cmake -H<SOURCE_DIR>/runtimes -B<BINARY_DIR>
        -G Ninja
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
        -DCMAKE_C_COMPILER=clang
        -DCMAKE_CXX_COMPILER=clang++
        -DCMAKE_SYSTEM_NAME=${CMAKE_SYSTEM_NAME}
        -DCMAKE_AR=${CMAKE_INSTALL_PREFIX}/bin/llvm-ar
        -DCMAKE_RANLIB=${CMAKE_INSTALL_PREFIX}/bin/llvm-ranlib
        -DCMAKE_C_COMPILER_WORKS=1
        -DCMAKE_CXX_COMPILER_WORKS=1
        -DCMAKE_C_COMPILER_TARGET=${HOST_ARCH}
        -DCMAKE_CXX_COMPILER_TARGET=${HOST_ARCH}
        -DCMAKE_ASM_COMPILER_TARGET=${HOST_ARCH}
        -DLLVM_DEFAULT_TARGET_TRIPLE=${HOST_ARCH}
        -DLLVM_ENABLE_RUNTIMES='libunwind,libcxxabi,libcxx'
        -DLLVM_PATH=${LLVM_SRC}/llvm
        -DLIBUNWIND_USE_COMPILER_RT=TRUE
        -DLIBUNWIND_ENABLE_SHARED=OFF
        -DLIBUNWIND_ENABLE_STATIC=ON
        -DLIBCXX_USE_COMPILER_RT=ON
        -DLIBCXX_ENABLE_SHARED=OFF
        -DLIBCXX_ENABLE_STATIC=ON
        -DLIBCXX_ENABLE_STATIC_ABI_LIBRARY=TRUE
        -DLIBCXX_CXX_ABI=libcxxabi
        -DLIBCXX_LIBDIR_SUFFIX=""
        -DLIBCXX_INCLUDE_TESTS=FALSE
        -DLIBCXXABI_INCLUDE_TESTS=FALSE
        -DLIBUNWIND_INCLUDE_TESTS=FALSE
        -DLIBCXX_ENABLE_ABI_LINKER_SCRIPT=FALSE
        -DLIBCXXABI_USE_COMPILER_RT=ON
        -DLIBCXXABI_USE_LLVM_UNWINDER=ON
        -DLIBCXXABI_ENABLE_SHARED=OFF
        -DLIBCXXABI_LIBDIR_SUFFIX=""
        -DLLVM_ENABLE_PER_TARGET_RUNTIME_DIR=ON
        "-DCMAKE_C_FLAGS='-march=native -pipe -ffp-contract=fast -ftls-model=local-exec -fdata-sections -ffunction-sections ${llvm_lto}'"
        "-DCMAKE_CXX_FLAGS='-march=native -pipe -ffp-contract=fast -ftls-model=local-exec -fdata-sections -ffunction-sections ${llvm_lto}'"
        "-DCMAKE_EXE_LINKER_FLAGS='-fuse-ld=lld -Xlinker -s -Xlinker --icf=all -Xlinker --gc-sections'"
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(llvm-host-libcxx install)
tc_delete_dir(llvm-host-libcxx)
