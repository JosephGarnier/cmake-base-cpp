# Copyright 2019-present, Joseph Garnier
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.

# -DPROJECT_NAME: specifies a name for project
# -DPROJECT_SUMMARY: short description of the project
# -DPROJECT_VENDOR_NAME: project author
# -DPROJECT_VENDOR_CONTACT: author contact
# -DPROJECT_VERSION_MAJOR: project major version
# -DPROJECT_VERSION_MINOR: project minor version
# -DPROJECT_VERSION_PATCH: project patch version
# -DGENERATOR: see https://cmake.org/cmake/help/latest/manual/cmake-generators.7.html
# -DBUILD_TYPE=[(default) debug|release]: set type of build
# -DDEBUG_OPT_LVL=[(default) low|high]: set level of debug
# -DASSERT_ENABLE=[ON|OFF (default)]: enable or disable assert
# -DBUILD_SHARED_LIBS=[(default) ON|OFF]: build shared libraries instead of static
# -DBUILD_MAIN=[(default) ON|OFF]: build the main-function
# -DBUILD_TESTS=[ON|OFF (default)]: build tests
# -DBUILD_DOXYGEN_DOCS=[ON|OFF (default)]: build documentation

cmake_minimum_required (VERSION 3.12)

# -------------------- Options --------------------------------

set(PROJECT_NAME_DESC			"Specifies a name for project")
set(PROJECT_SUMMARY_DESC		"Short description of the project")
set(PROJECT_VENDOR_NAME_DESC	"Project author")
set(PROJECT_VENDOR_CONTACT_DESC	"Author contact")
set(PROJECT_VERSION_MAJOR_DESC	"Project major version")
set(PROJECT_VERSION_MINOR_DESC	"Project minor version")
set(PROJECT_VERSION_PATCH_DESC	"Project patch version")
set(GENERATOR_DESC				"Specifies CMake Generator, see https://cmake.org/cmake/help/latest/manual/cmake-generators.7.html")
set(BUILD_TYPE_DESC				"Specifies type of build, \"debug\" or \"release\"")
set(DEBUG_OPT_LVL_DESC			"Specifies level of debug \"low\" or \"high\"")
set(ASSERT_ENABLE_DESC			"Specifies whether to use assert")
set(BUILD_SHARED_LIBS_DESC		"Specifies whether build shared libraries instead of static")
set(BUILD_MAIN_DESC				"Specifies whether build the main-function")
set(BUILD_TESTS_DESC			"Specifies whether build tests")
set(BUILD_DOXYGEN_DOCS_DESC		"Specifies whether build documentation")

set(PARAM_PROJECT_NAME			"project-name"		CACHE	STRING	"${PROJECT_NAME_DESC}")
set(PARAM_PROJECT_SUMMARY		"description"		CACHE	STRING	"${PROJECT_SUMMARY_DESC}")
set(PARAM_PROJECT_VENDOR_NAME	"your-name"			CACHE	STRING	"${PROJECT_VENDOR_NAME_DESC}")
set(PARAM_PROJECT_VENDOR_CONTACT"contact"			CACHE	STRING	"${PROJECT_VENDOR_CONTACT_DESC}")
set(PARAM_PROJECT_VERSION_MAJOR	"0"					CACHE	STRING	"${PROJECT_VERSION_MAJOR_DESC}")
set(PARAM_PROJECT_VERSION_MINOR	"0"					CACHE	STRING	"${PROJECT_VERSION_MINOR_DESC}")
set(PARAM_PROJECT_VERSION_PATCH	"0"					CACHE	STRING	"${PROJECT_VERSION_PATCH_DESC}")
set(PARAM_GENERATOR				"Unix Makefiles"	CACHE	STRING	"${GENERATOR_DESC}")
set(PARAM_BUILD_TYPE			"debug"				CACHE	STRING	"${BUILD_TYPE_DESC}")
set(PARAM_DEBUG_OPT_LVL			"low"				CACHE	STRING	"${DEBUG_OPT_LVL_DESC}")
set(PARAM_ASSERT_ENABLE			OFF					CACHE	BOOL	"${ASSERT_ENABLE_DESC}")
set(PARAM_BUILD_SHARED_LIBS		OFF					CACHE	BOOL	"${BUILD_SHARED_LIBS_DESC}")
set(PARAM_BUILD_MAIN			ON					CACHE	BOOL	"${BUILD_MAIN_DESC}")
set(PARAM_BUILD_TESTS			OFF					CACHE	BOOL	"${BUILD_TESTS_DESC}")
set(PARAM_BUILD_DOXYGEN_DOCS	OFF					CACHE	BOOL	"${BUILD_DOXYGEN_DOCS_DESC}")

