ExternalProject_Add(libmediainfo
    DEPENDS
        zlib
        zenlib
    GIT_REPOSITORY https://github.com/MediaArea/MediaInfoLib.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 cmake -H<SOURCE_DIR>/Project/CMake -B<BINARY_DIR>
        ${cmake_conf_args}
        -DBUILD_SHARED_LIBS=ON
        -DBUILD_ZLIB=OFF
        -DBUILD_ZENLIB=OFF
        -DCURL_FOUND=OFF
        -DCMAKE_DISABLE_FIND_PACKAGE_CURL=ON
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
            COMMAND ${EXEC} rm -rf ${MINGW_INSTALL_PREFIX}/lib/libmediainfo.dll.a
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

get_property(source_dir TARGET libmediainfo PROPERTY _EP_SOURCE_DIR)

ExternalProject_Add(libmediainfo-static
    DEPENDS
        libmediainfo
    DOWNLOAD_COMMAND ""
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 cmake -H${source_dir}/Project/CMake -B<BINARY_DIR>
        ${cmake_conf_args}
        -DBUILD_ZLIB=OFF
        -DBUILD_ZENLIB=OFF
        -DCURL_FOUND=OFF
        -DCMAKE_DISABLE_FIND_PACKAGE_CURL=ON
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

function(delete_dir)
    foreach(arg IN LISTS ARGV)
        ExternalProject_Add_Step(${arg} delete-dir
            DEPENDEES install
            COMMAND bash -c "rm -rf <BINARY_DIR>/*"
            COMMENT "Delete build directory"
        )
    endforeach()
endfunction()

force_rebuild_git(libmediainfo)
cleanup(libmediainfo install)
cleanup(libmediainfo-static install)
delete_dir(libmediainfo-static)
