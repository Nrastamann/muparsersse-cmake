#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "mpsse::muparsersse" for configuration "Release"
set_property(TARGET mpsse::muparsersse APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(mpsse::muparsersse PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libmuparsersse.a"
  )

list(APPEND _cmake_import_check_targets mpsse::muparsersse )
list(APPEND _cmake_import_check_files_for_mpsse::muparsersse "${_IMPORT_PREFIX}/lib/libmuparsersse.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
