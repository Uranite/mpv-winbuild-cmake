ExternalProject_Add(sqlite
    URL https://www.sqlite.org/2024/sqlite-autoconf-3460000.tar.gz
    URL_HASH SHA3_256=83d2acf79453deb7d6520338b1f4585f12e39b27cd370fb08593afa198f471fc
    DOWNLOAD_DIR ${SOURCE_LOCATION}
    CONFIGURE_COMMAND ${EXEC} autoreconf -fi && ${EXEC} CONF=1 <SOURCE_DIR>/configure
        ${autotools_conf_args}
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    BUILD_IN_SOURCE 1
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(sqlite install)