message("=============================================")
message("      Build project ${PARAM_PROJECT_NAME}    ")
message("=============================================")

message("Summary of your options:")
message(" - Project name: \"${PARAM_PROJECT_NAME}\"")
message(" - Project description: \"${PARAM_PROJECT_SUMMARY}\"")
message(" - Project author: \"${PARAM_PROJECT_VENDOR_NAME}\"")
message(" - Author contact: \"${PARAM_PROJECT_VENDOR_CONTACT}\"")
message(" - Project major version: \"${PARAM_PROJECT_VERSION_MAJOR}\"")
message(" - Project minor version: \"${PARAM_PROJECT_VERSION_MINOR}\"")
message(" - Project patch version: \"${PARAM_PROJECT_VERSION_PATCH}\"")
message(" - Generator: \"${PARAM_GENERATOR}\"")
message(" - Build type: \"${PARAM_BUILD_TYPE}\"")
message(" - Debug option level: \"${PARAM_DEBUG_OPT_LVL}\"")
message(" - Assert is enable: \"${PARAM_ASSERT_ENABLE}\"")
message(" - Build shared libs: \"${PARAM_BUILD_SHARED_LIBS}\"")
message(" - Build main: \"${PARAM_BUILD_MAIN}\"")
message(" - Build tests: \"${PARAM_BUILD_TESTS}\"")
message(" - Build doxygen documentation: \"${PARAM_BUILD_DOXYGEN_DOCS}\"")
message("")

# -------------------- Check Options --------------------------

message("== Check options ==")

# Check if project name has been specified correctly.
if(NOT DEFINED PARAM_PROJECT_NAME)
	message(FATAL_ERROR "Project name must be specified!")
endif()
if("${PARAM_PROJECT_NAME}" MATCHES " ")
	message(FATAL_ERROR "Project name cannot contain spaces!")
endif()

# If present and true, this will cause all libraries to be built shared unless the library was explicitly added as a static library.
set(BUILD_SHARED_LIBS ${PARAM_BUILD_SHARED_LIBS})

# Set CMake build-type. If it not supplied by the user, the default built type is "Release".
if((NOT DEFINED PARAM_BUILD_TYPE) OR ("${PARAM_BUILD_TYPE}" STREQUAL "Release"))
	message(STATUS "Building release version!")
	set(CMAKE_BUILD_TYPE Release)
elseif("${PARAM_BUILD_TYPE}" STREQUAL "Debug")
	message(STATUS "Building debug version!")
	set(CMAKE_BUILD_TYPE Debug)
endif()

# Set platform-specific compiler flags.
if((NOT DEFINED PARAM_DEBUG_OPT_LVL) OR ((NOT "${PARAM_DEBUG_OPT_LVL}" STREQUAL "low") AND (NOT "${PARAM_DEBUG_OPT_LVL}" STREQUAL "high")))
	message(FATAL_ERROR "DEBUG_OPT_LVL must be low or high!")
endif()

# -------------------- Project settings ------------------------------

message("\n== Project settings ==")

project(${PARAM_PROJECT_NAME} CXX)
set(${PROJECT_NAME}_SUMMARY			"${PARAM_PROJECT_SUMMARY}")
set(${PROJECT_NAME}_VENDOR_NAME		"${PARAM_PROJECT_VENDOR_NAME}")
set(${PROJECT_NAME}_VENDOR_CONTACT	"${PARAM_PROJECT_VENDOR_CONTACT}")
set(${PROJECT_NAME}_VERSION_MAJOR	"${PARAM_PROJECT_VERSION_MAJOR}")
set(${PROJECT_NAME}_VERSION_MINOR	"${PARAM_PROJECT_VERSION_MINOR}")
set(${PROJECT_NAME}_VERSION_PATCH	"${PARAM_PROJECT_VERSION_PATCH}")
set(${PROJECT_NAME}_VERSION			"${${PROJECT_NAME}_VERSION_MAJOR}.${${PROJECT_NAME}_VERSION_MINOR}.${${PROJECT_NAME}_VERSION_PATCH}")

