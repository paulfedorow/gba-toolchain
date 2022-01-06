#===============================================================================
#
# CMake toolchain configuration package for external GBA  libraries
#
# Copyright (C) 2021-2022 gba-toolchain contributors
# For conditions of distribution and use, see copyright notice in LICENSE.md
#
#===============================================================================

cmake_minimum_required(VERSION 3.20)

#! _gba_find_ext_tonclib : Locate and download Tonclib/libtonc
#
function(_gba_find_ext_tonclib)
    if(NOT EXISTS "${GBA_TOOLCHAIN_LIST_DIR}/lib/tonc/Makefile")
        if(NOT EXISTS "${GBA_TOOLCHAIN_LIST_DIR}/dependencies.ini")
            if(NOT DEPENDENCIES_URL)
                message(FATAL_ERROR "Missing DEPENDENCIES_URL")
            endif()

            file(DOWNLOAD "${DEPENDENCIES_URL}" "${GBA_TOOLCHAIN_LIST_DIR}/dependencies.ini" SHOW_PROGRESS)
        endif()

        file(READ "${GBA_TOOLCHAIN_LIST_DIR}/dependencies.ini" iniFile)
        _ini_read_section("${iniFile}" "tonclib" tonclib)

        message(STATUS "Downloading tonclib from \"${tonclib_url}\" to \"${GBA_TOOLCHAIN_LIST_DIR}/lib/tonc\"")
        _gba_download("${tonclib_url}" "${GBA_TOOLCHAIN_LIST_DIR}/lib/tonc" SHOW_PROGRESS EXPECTED_MD5 "${tonclib_md5}")
    endif()

    if(EXISTS "${GBA_TOOLCHAIN_LIST_DIR}/lib/tonc" AND NOT EXISTS "${GBA_TOOLCHAIN_LIST_DIR}/lib/tonc/CMakeLists.txt")
        file(COPY "${GBA_TOOLCHAIN_LIST_DIR}/cmake/ToncCMakeLists.cmake" DESTINATION "${GBA_TOOLCHAIN_LIST_DIR}/lib/tonc")
        file(RENAME "${GBA_TOOLCHAIN_LIST_DIR}/lib/tonc/ToncCMakeLists.cmake" "${GBA_TOOLCHAIN_LIST_DIR}/lib/tonc/CMakeLists.txt")
    endif()
endfunction()

#! _gba_find_ext_libseven : Locate and download libseven
#
function(_gba_find_ext_libseven)
    if(NOT EXISTS "${GBA_TOOLCHAIN_LIST_DIR}/lib/seven/Makefile")
        if(NOT EXISTS "${GBA_TOOLCHAIN_LIST_DIR}/dependencies.ini")
            if(NOT DEPENDENCIES_URL)
                message(FATAL_ERROR "Missing DEPENDENCIES_URL")
            endif()

            file(DOWNLOAD "${DEPENDENCIES_URL}" "${GBA_TOOLCHAIN_LIST_DIR}/dependencies.ini" SHOW_PROGRESS)
        endif()

        file(READ "${GBA_TOOLCHAIN_LIST_DIR}/dependencies.ini" iniFile)
        _ini_read_section("${iniFile}" "libseven" libseven)

        message(STATUS "Downloading libseven from \"${libseven_url}\" to \"${GBA_TOOLCHAIN_LIST_DIR}/lib/seven\"")
        _gba_download("${libseven_url}" "${GBA_TOOLCHAIN_LIST_DIR}/lib/seven" SHOW_PROGRESS)
    endif()

    if(EXISTS "${GBA_TOOLCHAIN_LIST_DIR}/lib/seven" AND NOT EXISTS "${GBA_TOOLCHAIN_LIST_DIR}/lib/seven/CMakeLists.txt")
        file(COPY "${GBA_TOOLCHAIN_LIST_DIR}/cmake/LibsevenCMakeLists.cmake" DESTINATION "${GBA_TOOLCHAIN_LIST_DIR}/lib/seven")
        file(RENAME "${GBA_TOOLCHAIN_LIST_DIR}/lib/seven/LibsevenCMakeLists.cmake" "${GBA_TOOLCHAIN_LIST_DIR}/lib/seven/CMakeLists.txt")
    endif()
endfunction()

