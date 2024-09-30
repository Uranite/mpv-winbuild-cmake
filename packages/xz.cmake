ExternalProject_Add(xz
    GIT_REPOSITORY https://github.com/tukaani-project/xz.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 cmake -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DXZ_THREADS=yes
        -DBUILD_TESTING=OFF
        -DXZ_TOOL_LZMAINFO=OFF
        -DXZ_TOOL_LZMADEC=OFF
        -DXZ_TOOL_XZDEC=OFF
        -DXZ_TOOL_XZ=OFF
        -DXZ_TOOL_SCRIPTS=OFF
        -DXZ_DOC=OFF
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(xz)
cleanup(xz install)
