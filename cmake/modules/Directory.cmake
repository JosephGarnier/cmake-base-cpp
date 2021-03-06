# Copyright 2019-present, Joseph Garnier
# All rights reserved.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.

#[=======================================================================[.rst:

Directory
---------
Operations to manipule directories. It requires CMake 3.16 or newer.

Synopsis
^^^^^^^^
.. parsed-literal::

    directory(`SCAN`_ <output_var> [LIST_DIRECTORIES <on|off>] RELATIVE <on|off> ROOT_DIR <directory_path> <INCLUDE_REGEX|EXCLUDE_REGEX> <regular_expression>)

Usage
^^^^^
.. _SCAN:
.. code-block:: cmake

  directory(SCAN <output_var> [LIST_DIRECTORIES <on|off>] RELATIVE <on|off> ROOT_DIR <directory_path> <INCLUDE_REGEX|EXCLUDE_REGEX> <regular_expression>)

Generate a list of files that match the ``<regular_expressions>`` and store
it into the ``<output_var>``. The results will be returned as absolute paths
to the given path ``<directory_path>`` if RELATIVE flag is set to off, else as
relative path to ROOT_DIR. By default the function list directories from result
list. Setting LIST_DIRECTORIES to off removes directories to result list.

#]=======================================================================]
cmake_minimum_required (VERSION 3.16)

#------------------------------------------------------------------------------
# Public function of this module.
function(directory)
	set(options "")
	set(one_value_args SCAN LIST_DIRECTORIES RELATIVE ROOT_DIR INCLUDE_REGEX EXCLUDE_REGEX)
	set(multi_value_args "")
	cmake_parse_arguments(DIR "${options}" "${one_value_args}" "${multi_value_args}" ${ARGN})
	
	if(DEFINED DIR_UNPARSED_ARGUMENTS)
		message(FATAL_ERROR "Unrecognized arguments: \"${DIR_UNPARSED_ARGUMENTS}\"")
	endif()

	if(DEFINED DIR_SCAN)
		directory_scan()
	else()
		message(FATAL_ERROR "Operation argument is missing")
	endif()
endfunction()

#------------------------------------------------------------------------------
# Internal usage.
macro(directory_scan)
	if(NOT DEFINED DIR_SCAN)
		message(FATAL_ERROR "SCAN arguments is missing")
	endif()
	if((DEFINED DIR_LIST_DIRECTORIES)
		AND	((NOT ${DIR_LIST_DIRECTORIES} STREQUAL "on")
		AND (NOT ${DIR_LIST_DIRECTORIES} STREQUAL "off")))
		message(FATAL_ERROR "LIST_DIRECTORIES arguments is wrong")
	endif()
	if((NOT DEFINED DIR_RELATIVE)
		OR ((NOT ${DIR_RELATIVE} STREQUAL "on")
		AND (NOT ${DIR_RELATIVE} STREQUAL "off")))
		message(FATAL_ERROR "RELATIVE arguments is wrong")
	endif()
	if(NOT DEFINED DIR_ROOT_DIR)
		message(FATAL_ERROR "ROOT_DIR arguments is missing")
	endif()
	if((NOT DEFINED DIR_INCLUDE_REGEX)
		AND (NOT DEFINED DIR_EXCLUDE_REGEX))
		message(FATAL_ERROR "INCLUDE_REGEX|EXCLUDE_REGEX arguments is missing")
	endif()

	set(file_list "")
	if(NOT DEFINED DIR_LIST_DIRECTORIES)
		set(DIR_LIST_DIRECTORIES on)
	endif()
	if(${DIR_RELATIVE})
		file(GLOB_RECURSE file_list FOLLOW_SYMLINKS LIST_DIRECTORIES ${DIR_LIST_DIRECTORIES} RELATIVE "${DIR_ROOT_DIR}" "${DIR_ROOT_DIR}/*")
	else()
		file(GLOB_RECURSE file_list FOLLOW_SYMLINKS LIST_DIRECTORIES ${DIR_LIST_DIRECTORIES} "${DIR_ROOT_DIR}/*")
	endif()
	
	if(DEFINED DIR_INCLUDE_REGEX)
		list(FILTER file_list INCLUDE REGEX "${DIR_INCLUDE_REGEX}")
	elseif(DEFINED DIR_EXCLUDE_REGEX)
		list(FILTER file_list EXCLUDE REGEX "${DIR_EXCLUDE_REGEX}")
	endif()
	
	set(${DIR_SCAN} "${file_list}" PARENT_SCOPE)
endmacro()