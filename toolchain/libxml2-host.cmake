ExternalProject_Add(libxml2-host
    DEPENDS
        zlib-host
    GIT_REPOSITORY https://github.com/GNOME/libxml2.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--sparse --filter=tree:0"
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !result !test"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 PATH=$O_PATH cmake -H<SOURCE_DIR> -B<BINARY_DIR>
        -GNinja
        -DCMAKE_BUILD_TYPE=Release
        -DBUILD_SHARED_LIBS=OFF
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
        -DCMAKE_C_COMPILER=clang
        -DCMAKE_CXX_COMPILER=clang++
        -DLIBXML2_WITH_ICONV=OFF
        -DLIBXML2_WITH_ICU=OFF
        -DLIBXML2_WITH_LZMA=OFF
        -DLIBXML2_WITH_PYTHON=OFF
        -DLIBXML2_WITH_TESTS=OFF
        -DLIBXML2_WITH_HTTP=OFF
        -DLIBXML2_WITH_ZLIB=ON
        -DLIBXML2_WITH_TREE=ON
        -DLIBXML2_WITH_THREADS=ON
        -DLIBXML2_WITH_THREAD_ALLOC=ON
        -DLIBXML2_WITH_TLS=ON
        -DLIBXML2_WITH_PROGRAMS=OFF
        -DZLIB_LIBRARY=${CMAKE_INSTALL_PREFIX}/lib/libz.a
        -DZLIB_INCLUDE_DIR=${CMAKE_INSTALL_PREFIX}/include
        "-DCMAKE_C_FLAGS='-march=native -pipe -O3 -fno-semantic-interposition -fno-math-errno -fno-signed-zeros -fno-trapping-math -falign-functions=32 -ffp-contract=fast -ftls-model=local-exec ${tlsdesc} -fdata-sections -ffunction-sections ${llvm_lto} ${llvm_mllvm}'"
        "-DCMAKE_CXX_FLAGS='-march=native -pipe -O3 -fno-semantic-interposition -fno-math-errno -fno-signed-zeros -fno-trapping-math -falign-functions=32 -ffp-contract=fast -ftls-model=local-exec ${tlsdesc} -fdata-sections -ffunction-sections ${llvm_lto} ${llvm_mllvm}'"
        "-DCMAKE_EXE_LINKER_FLAGS='-fuse-ld=lld -Wl,--build-id=fast,-s,--icf=all,--gc-sections ${llvm_mllvm_ld}'"
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libxml2-host)
cleanup(libxml2-host install)
