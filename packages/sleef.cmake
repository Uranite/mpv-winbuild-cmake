ExternalProject_Add(sleef
    GIT_REPOSITORY https://github.com/shibatch/sleef.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} PATH=$O_PATH CONF=1 cmake --fresh -H<SOURCE_DIR> -B<BINARY_DIR>/host
        ${cmake_conf_args}
        -DCMAKE_TOOLCHAIN_FILE=""
        -DCMAKE_FIND_ROOT_PATH=/usr
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
        -DSLEEF_BUILD_DFT=ON
        -DSLEEF_DISABLE_OPENMP=ON
        -DSLEEF_ENABLE_LTO=OFF
        -DSLEEF_BUILD_TESTS=OFF
        -DSLEEF_DISABLE_SSE2=ON
        -DSLEEF_DISABLE_FMA4=ON
        -DSLEEF_DISABLE_SVE=ON
        -DSLEEF_DISABLE_AVX=ON
    COMMAND ${EXEC} ninja -C <BINARY_DIR>/host
    COMMAND ${EXEC} CONF=1 cmake --fresh -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DNATIVE_BUILD_DIR=<BINARY_DIR>/host
        -DSLEEF_SHOW_CONFIG=ON
        -DSLEEF_BUILD_INLINE_HEADERS=OFF
        -DSLEEF_DISABLE_OPENMP=ON
        -DSLEEF_BUILD_DFT=ON
        -DSLEEF_ENABLE_CXX=ON
        -DSLEEF_BUILD_LIBM=ON
        -DSLEEF_ENABLE_LLVM_BITCODE=OFF
        -DSLEEF_ENABLE_LTO=OFF
        -DSLEEF_BUILD_TESTS=OFF
        -DSLEEF_DISABLE_SSE2=ON
        -DSLEEF_DISABLE_SSE4=ON
        -DSLEEF_DISABLE_FMA4=ON
        -DSLEEF_DISABLE_SVE=ON
        -DSLEEF_DISABLE_AVX=ON
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
            COMMAND ${EXEC} "echo 'Cflags: -DSLEEF_STATIC_LIBS -DIMPORT_IS_EXPORT -DSLEEF_ALWAYS_INLINE' >> ${MINGW_INSTALL_PREFIX}/lib/pkgconfig/sleef.pc"
            COMMAND ${EXEC} "echo 'Libs: -lsleef -lsleefdft' >> ${MINGW_INSTALL_PREFIX}/lib/pkgconfig/sleef.pc"
            COMMAND ${EXEC} cp ${MINGW_INSTALL_PREFIX}/lib/pkgconfig/sleef.pc ${MINGW_INSTALL_PREFIX}/lib/pkgconfig/sleefdft.pc
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(sleef)
cleanup(sleef install)