message(STATUS "Configure ${PROJECT_NAME}_VERSION at ${${PROJECT_NAME}_VERSION}")

# -------------------- Check project structure ----------------

message("\n== Check project structure ==")
set(${PROJECT_NAME}_PROJECT_PATH							"${CMAKE_CURRENT_SOURCE_DIR}")
set(${PROJECT_NAME}_ASSETS_PATH								"${${PROJECT_NAME}_PROJECT_PATH}/assets")
set(${PROJECT_NAME}_BIN_PATH                                "${${PROJECT_NAME}_PROJECT_PATH}/bin")
set(${PROJECT_NAME}_BUILD_PATH                              "${${PROJECT_NAME}_PROJECT_PATH}/build")
set(${PROJECT_NAME}_CMAKE_PATH                              "${${PROJECT_NAME}_PROJECT_PATH}/cmake")
set(${PROJECT_NAME}_CMAKE_HELPERS_PATH                      "${${PROJECT_NAME}_CMAKE_PATH}/helpers")
set(${PROJECT_NAME}_CMAKE_MODULES_PATH                      "${${PROJECT_NAME}_CMAKE_PATH}/modules")
set(${PROJECT_NAME}_CMAKE_PROJECT_PATH                      "${${PROJECT_NAME}_CMAKE_PATH}/project")
set(${PROJECT_NAME}_CMAKE_TOOLCHAINS_PATH                   "${${PROJECT_NAME}_CMAKE_PATH}/toolchains")
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH}
	"${${PROJECT_NAME}_CMAKE_HELPERS_PATH}"
	"${${PROJECT_NAME}_CMAKE_MODULES_PATH}"
	"${${PROJECT_NAME}_CMAKE_PROJECT_PATH}"
	"${${PROJECT_NAME}_CMAKE_TOOLCHAINS_PATH}")
set(${PROJECT_NAME}_CONFIG_PATH								"${${PROJECT_NAME}_PROJECT_PATH}/config")
set(${PROJECT_NAME}_DOC_PATH								"${${PROJECT_NAME}_PROJECT_PATH}/doc")
set(${PROJECT_NAME}_INCLUDE_PATH							"${${PROJECT_NAME}_PROJECT_PATH}/include")
set(${PROJECT_NAME}_LIB_PATH								"${${PROJECT_NAME}_PROJECT_PATH}/lib")
set(${PROJECT_NAME}_LIB_NAME								"lib${PROJECT_NAME}")
set(${PROJECT_NAME}_MAIN_NAME								"${PROJECT_NAME}")
set(${PROJECT_NAME}_PACKAGE_NAME							"${PROJECT_NAME}")
set(${PROJECT_NAME}_RESOURCES_PATH							"${${PROJECT_NAME}_PROJECT_PATH}/resources")
set(${PROJECT_NAME}_SRC_PATH								"${${PROJECT_NAME}_PROJECT_PATH}/src")
set(${PROJECT_NAME}_TEST_PATH								"${${PROJECT_NAME}_PROJECT_PATH}/tests")
set(${PROJECT_NAME}_TEST_NAME								"${PROJECT_NAME}_test")

list(APPEND ${PROJECT_NAME}_PROJECT_PATHS
	"${${PROJECT_NAME}_ASSETS_PATH}"
	"${${PROJECT_NAME}_BIN_PATH}"
	"${${PROJECT_NAME}_BUILD_PATH}"
	"${${PROJECT_NAME}_CMAKE_PATH}"
	"${${PROJECT_NAME}_CMAKE_HELPERS_PATH}"
	"${${PROJECT_NAME}_CMAKE_MODULES_PATH}"
	"${${PROJECT_NAME}_CMAKE_PROJECT_PATH}"
	"${${PROJECT_NAME}_CMAKE_TOOLCHAINS_PATH}"
	"${${PROJECT_NAME}_CONFIG_PATH}"
	"${${PROJECT_NAME}_DOC_PATH}"
	"${${PROJECT_NAME}_INCLUDE_PATH}"
	"${${PROJECT_NAME}_LIB_PATH}"
	"${${PROJECT_NAME}_RESOURCES_PATH}"
	"${${PROJECT_NAME}_SRC_PATH}"
	"${${PROJECT_NAME}_TEST_PATH}")

