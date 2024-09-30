ExternalProject_Add(svtav1
    GIT_REPOSITORY https://github.com/gianni-rosato/svt-av1-psy.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 cmake -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DENABLE_AVX512=ON
        -DBUILD_TESTING=OFF
        -DSVT_AV1_LTO=OFF
        -DBUILD_APPS=ON
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(svtav1)
cleanup(svtav1 install)
