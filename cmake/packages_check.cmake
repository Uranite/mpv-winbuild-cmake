if(COMPILER_TOOLCHAIN STREQUAL "gcc")
    set(rust_target "gnu")
    set(vapoursynth_pkgconfig_libs "-lvapoursynth")
    set(vapoursynth_script_pkgconfig_libs "-lvsscript")
    set(vapoursynth_manual_install_copy_lib COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/libvsscript.a ${MINGW_INSTALL_PREFIX}/lib/libvsscript.a
                                            COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/libvapoursynth.a ${MINGW_INSTALL_PREFIX}/lib/libvapoursynth.a)
    set(ffmpeg_extra_libs "-lstdc++")
    set(libjxl_unaligned_vector "-Wa,-muse-unaligned-vector-move") # fix crash on AVX2 proc (64bit) due to unaligned stack memory
    set(mpv_copy_debug COMMAND ${CMAKE_COMMAND} -E copy <BINARY_DIR>/mpv.debug ${CMAKE_CURRENT_BINARY_DIR}/mpv-debug/mpv.debug)
    set(mpv_add_debuglink COMMAND ${EXEC} ${TARGET_ARCH}-objcopy --only-keep-debug <BINARY_DIR>/mpv.exe <BINARY_DIR>/mpv.debug
                          COMMAND ${EXEC} ${TARGET_ARCH}-strip -s <BINARY_DIR>/mpv.exe
                          COMMAND ${EXEC} ${TARGET_ARCH}-objcopy --add-gnu-debuglink=<BINARY_DIR>/mpv.debug <BINARY_DIR>/mpv.exe
                          COMMAND ${EXEC} ${TARGET_ARCH}-strip -s <BINARY_DIR>/mpv.com
                          COMMAND ${EXEC} ${TARGET_ARCH}-strip -s <BINARY_DIR>/libmpv-2.dll)
    set(rust_target "gnu")
elseif(COMPILER_TOOLCHAIN STREQUAL "clang")
    set(rust_target "gnullvm")
    set(vapoursynth_pkgconfig_libs "-lVapourSynth -Wl,-delayload=VapourSynth.dll")
    set(vapoursynth_script_pkgconfig_libs "-lVSScript -Wl,-delayload=VSScript.dll")
    set(vapoursynth_manual_install_copy_lib COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/VSScript.lib ${MINGW_INSTALL_PREFIX}/lib/VSScript.lib
                                            COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/VapourSynth.lib ${MINGW_INSTALL_PREFIX}/lib/VapourSynth.lib)
    set(ffmpeg_extra_libs "-lc++")
    set(ffmpeg_hardcoded_tables "--enable-hardcoded-tables")
    set(mpv_lto_mode "-Db_lto_mode=thin")
    set(mpv_copy_debug COMMAND ${CMAKE_COMMAND} -E copy <BINARY_DIR>/mpv.pdb ${CMAKE_CURRENT_BINARY_DIR}/mpv-debug/mpv.pdb
                       COMMAND ${CMAKE_COMMAND} -E copy <BINARY_DIR>/libmpv-2.pdb ${CMAKE_CURRENT_BINARY_DIR}/mpv-debug/libmpv-2.pdb)
    set(rust_target "gnullvm")
    if(CLANG_PACKAGES_LTO)
        set(cargo_lto_rustflags "CARGO_PROFILE_RELEASE_LTO=thin
        RUSTFLAGS='-Ctarget-cpu=${GCC_ARCH} -Cforce-frame-pointers=no -Ccontrol-flow-guard=yes -Clinker-plugin-lto=yes -Clto=thin -Cllvm-args=-fp-contract=fast -Zthreads=${CPU_COUNT}'")
        set(ffmpeg_lto "--enable-lto=thin")
        if(NOT (GCC_ARCH_HAS_AVX OR (TARGET_CPU STREQUAL "aarch64")))
            set(zlib_nlto "LTO=0")
        endif()
    endif()
endif()

if(TARGET_CPU STREQUAL "x86_64")
    set(dlltool_image "i386:x86-64")
    set(vulkan_asm "-DUSE_GAS=ON")
    set(openssl_target "mingw64")
    set(openssl_ec_opt "enable-ec_nistp_64_gcc_128")
    set(libvpx_target "x86_64-win64-gcc")
    set(mpv_gl "-Dgl=enabled -Degl-angle=enabled")
    set(xxhash_dispatch "-DDISPATCH=ON")
    set(xxhash_cflags "-DXXH_X86DISPATCH_ALLOW_AVX=1 -DXXH_ENABLE_AUTOVECTORIZE=1")
    set(nvcodec_headers "nvcodec-headers")
    set(ffmpeg_cuda "--enable-cuda-llvm --enable-cuvid --enable-nvdec --enable-nvenc --disable-ptx-compression")
elseif(TARGET_CPU STREQUAL "i686")
    set(dlltool_image "i386")
    set(vulkan_asm "-DUSE_MASM=OFF")
    set(openssl_target "mingw")
    set(libvpx_target "x86-win32-gcc")
    set(mpv_gl "-Dgl=enabled -Degl-angle=enabled")
    set(xxhash_dispatch "-DDISPATCH=ON")
    set(xxhash_cflags "-DXXH_X86DISPATCH_ALLOW_AVX=1")
    set(nvcodec_headers "nvcodec-headers")
    set(ffmpeg_cuda "--enable-cuda-llvm --enable-cuvid --enable-nvdec --enable-nvenc --disable-ptx-compression")
elseif(TARGET_CPU STREQUAL "aarch64")
    set(dlltool_image "arm64")
    set(vulkan_asm "-DUSE_GAS=ON")
    set(openssl_target "mingw-arm64")
    set(openssl_ec_opt "enable-ec_nistp_64_gcc_128")
    set(libvpx_target "arm64-win64-gcc")
    set(mpv_gl "-Dgl=disabled -Degl-angle=disabled")
endif()

set(cmake_conf_args
    -GNinja
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}
    -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}
    -DBUILD_SHARED_LIBS=OFF
    -DCMAKE_C_COMPILER_WORKS=1
    -DCMAKE_CXX_COMPILER_WORKS=1
)
set(meson_conf_args
    --prefix=${MINGW_INSTALL_PREFIX}
    --libdir=${MINGW_INSTALL_PREFIX}/lib
    --cross-file=${MESON_CROSS}
    --buildtype=release
    --default-library=static
)
set(autotools_conf_args
    --host=${TARGET_ARCH}
    --prefix=${MINGW_INSTALL_PREFIX}
    --disable-shared
    --enable-static
)
