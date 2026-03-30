CMake_Minimum_Required(VERSION 2.5...3.5)

project(muparsersse
        DESCRIPTION "muparsersse with cmake" VERSION 1.0.0
)
set(namespace mpsse)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

#set(CMAKE_CXX_COMPILER "/usr/bin/g++")
#set(CMAKE_C_COMPILER "/usr/bin/gcc")

set(CMAKE_CXX_STANDARD 11)

add_library(muparsersse)

set(SRCS 
src/mecCallback.cpp src/mecExprCompiler.cpp src/mecParser.cpp src/mecToken.cpp src/mecUnitTest.cpp 
src/mecError.cpp src/mecParserBase.cpp src/mecReversePolishNotation.cpp src/mecTokenReader.cpp src/muParserSSE.cpp  
)

target_compile_options(muparsersse PRIVATE
        -w -fdeclspec -fms-extensions)

target_sources(muparsersse
        PRIVATE ${SRCS}
        PRIVATE
                FILE_SET HEADERS
                BASE_DIRS include
)

include(FetchContent)

if(DEFINED CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    message(
        STATUS
        "CMAKE_INSTALL_PREFIX is not set\n"
        "Default value: ${CMAKE_INSTALL_PREFIX}\n"
        "Will set it to ${CMAKE_SOURCE_DIR}/install"
    )
    set(CMAKE_INSTALL_PREFIX
        "${CMAKE_SOURCE_DIR}/install"
        CACHE PATH "Where the library will be installed to" FORCE
    )
else()
    message(
        STATUS
        "CMAKE_INSTALL_PREFIX was already set\n"
        "Current value: ${CMAKE_INSTALL_PREFIX}"
    )
endif()

set(public_headers
    include/muParserSSE.hpp
)
# note that ${public_headers} has to be in quotes
set_target_properties(${PROJECT_NAME} PROPERTIES PUBLIC_HEADER "${public_headers}")

include(GNUInstallDirs)

install(TARGETS ${PROJECT_NAME}
    EXPORT "${PROJECT_NAME}Targets"
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME} 
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(EXPORT "${PROJECT_NAME}Targets"
    FILE "${PROJECT_NAME}Targets.cmake"
    NAMESPACE ${namespace}::
    DESTINATION cmake
)

include(CMakePackageConfigHelpers)

# generate the version file for the config file
write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
    VERSION "${version}"
    COMPATIBILITY AnyNewerVersion
)
# create config file
configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/Config.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
    INSTALL_DESTINATION cmake
)
# install config files
install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
    DESTINATION cmake
)

set(ASMJIT_DIR "asmjit/")              # Location of AsmJit.
add_subdirectory("${ASMJIT_DIR}")              # Adds AsmJit sub-project to your project.
set(DASMJIT_BUILD_LIBRARY, 1)
target_link_libraries(muparsersse PRIVATE AsmJit)      # Adds AsmJit as a dependency to app.
