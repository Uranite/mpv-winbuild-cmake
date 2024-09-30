ExternalProject_Add(qt6-qttools
    DEPENDS
        qt6-qtbase
    GIT_REPOSITORY https://github.com/qt/qttools.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    GIT_REMOTE_NAME origin
    GIT_TAG dev
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} PATH=$O_PATH PKG_CONFIG_LIBDIR= PKG_CONFIG=pkgconf cmake -H<SOURCE_DIR> -B<BINARY_DIR>
        -GNinja
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}/qt6
        -DCMAKE_BUILD_TYPE=Release
        -DBUILD_SHARED_LIBS=OFF
        -DCMAKE_C_COMPILER=clang
        -DCMAKE_CXX_COMPILER=clang++
        -DCMAKE_C_COMPILER_WORKS=1
        -DCMAKE_CXX_COMPILER_WORKS=1
        -DBUILD_WITH_PCH=ON
        -DINPUT_opengl=no
        -DQT_FEATURE_opengl_dynamic=OFF
        -DQT_BUILD_BENCHMARKS=OFF
        -DQT_BUILD_EXAMPLES=OFF
        -DQT_BUILD_EXAMPLES_BY_DEFAULT=OFF
        -DQT_BUILD_TESTS_BY_DEFAULT=OFF
        -DQT_BUILD_TESTS=OFF
        -DQT_FEATURE_gui=OFF
        -DQT_FEATURE_opengl=OFF
        -DQT_FEATURE_opengles2=OFF
        -DQT_FEATURE_opengl_desktop=OFF
        -DQT_FEATURE_egl=OFF
        -DQT_INSTALL_EXAMPLES_SOURCES_BY_DEFAULT=OFF
        -DQT_UNITY_BUILD=ON
        -DQT_USE_CCACHE=ON
        -DQT_FEATURE_clang=OFF
        -DQT_FEATURE_clang-rtti=OFF
        -DQT_FEATURE_qdoc=OFF
        -DQT_FEATURE_clangcpp=OFF
        -DQT_FEATURE_qev=OFF
        -DQT_FEATURE_assistant=OFF
        -DQT_FEATURE_designer=OFF
        -DQT_FEATURE_distancefieldgenerator=OFF
        -DQT_FEATURE_kmap2qmap=OFF
        -DQT_FEATURE_pixeltool=OFF
        -DQT_FEATURE_qdbus=OFF
        -DQT_FEATURE_qev=OFF
        -DQT_FEATURE_qtattributionsscanner=OFF
        -DQT_FEATURE_qtdiag=OFF
        -DQT_FEATURE_qtplugininfo=OFF
        -DQT_FEATURE_linguist=ON
        -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}/qt6
        -DCMAKE_FIND_ROOT_PATH=${CMAKE_INSTALL_PREFIX}/qt6
        -DCMAKE_FIND_ROOT_PATH_MODE_PACKAGE=ONLY
        "-DCMAKE_C_CFLAGS='-Xclang -fno-pch-timestamp'"
        "-DCMAKE_CXX_CFLAGS='-Xclang -fno-pch-timestamp'"
    BUILD_COMMAND ${EXEC} PATH=$O_PATH ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} PATH=$O_PATH ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(qt6-qttools)
cleanup(qt6-qttools install)
