ExternalProject_Add(libopenmpt
    DEPENDS
        zlib
        ogg
        vorbis
        libsdl2
    URL https://lib.openmpt.org/files/libopenmpt/src/libopenmpt-0.7.10+release.autotools.tar.gz
    URL_HASH SHA256=093713C1C1024F4F10C4779A66CEB2AF51FB7C908A9E99FEB892D04019220BA1
    DOWNLOAD_DIR ${SOURCE_LOCATION}
    CONFIGURE_COMMAND ${EXEC} autoreconf -fi && ${EXEC} CONF=1 <SOURCE_DIR>/configure
        ${autotools_conf_args}
        --disable-openmpt123
        --disable-examples
        --disable-tests
        --disable-doxygen-doc
        --disable-doxygen-html
        --without-mpg123
        --without-flac
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    BUILD_IN_SOURCE 1
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(libopenmpt install)
