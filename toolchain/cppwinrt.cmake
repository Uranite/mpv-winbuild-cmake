ExternalProject_Add(cppwinrt
    GIT_REPOSITORY https://github.com/microsoft/cppwinrt.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    UPDATE_COMMAND ""
    GIT_REMOTE_NAME origin
    GIT_TAG master
    CONFIGURE_COMMAND ${EXEC} CONF=1 cmake -H<SOURCE_DIR> -B<BINARY_DIR>
        -G Ninja
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
            COMMAND bash -c "wget -O <BINARY_DIR>/Windows.winmd  https://github.com/microsoft/windows-rs/raw/master/crates/libs/bindgen/default/Windows.winmd"
            COMMAND ${EXEC} cppwinrt -in <BINARY_DIR>/Windows.winmd -out ${MINGW_INSTALL_PREFIX}/include/
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(cppwinrt)
cleanup(cppwinrt install)
