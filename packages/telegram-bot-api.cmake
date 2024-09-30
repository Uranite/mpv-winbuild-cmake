ExternalProject_Add(telegram-bot-api
    DEPENDS
        zlib
        zstd
        openssl
    GIT_REPOSITORY https://github.com/tdlib/telegram-bot-api.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0 --recurse-submodules"
    GIT_CLONE_POST_COMMAND "config submodule.recurse true"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} PATH=$O_PATH CONF=1 cmake --fresh -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DTD_ENABLE_LTO=OFF
        -DCCACHE_FOUND=OFF
        -DMEMPROF=OFF
        -DCMAKE_TOOLCHAIN_FILE=""
        -DCMAKE_FIND_ROOT_PATH=/usr
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
        -DTD_ENABLE_DOTNET=OFF
        -DTD_ENABLE_JNI=OFF
    COMMAND ${EXEC} ninja -C <BINARY_DIR> prepare_cross_compiling
    COMMAND ${EXEC} CONF=1 cmake --fresh -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DTD_ENABLE_LTO=OFF
        -DCCACHE_FOUND=OFF
        -DMEMPROF=OFF
        -DTD_ENABLE_DOTNET=OFF
        -DTD_ENABLE_JNI=OFF
        -DCMAKE_CROSSCOMPILING=ON
        "-DCMAKE_CXX_FLAGS='-lbrotlicommon -lbrotlidec -lbrotlienc -lzstd -liphlpapi -pthread'"
    BUILD_COMMAND ${EXEC} "FILTER_FLAGS='-Wl,--exclude-libs,ALL'" ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(telegram-bot-api)
cleanup(telegram-bot-api install)
