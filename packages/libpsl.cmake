ExternalProject_Add(libpsl
    GIT_REPOSITORY https://github.com/rockdaboot/libpsl.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--sparse --filter=tree:0"
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !/fuzz"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 meson setup <BINARY_DIR> <SOURCE_DIR>
        ${meson_conf_args}
        -Dtests=false
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libpsl)
force_meson_configure(libpsl)
cleanup(libpsl install)
