ExternalProject_Add(mediainfo
    DEPENDS
        libmediainfo-static
    GIT_REPOSITORY https://github.com/MediaArea/MediaInfo.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} cd Project/GNU/CLI && autoreconf -fi && ${EXEC} CONF=1 ./configure
        ${autotools_conf_args}
    BUILD_COMMAND ${MAKE} -C Project/GNU/CLI
    INSTALL_COMMAND ${MAKE} install -C Project/GNU/CLI
    BUILD_IN_SOURCE 1
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(mediainfo)
cleanup(mediainfo install)
