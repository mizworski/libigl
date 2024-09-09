if(TARGET glad::glad)
    return()
endif()

message(STATUS "Third-party: creating target 'glad::glad'")

include(FetchContent)
FetchContent_Declare(
    glad
    GIT_REPOSITORY https://github.com/libigl/libigl-glad.git
    GIT_TAG        ead2d21fd1d9f566d8f9a9ce99ddf85829258c7a
)

FetchContent_MakeAvailable(glad)
#FetchContent_GetProperties(glad)
#if(NOT glad_POPULATED)
#    FetchContent_Populate(glad)
#endif()

#add_library(glad::glad ALIAS glad)

#add_library(glad INTERFACE)
add_library(glad::glad ALIAS glad)

set_target_properties(glad PROPERTIES FOLDER ThirdParty)
target_include_directories(glad SYSTEM INTERFACE
        $<BUILD_INTERFACE:${glad_SOURCE_DIR}>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

set(CMAKE_INSTALL_DEFAULT_COMPONENT_NAME glad)
set_target_properties(glad PROPERTIES EXPORT_NAME glad)
install(DIRECTORY ${glad_SOURCE_DIR}/include DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(TARGETS glad EXPORT GladTargets)
install(EXPORT GladTargets DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/glad NAMESPACE glad::)
