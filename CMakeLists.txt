CMake_Minimum_Required(VERSION 2.5...3.5)

project(muparsersse
        DESCRIPTION "muparsersse with cmake" VERSION 1.0.0
)

set(namespace mpsse)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

#set(CMAKE_CXX_COMPILER "/usr/bin/g++")
#set(CMAKE_C_COMPILER "/usr/bin/gcc")

set(CMAKE_DEBUG_POSTFIX d)
add_library(muparsersse)
add_library(${namespace}::muparsersse ALIAS muparsersse)

set_target_properties(muparsersse 
        PROPERTIES VERSION ${PROJECT_VERSION} 
        SOVERSION ${PROJECT_VERSION_MAJOR})

set(SRCS 
src/AssemblerX86X64.cpp  src/LoggerX86X64.cpp      src/mecParser.cpp                 src/muParserSSE.cpp
src/CompilerX86X64.cpp   src/LoggerX86X64Dump.cpp  src/mecReversePolishNotation.cpp  src/SerializerX86X64.cpp
src/CpuInfo.cpp          src/mecCallback.cpp       src/mecToken.cpp                  src/Util.cpp
src/Defs.cpp             src/mecError.cpp          src/mecTokenReader.cpp            src/VirtualMemory.cpp
src/Lock.cpp             src/mecExprCompiler.cpp   src/mecUnitTest.cpp
src/Logger.cpp           src/mecParserBase.cpp     src/MemoryManager.cpp  
)

target_compile_options(muparsersse PRIVATE
        -w -fdeclspec -fms-extensions)


target_sources(muparsersse
        PRIVATE ${SRCS}
        PRIVATE
                FILE_SET HEADERS
                BASE_DIRS include
)
target_include_directories(muparsersse PRIVATE src 
        PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}}>
)

include(GenerateExportHeader)

generate_export_header(
    muparsersse 
    EXPORT_FILE_NAME
    export/muparsersse/muParserSSE.hpp
)

target_include_directories(muparsersse PRIVATE src 
        PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/export>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}}>
)

install(
        TARGETS muparsersse
        EXPORT muparsersseTargets
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

install(
        FILES "${CMAKE_CURRENT_BINARY_DIR}/export/muparsersse/muParserSSE.hpp"
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/muparsersse
)

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
        "muParserSSEConfigVersion.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion)

configure_package_config_file(
        "${CMAKE_CURRENT_LIST_DIR}/cmake/muParserSSEConfig.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/muParserSSEConfig.cmake"
    INSTALL_DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/cmake/muparsersse
)

# install the CMake targets
install(
        EXPORT muparsersseTargets
        FILE muparsersseTargets.cmake
        NAMESPACE mpsse::
    DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/cmake/muparsersse
)

# Define variables for the pkg-config file
set(PACKAGE_NAME muparsersse)
if(ENABLE_WIDE_CHAR)
  set(PKG_CONFIG_FLAGS "-D_UNICODE")
endif(ENABLE_WIDE_CHAR)
configure_file(
    muparsersse.pc.in
    ${CMAKE_BINARY_DIR}/muparsersse.pc
    @ONLY
)
install(
    FILES ${CMAKE_BINARY_DIR}/muparsersse.pc
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
)
