# Copyright 2019-present, Joseph Garnier
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.

# CMAKE_SYSTEM_NAME - on unix use command `uname -s`, for windows write `Windows` OR use command `cmake --system-information`.
set(CMAKE_SYSTEM_NAME Linux)
# CMAKE_SYSTEM_VERSION - on unix use command `uname -r`, for windows use command `cmake --system-information`.
set(CMAKE_SYSTEM_VERSION 4.4.0-21-generic)
# CMAKE_SYSTEM - see https://cmake.org/cmake/help/latest/variable/CMAKE_SYSTEM.html.
set(CMAKE_SYSTEM "${CMAKE_SYSTEM_NAME}-${CMAKE_SYSTEM_VERSION}")

# Write `clang++ --version` in a terminal.
set(triple x86_64-pc-linux-gnu)

# Specify the cross compiler.
set(CMAKE_C_COMPILER clang)
set(CMAKE_C_COMPILER_TARGET ${triple})
set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_CXX_COMPILER_TARGET ${triple})

# Where is the target environment.
list(APPEND CMAKE_FIND_ROOT_PATH "${${PROJECT_NAME}_PROJECT_DIR}")

# Search for programs in the build host directories.
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
# For libraries and headers in the target directories.
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE BOTH)

# Compile flags.
add_compile_options("$<$<STREQUAL:${PARAM_BUILD_TYPE},debug>:-g>")
add_compile_options("$<$<STREQUAL:${PARAM_BUILD_TYPE},debug>:-ggdb3>")
add_compile_options("$<$<STREQUAL:${PARAM_BUILD_TYPE},debug>:-fdebug-macro>")
add_compile_options("$<$<STREQUAL:${PARAM_BUILD_TYPE},debug>:-Wall>")
add_compile_options("$<$<STREQUAL:${PARAM_BUILD_TYPE},debug>:-Wextra>")
add_compile_options("$<$<STREQUAL:${PARAM_BUILD_TYPE},debug>:-fstandalone-debug>")
add_compile_options("$<$<STREQUAL:${PARAM_BUILD_TYPE},debug>:-stdlib=libc++>")