foreach(folder ${${PROJECT_NAME}_PROJECT_PATHS})
	if((NOT EXISTS "${folder}") OR (NOT IS_DIRECTORY "${folder}"))
		#message(FATAL_ERROR "missing folder: \"${folder}\"")
	endif()
endforeach()

# -------------------- Detect the system ---------------------------

if(NOT CMAKE_SYSTEM_PROCESSOR)
	set(CMAKE_SYSTEM_PROCESSOR ${CMAKE_HOST_SYSTEM_PROCESSOR})
endif()

set(SYSTEM_NAME "${CMAKE_SYSTEM_NAME}-${CMAKE_CXX_COMPILER_ID}-${CMAKE_SYSTEM_PROCESSOR}")
set(${PROJECT_NAME}_LIB_NAME "${${PROJECT_NAME}_LIB_NAME}")
set(${PROJECT_NAME}_MAIN_NAME "${${PROJECT_NAME}_MAIN_NAME}")
set(${PROJECT_NAME}_PACKAGE_NAME "${${PROJECT_NAME}_PACKAGE_NAME}-${CMAKE_SYSTEM_NAME}-${CMAKE_CXX_COMPILER_ID}-${CMAKE_SYSTEM_PROCESSOR}")
set(${PROJECT_NAME}_TEST_NAME "${${PROJECT_NAME}_TEST_NAME}-${CMAKE_SYSTEM_NAME}-${CMAKE_CXX_COMPILER_ID}-${CMAKE_SYSTEM_PROCESSOR}")

# -------------------- Build settings ------------------------------

message("\n== Build settings ==")

# Force to use c++ 14
set (CMAKE_CXX_STANDARD 14)

if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
	if("${${PROJECT_NAME}_DEBUG_OPT_LVL}" STREQUAL "low")
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /Zm200")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /Zi")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MP")

		# c++ (code generation)
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /EHsc")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MDd")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /Gy")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /Qpar")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /fp:fast")
		STRING(REGEX REPLACE "/RTC(su|[1su])" "" CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG}")

		# c++ (optimization)
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /Od")

		# linker
		set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG}		/INCREMENTAL")
		set(CMAKE_SHARED_LINKER_FLAGS_DEBUG "${CMAKE_SHARED_LINKER_FLAGS_DEBUG}	/INCREMENTAL")
		set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG}		/DEBUG")
		set(CMAKE_SHARED_LINKER_FLAGS_DEBUG "${CMAKE_SHARED_LINKER_FLAGS_DEBUG}	/DEBUG")
	elseif("${${PROJECT_NAME}_DEBUG_OPT_LVL}" STREQUAL "high")
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /Zm200")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /Zi")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MP")

		# c++ (code generation)
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /EHsc")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MDd")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /Gy")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /Qpar")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /fp:fast")
		STRING(REGEX REPLACE "/RTC(su|[1su])" "" CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG}")

		# c++ (optimization)
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /O2")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /Ob2")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /Oi")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /Oy")
		#set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /GL") # disable /ZI to use it

		# linker
		set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG}			/INCREMENTAL")
		set(CMAKE_SHARED_LINKER_FLAGS_DEBUG "${CMAKE_SHARED_LINKER_FLAGS_DEBUG}		/INCREMENTAL")
		set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG}			/DEBUG")
		set(CMAKE_SHARED_LINKER_FLAGS_DEBUG "${CMAKE_SHARED_LINKER_FLAGS_DEBUG}		/DEBUG")
		#set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG}			/OPT:REF") # disable /ZI to use it
		#set(CMAKE_SHARED_LINKER_FLAGS_DEBUG "${CMAKE_SHARED_LINKER_FLAGS_DEBUG}	/OPT:REF") # disable /ZI to use it
		#set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG}			/OPT:NOICF") # disable /ZI to use it
		#set(CMAKE_SHARED_LINKER_FLAGS_DEBUG "${CMAKE_SHARED_LINKER_FLAGS_DEBUG}	/OPT:NOICF") # disable /ZI to use it
		#set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG}			/LTCG:incremental") # disable /ZI to use it
		#set(CMAKE_SHARED_LINKER_FLAGS_DEBUG "${CMAKE_SHARED_LINKER_FLAGS_DEBUG}	/LTCG:incremental") # disable /ZI to use it
	endif()
elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
	set(CMAKE_CXX_FLAGS_DEBUG   "-O0 -g3")
    set(CMAKE_CXX_FLAGS_RELEASE "-O3")
elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
else()
	message(FATAL_ERROR "Unsupported compiler!")
endif()

# -------------------- Build dependances ----------------------

message("\n== Build dependances ==")
include(Dependencies) # set ${PROJECT_NAME}_LIBRARIES_FILES

# -------------------- Build project --------------------------

message("\n== Build project ==")
include(Cotire)
include(ProjectSrcFiles)
if(NOT DEFINED ${PROJECT_NAME}_PRECOMPILED_HEADER_PATH)
	message(FATAL_ERROR "${PROJECT_NAME}_PRECOMPILED_HEADER_PATH must be specified!")
endif()
if(NOT DEFINED ${PROJECT_NAME}_PRECOMPILED_SOURCE_PATH)
	message(FATAL_ERROR "${PROJECT_NAME}_PRECOMPILED_SOURCE_PATH must be specified!")
endif()
if(NOT DEFINED ${PROJECT_NAME}_SRC_FILES)
	message(FATAL_ERROR "${PROJECT_NAME}_SRC_FILES must be specified!")
endif()
if(NOT DEFINED ${PROJECT_NAME}_HEADER_FILES)
	message(FATAL_ERROR "${PROJECT_NAME}_HEADER_FILES must be specified!")
endif()
include_directories(AFTER "${${PROJECT_NAME}_SRC_PATH}")
include_directories(AFTER "${${PROJECT_NAME}_INCLUDE_PATH}")

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${${PROJECT_NAME}_BIN_PATH})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${${PROJECT_NAME}_BIN_PATH})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${${PROJECT_NAME}_BIN_PATH})
set(CMAKE_STATIC_LIBRARY_PREFIX "")
set(CMAKE_SHARED_LIBRARY_PREFIX "")

# Build library
if(${BUILD_SHARED_LIBS})
	message(STATUS "Build as a shared library")
	add_library("${${PROJECT_NAME}_LIB_NAME}" SHARED ${${PROJECT_NAME}_SRC_FILES})
else()
	message(STATUS "Build as a static library")
	add_library("${${PROJECT_NAME}_LIB_NAME}" STATIC ${${PROJECT_NAME}_SRC_FILES})
endif()

# Add a precompiled header file if existing
if(${PROJECT_NAME}_PRECOMPILED_HEADER_PATH)
	message(STATUS "Add a precompiled header file for library")
	set_target_properties("${${PROJECT_NAME}_LIB_NAME}" PROPERTIES COTIRE_CXX_PREFIX_HEADER_INIT "${${PROJECT_NAME}_PRECOMPILED_HEADER_PATH}")
endif()
cotire("${${PROJECT_NAME}_LIB_NAME}")

# Build executable
if(${PARAM_BUILD_MAIN})
	message(STATUS "Build main")
	add_executable("${${PROJECT_NAME}_MAIN_NAME}" ${${PROJECT_NAME}_SRC_FILES})
	target_link_libraries("${${PROJECT_NAME}_MAIN_NAME}" ${${PROJECT_NAME}_LIBRARIES_FILES})
	if(${PROJECT_NAME}_PRECOMPILED_HEADER_PATH)
		message(STATUS "Add a precompiled header file for executable")
		set_target_properties("${${PROJECT_NAME}_MAIN_NAME}" PROPERTIES COTIRE_CXX_PREFIX_HEADER_INIT "${${PROJECT_NAME}_PRECOMPILED_HEADER_PATH}")
	endif()
	cotire("${${PROJECT_NAME}_MAIN_NAME}")
endif()

# -------------------- Documentation --------------------------

if(${PARAM_BUILD_DOXYGEN_DOCS})
	message("\n== Build documentation ==")
	find_package(Doxygen REQUIRED)
	if(NOT DOXYGEN_FOUND)
		message(FATAL_ERROR "Doxygen is needed to build the documentation. Please make sure it is installed.")
	endif()

	# set input and output files
	set(DOXYGEN_IN "${${PROJECT_NAME}_DOC_PATH}/Doxyfile.in")
	set(DOXYGEN_OUT "${${PROJECT_NAME}_DOC_PATH}/Doxyfile")

	# request to configure the file
	configure_file(${DOXYGEN_IN} ${DOXYGEN_OUT} @ONLY)
	message(STATUS "Doxygen build started")

	# note the option ALL which allows to build the docs together with the application
	add_custom_target(doxygen_docs ALL
		COMMAND ${DOXYGEN_EXECUTABLE} "${DOXYGEN_OUT}"
		SOURCES "${DOXYGEN_OUT}"
		WORKING_DIRECTORY "${${PROJECT_NAME}_DOC_PATH}"
		COMMENT "Generating API documentation with Doxygen"
		VERBATIM)
