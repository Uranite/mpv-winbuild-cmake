ExternalProject_Add(mimalloc
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_REPOSITORY https://github.com/microsoft/mimalloc.git
    GIT_CLONE_FLAGS "--filter=tree:0"
    UPDATE_COMMAND ""
    GIT_REMOTE_NAME origin
    GIT_TAG dev-slice
    CONFIGURE_COMMAND ${EXEC} CONF=1 cmake -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DMI_BUILD_SHARED=ON
        -DMI_BUILD_STATIC=OFF
        -DMI_BUILD_TESTS=OFF
        -DMI_INSTALL_TOPLEVEL=ON
        -DMI_OVERRIDE=ON
        -DMI_SKIP_COLLECT_ON_EXIT=ON
        -DMI_USE_CXX=ON
        -DBUILD_SHARED_LIBS=ON
    BUILD_COMMAND ${EXEC} LE_TLS=0 PGO=0 ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
            COMMAND ${EXEC} mv ${MINGW_INSTALL_PREFIX}/bin/libmimalloc.dll ${MINGW_INSTALL_PREFIX}/bin/mimalloc-override.dll
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(mimalloc)
cleanup(mimalloc install)
