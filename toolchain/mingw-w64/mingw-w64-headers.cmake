ExternalProject_Add(mingw-w64-headers
    DEPENDS
        mingw-w64
        ${binutils}
    DOWNLOAD_COMMAND ""
    UPDATE_COMMAND ""
    SOURCE_DIR ${MINGW_SRC}
    CONFIGURE_COMMAND <SOURCE_DIR>/mingw-w64-headers/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --enable-sdk=all
        --enable-idl
        --with-default-msvcrt=ucrt
    BUILD_COMMAND ""
    INSTALL_COMMAND make install-strip
            COMMAND ${EXEC} cp ${MINGW_INSTALL_PREFIX}/include/windows.h ${MINGW_INSTALL_PREFIX}/include/Windows.h
            COMMAND ${EXEC} cp ${MINGW_INSTALL_PREFIX}/include/ntsecapi.h ${MINGW_INSTALL_PREFIX}/include/Ntsecapi.h
            COMMAND ${EXEC} cp ${MINGW_INSTALL_PREFIX}/include/shlobj.h ${MINGW_INSTALL_PREFIX}/include/Shlobj.h
            COMMAND ${EXEC} cp ${MINGW_INSTALL_PREFIX}/include/shellapi.h ${MINGW_INSTALL_PREFIX}/include/Shellapi.h
            COMMAND ${EXEC} cp ${MINGW_INSTALL_PREFIX}/include/objbase.h ${MINGW_INSTALL_PREFIX}/include/Objbase.h
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(mingw-w64-headers install)
tc_delete_dir(mingw-w64-headers)
