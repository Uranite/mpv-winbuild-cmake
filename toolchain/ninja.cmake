ExternalProject_Add(ninja
    DEPENDS
        mimalloc-host
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_REPOSITORY https://github.com/ninja-build/ninja.git
    GIT_CLONE_FLAGS "--filter=tree:0"
    UPDATE_COMMAND ""
    GIT_REMOTE_NAME origin
    GIT_TAG master
    CONFIGURE_COMMAND ${EXEC} CONF=1 PATH=$O_PATH cmake -H<SOURCE_DIR> -B<BINARY_DIR>
        -GNinja
        -DCMAKE_BUILD_TYPE=Release
        -DBUILD_SHARED_LIBS=OFF
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
        -DCMAKE_C_COMPILER=clang
        -DCMAKE_CXX_COMPILER=clang++
        -DCMAKE_INTERPROCEDURAL_OPTIMIZATION_RELEASE=OFF
        -DBUILD_TESTING=OFF
        "-DCMAKE_C_FLAGS='-march=native -pipe -O3 -fno-semantic-interposition -fno-math-errno -fno-signed-zeros -fno-trapping-math -falign-functions=32 -ffp-contract=fast -ftls-model=local-exec ${tlsdesc} -fdata-sections -ffunction-sections -DXXH_X86DISPATCH_ALLOW_AVX ${llvm_lto} ${llvm_mllvm}'"
        "-DCMAKE_CXX_FLAGS='-march=native -pipe -O3 -fno-semantic-interposition -fno-math-errno -fno-signed-zeros -fno-trapping-math -falign-functions=32 -ffp-contract=fast -ftls-model=local-exec ${tlsdesc} -fdata-sections -ffunction-sections -DXXH_X86DISPATCH_ALLOW_AVX ${llvm_lto} ${llvm_mllvm}'"
        "-DCMAKE_EXE_LINKER_FLAGS='-static-pie ${CMAKE_INSTALL_PREFIX}/lib/mimalloc.o -fuse-ld=lld -Wl,--build-id=fast,--lto-O3,--lto-CGO3,-s,--icf=all,--gc-sections,-zpack-relative-relocs ${llvm_linker_flags} ${llvm_mllvm_ld}'"
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(ninja)
cleanup(ninja install)
