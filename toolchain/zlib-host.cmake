ExternalProject_Add(zlib-host
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_REPOSITORY https://github.com/zlib-ng/zlib-ng.git
    GIT_CLONE_FLAGS "--filter=tree:0"
    UPDATE_COMMAND ""
    GIT_REMOTE_NAME origin
    GIT_TAG develop
    CONFIGURE_COMMAND ${EXEC} CONF=1 PATH=$O_PATH cmake -H<SOURCE_DIR> -B<BINARY_DIR>
        -GNinja
        -DCMAKE_BUILD_TYPE=Release
        -DBUILD_SHARED_LIBS=OFF
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
        -DCMAKE_C_COMPILER=clang
        -DCMAKE_CXX_COMPILER=clang++
        -DSKIP_INSTALL_LIBRARIES=OFF
        -DZLIB_COMPAT=ON
        -DZLIB_ENABLE_TESTS=OFF
        -DZLIBNG_ENABLE_TESTS=OFF
        -DFNO_LTO_AVAILABLE=OFF
        "-DCMAKE_C_FLAGS='-march=native -pipe -O3 -fno-semantic-interposition -fno-math-errno -fno-signed-zeros -fno-trapping-math -falign-functions=32 -ffp-contract=fast -ftls-model=local-exec ${tlsdesc} -fdata-sections -ffunction-sections ${llvm_lto} ${llvm_mllvm}'"
        "-DCMAKE_CXX_FLAGS='-march=native -pipe -O3 -fno-semantic-interposition -fno-math-errno -fno-signed-zeros -fno-trapping-math -falign-functions=32 -ffp-contract=fast -ftls-model=local-exec ${tlsdesc} -fdata-sections -ffunction-sections ${llvm_lto} ${llvm_mllvm}'"
        "-DCMAKE_EXE_LINKER_FLAGS='-fuse-ld=lld -Wl,--build-id=fast,-s,--icf=all,--gc-sections ${llvm_mllvm_ld}'"
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(zlib-host)
cleanup(zlib-host install)