endif()

# -------------------- Testing --------------------------

if(${PARAM_BUILD_TESTS})
	message("\n== Build tests ==")
	include(CTest)
	add_test(NAME "${${PROJECT_NAME}_TEST_NAME}"
		WORKING_DIRECTORY "${${PROJECT_NAME}_TEST_PATH}"
		COMMAND "${${PROJECT_NAME}_TEST_PATH}/${${PROJECT_NAME}_TEST_NAME}")
endif()

# -------------------- Make install/uninstall rules --------------------------

message("\n== Generates make install/uninstall rules ==")
# destination is set by CMAKE_INSTALL_PREFIX and defaults to usual locations, unless overridden by user
install(DIRECTORY ${${PROJECT_NAME}_SRC_PATH} ${${PROJECT_NAME}_INCLUDE_PATH}
	DESTINATION include
	FILES_MATCHING PATTERN "*.h")
install(TARGETS ${${PROJECT_NAME}_LIB_NAME} DESTINATION lib)
install(TARGETS ${${PROJECT_NAME}_MAIN_NAME} DESTINATION bin)

if(NOT TARGET uninstall)
	configure_file(
		"${${PROJECT_NAME}_CMAKE_HELPERS_PATH}/Uninstall.cmake.in"
		"${CMAKE_CURRENT_BINARY_DIR}/Uninstall.cmake"
		IMMEDIATE @ONLY)

	add_custom_target(uninstall
		COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/Uninstall.cmake)
endif()

# -------------------- Packager --------------------------

message("\n== Pack project ==")
set(CPACK_SYSTEM_NAME					"${SYSTEM_NAME}")
set(CPACK_TOPLEVEL_TAG					"${SYSTEM_NAME}")
set(CPACK_PACKAGE_NAME					"${${PROJECT_NAME}_PACKAGE_NAME}")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY	"${${PROJECT_NAME}_SUMMARY}")
set(CPACK_PACKAGE_VENDOR				"${${PROJECT_NAME}_VENDOR_NAME}")
set(CPACK_PACKAGE_DESCRIPTION_FILE		"${${PROJECT_NAME}_PROJECT_PATH}/README.md")
set(CPACK_RESOURCE_FILE_LICENSE			"${${PROJECT_NAME}_PROJECT_PATH}/LICENSE.md")
set(CPACK_PACKAGE_VERSION_MAJOR			"${${PROJECT_NAME}_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR			"${${PROJECT_NAME}_VERSION_MINOR}")
set(CPACK_PACKAGE_VERSION_PATCH			"${${PROJECT_NAME}_VERSION_PATCH}")
set(CPACK_PACKAGE_FILE_NAME				"${${PROJECT_NAME}_PACKAGE_NAME}")
set(CPACK_SOURCE_PACKAGE_FILE_NAME 		"${${PROJECT_NAME}_PACKAGE_NAME}-source")
set(CPACK_PACKAGE_INSTALL_DIRECTORY		"${${PROJECT_NAME}_BIN_PATH}")
set(CPACK_SOURCE_IGNORE_FILES 			"")

if( WIN32 )
	set(CPACK_GENERATOR			"NSIS")
	set(CPACK_SOURCE_GENERATOR	"NSIS")
	set(CPACK_NSIS_DISPLAY_NAME "${CPACK_PACKAGE_NAME}")
	set(CPACK_NSIS_CONTACT		"${${PROJECT_NAME}_VENDOR_CONTACT}")
	set(CPACK_NSIS_MODIFY_PATH	ON)
elseif( UNIX )
	set(CPACK_GENERATOR			"ZIP")
	set(CPACK_SOURCE_GENERATOR	"ZIP")
elseif( APPLE )
	set(CPACK_GENERATOR			"ZIP")
	set(CPACK_SOURCE_GENERATOR	"ZIP")
endif()
include( CPack )

message("\n===== End project ${PROJECT_NAME} building =====\n")