#! _gba_find_ext_posprintf : Locate and download posprintf
#
function(_gba_find_ext_posprintf)
    if(NOT EXISTS "${GBA_TOOLCHAIN_LIST_DIR}/lib/posprintf/license.txt")
        if(NOT EXISTS "${GBA_TOOLCHAIN_LIST_DIR}/dependencies.ini")
            if(NOT DEPENDENCIES_URL)
                message(FATAL_ERROR "Missing DEPENDENCIES_URL")
            endif()

            file(DOWNLOAD "${DEPENDENCIES_URL}" "${GBA_TOOLCHAIN_LIST_DIR}/dependencies.ini" SHOW_PROGRESS)
        endif()

        file(READ "${GBA_TOOLCHAIN_LIST_DIR}/dependencies.ini" iniFile)
        _ini_read_section("${iniFile}" "posprintf" posprintf)

        message(STATUS "Downloading posprintf from \"${posprintf_url}\" to \"${GBA_TOOLCHAIN_LIST_DIR}/lib/posprintf\"")
        _gba_download("${posprintf_url}" "${GBA_TOOLCHAIN_LIST_DIR}/lib/posprintf" SHOW_PROGRESS)
    endif()

    if(EXISTS "${GBA_TOOLCHAIN_LIST_DIR}/lib/posprintf" AND NOT EXISTS "${GBA_TOOLCHAIN_LIST_DIR}/lib/posprintf/CMakeLists.txt")
        # Fix folder structure
        file(COPY "${GBA_TOOLCHAIN_LIST_DIR}/lib/posprintf/posprintf/" DESTINATION "${GBA_TOOLCHAIN_LIST_DIR}/lib/posprintf/")
        file(REMOVE_RECURSE "${GBA_TOOLCHAIN_LIST_DIR}/lib/posprintf/posprintf/" "${GBA_TOOLCHAIN_LIST_DIR}/lib/posprintf/__MACOSX/")
        file(COPY "${GBA_TOOLCHAIN_LIST_DIR}/lib/posprintf/posprintf.h" DESTINATION "${GBA_TOOLCHAIN_LIST_DIR}/lib/posprintf/include")
        file(REMOVE "${GBA_TOOLCHAIN_LIST_DIR}/lib/posprintf/posprintf.h")

        file(COPY "${GBA_TOOLCHAIN_LIST_DIR}/cmake/PosprintfCMakeLists.cmake" DESTINATION "${GBA_TOOLCHAIN_LIST_DIR}/lib/posprintf")
        file(RENAME "${GBA_TOOLCHAIN_LIST_DIR}/lib/posprintf/PosprintfCMakeLists.cmake" "${GBA_TOOLCHAIN_LIST_DIR}/lib/posprintf/CMakeLists.txt")
    endif()
endfunction()

#! _gba_find_ext_maxmod : Locate and download Maxmod
#
function(_gba_find_ext_maxmod)
    if(NOT EXISTS "${GBA_TOOLCHAIN_LIST_DIR}/lib/maxmod/Makefile")
        if(NOT EXISTS "${GBA_TOOLCHAIN_LIST_DIR}/dependencies.ini")
            if(NOT DEPENDENCIES_URL)
                message(FATAL_ERROR "Missing DEPENDENCIES_URL")
            endif()

            file(DOWNLOAD "${DEPENDENCIES_URL}" "${GBA_TOOLCHAIN_LIST_DIR}/dependencies.ini" SHOW_PROGRESS)
        endif()

        file(READ "${GBA_TOOLCHAIN_LIST_DIR}/dependencies.ini" iniFile)
        _ini_read_section("${iniFile}" "maxmod" maxmod)

        message(STATUS "Downloading Maxmod from \"${maxmod_url}\" to \"${GBA_TOOLCHAIN_LIST_DIR}/lib/maxmod\"")
        _gba_download("${maxmod_url}" "${GBA_TOOLCHAIN_LIST_DIR}/lib/maxmod" SHOW_PROGRESS EXPECTED_MD5 "${maxmod_md5}")
    endif()

    if(EXISTS "${GBA_TOOLCHAIN_LIST_DIR}/lib/maxmod" AND NOT EXISTS "${GBA_TOOLCHAIN_LIST_DIR}/lib/maxmod/CMakeLists.txt")
        file(COPY "${GBA_TOOLCHAIN_LIST_DIR}/cmake/MaxmodCMakeLists.cmake" DESTINATION "${GBA_TOOLCHAIN_LIST_DIR}/lib/maxmod")
        file(RENAME "${GBA_TOOLCHAIN_LIST_DIR}/lib/maxmod/MaxmodCMakeLists.cmake" "${GBA_TOOLCHAIN_LIST_DIR}/lib/maxmod/CMakeLists.txt")
    endif()
endfunction()
