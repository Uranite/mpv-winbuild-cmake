ExternalProject_Add(x265
    GIT_REPOSITORY https://bitbucket.org/multicoreware/x265_git.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 cmake -H<SOURCE_DIR>/source -B<BINARY_DIR>/12b
        ${cmake_conf_args}
        -DENABLE_CLI=OFF
        -DENABLE_HDR10_PLUS=ON
        -DENABLE_SHARED=OFF
        -DEXPORT_C_API=OFF
        -DHIGH_BIT_DEPTH=ON
        -DENABLE_ALPHA=ON
        -DENABLE_MULTIVIEW=ON
        -DENABLE_SCC_EXT=ON
        -DMAIN12=ON
        -DLINKED_10BIT=ON
        -DEXTRA_LIB=ON
    COMMAND ${EXEC} CONF=1 cmake -H<SOURCE_DIR>/source -B<BINARY_DIR>/10b
        ${cmake_conf_args}
        -DENABLE_CLI=OFF
        -DENABLE_HDR10_PLUS=ON
        -DENABLE_SHARED=OFF
        -DEXPORT_C_API=OFF
        -DHIGH_BIT_DEPTH=ON
        -DENABLE_ALPHA=ON
        -DENABLE_MULTIVIEW=ON
        -DENABLE_SCC_EXT=ON
        -DLINKED_12BIT=ON
        -DEXTRA_LIB=ON
    COMMAND ${EXEC} CONF=1 cmake -H<SOURCE_DIR>/source -B<BINARY_DIR>
        ${cmake_conf_args}
        -DENABLE_CLI=ON
        -DENABLE_HDR10_PLUS=ON
        -DENABLE_SHARED=OFF
        -DLINKED_10BIT=ON
        -DLINKED_12BIT=ON
        -DENABLE_ALPHA=ON
        -DENABLE_MULTIVIEW=ON
        -DENABLE_SCC_EXT=ON
        -DEXTRA_LINK_FLAGS=-L.
        "-DEXTRA_LIB='-lx26510 -lx26512'"
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>/12b
    COMMAND ${EXEC} mv <BINARY_DIR>/12b/libx265.a <BINARY_DIR>/libx26512.a
    COMMAND ${EXEC} ninja -C <BINARY_DIR>/10b
    COMMAND ${EXEC} mv <BINARY_DIR>/10b/libx265.a <BINARY_DIR>/libx26510.a
    COMMAND ${EXEC} ninja -C <BINARY_DIR>
    COMMAND bash -c "cd <BINARY_DIR> && echo -e 'create libx265.a\naddlib libx265.a\naddlib libx26510.a\naddlib libx26512.a\nsave\nend' | ${EXEC} ${TARGET_ARCH}-ar -M"
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(x265)
cleanup(x265 install)
