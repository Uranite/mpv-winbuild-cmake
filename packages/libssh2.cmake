ExternalProject_Add(libssh2
    DEPENDS
        zlib
    GIT_REPOSITORY https://github.com/libssh2/libssh2.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 cmake -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DBUILD_TESTING=OFF
        -DBUILD_EXAMPLES=OFF
        -DCRYPTO_BACKEND=WinCNG
        -DENABLE_ECDSA_WINCNG=ON
        -DENABLE_ZLIB_COMPRESSION=ON
        -DRUN_DOCKER_TESTS=OFF
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libssh2)
cleanup(libssh2 install)
