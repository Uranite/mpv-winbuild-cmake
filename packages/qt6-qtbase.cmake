ExternalProject_Add(qt6-qtbase
    DEPENDS
        brotli
        freetype2
        harfbuzz
        zlib
        zstd
        vulkan
        libjpeg
        libpng
        openssl
        bzip2
    GIT_REPOSITORY https://github.com/qt/qtbase.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    GIT_REMOTE_NAME origin
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !tests"
    GIT_TAG dev
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ""
    COMMAND ${EXEC} CONF=1 PATH=$O_PATH PKG_CONFIG_LIBDIR= PKG_CONFIG=pkgconf cmake -H<SOURCE_DIR> -B<BINARY_DIR>/qthost
        -GNinja
        -DCMAKE_BUILD_TYPE=Release
        -DBUILD_SHARED_LIBS=OFF
        -DCMAKE_C_COMPILER=clang
        -DCMAKE_CXX_COMPILER=clang++
        -DCMAKE_C_COMPILER_WORKS=1
        -DCMAKE_CXX_COMPILER_WORKS=1
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}/qt6
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
        -DQT_FEATURE_accessibility=OFF
        -DQT_FEATURE_xcb=OFF
        -DQT_FEATURE_xcb_xlib=OFF
        -DQT_FEATURE_xkbcommon=OFF
        -DQT_FEATURE_egl=OFF
        -DQT_INSTALL_EXAMPLES_SOURCES_BY_DEFAULT=OFF
        -DQT_UNITY_BUILD=ON
        -DQT_USE_CCACHE=ON
        "-DCMAKE_C_CFLAGS='-Xclang -fno-pch-timestamp'"
        "-DCMAKE_CXX_CFLAGS='-Xclang -fno-pch-timestamp'"
    COMMAND ${EXEC} PATH=$O_PATH ninja -C <BINARY_DIR>/qthost install
    COMMAND ${EXEC} CONF=1 cmake -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DBUILD_SHARED_LIBS=OFF
        -DBUILD_WITH_PCH=ON
        -DCMAKE_C_COMPILER_WORKS=1
        -DCMAKE_CXX_COMPILER_WORKS=1
        -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}/qt6
        -DCMAKE_PREFIX_PATH=${MINGW_INSTALL_PREFIX}
        -DQT_BUILD_BENCHMARKS=OFF
        -DQT_BUILD_EXAMPLES_BY_DEFAULT=OFF
        -DQT_BUILD_EXAMPLES=OFF
        -DQT_BUILD_TESTS_BY_DEFAULT=OFF
        -DQT_BUILD_TESTS=OFF
        -DQT_FEATURE_brotli=ON
        -DQT_FEATURE_cpp_winrt=ON
        -DQT_FEATURE_cxx20=ON
        -DQT_FEATURE_egl=OFF
        -DQT_FEATURE_fontconfig=OFF
        -DQT_FEATURE_openssl=ON
        -DQT_FEATURE_pkg_config=ON
        -DQT_FEATURE_sql_mysql=OFF
        -DQT_FEATURE_sql_odbc=ON
        -DQT_FEATURE_sql_psql=OFF
        -DQT_FEATURE_static_runtime=ON
        -DQT_FEATURE_system_freetype=ON
        -DQT_FEATURE_system_harfbuzz=ON
        -DQT_FEATURE_system_jpeg=ON
        -DQT_FEATURE_system_openssl=ON
        -DQT_FEATURE_system_png=ON
        -DQT_FEATURE_system_sqlite=OFF
        -DQT_FEATURE_system_webp=ON
        -DQT_FEATURE_system_zlib=ON
        -DQT_FEATURE_vulkan=ON
        -DQT_FEATURE_zstd=ON
        -DQT_HOST_PATH=${CMAKE_INSTALL_PREFIX}/qt6
        -DQT_INSTALL_EXAMPLES_SOURCES_BY_DEFAULT=OFF
        -DQT_UNITY_BUILD=ON
        -DTEST_opensslv30=TRUE
        "-DCMAKE_C_FLAGS='-lruntimeobject -lrpcrt4 -lusp10 -lbz2 -lbrotlicommon -lbrotlidec -lbrotlienc -lzstd'"
        "-DCMAKE_CXX_FLAGS='-lruntimeobject -lrpcrt4 -lusp10 -lbz2 -lbrotlicommon -lbrotlidec -lbrotlienc -lzstd'"
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(qt6-qtbase)
cleanup(qt6-qtbase install)
