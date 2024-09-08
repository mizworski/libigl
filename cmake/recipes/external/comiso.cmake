# Comiso install should not be defined here. Instead,
# we should use CoMISo/CMakeLists.txt
if(TARGET CoMISo::CoMISo)
    message(STATUS "Comiso defined")
    return()
endif()

message(STATUS "Third-party: creating target 'CoMISo::CoMISo'")

include(FetchContent)
FetchContent_Declare(
    comiso
    GIT_REPOSITORY https://github.com/mizworski/CoMISo.git
    GIT_TAG f0bfd8d573a89e1918f21bae4b892c30e9cf7d91
)

include(eigen)

FetchContent_GetProperties(comiso)
#FetchContent_MakeAvailable(comiso)

if(NOT comiso_POPULATED)
    FetchContent_Populate(comiso)
endif()

add_library(CoMISo INTERFACE)
add_library(CoMISo::CoMISo ALIAS CoMISo)

target_include_directories(CoMISo SYSTEM INTERFACE
        $<BUILD_INTERFACE:${comiso_SOURCE_DIR}>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

# Copy .hh headers into a subfolder `CoMISo/`
#file(GLOB_RECURSE INC_FILES "${comiso_SOURCE_DIR}/*.hh" "${comiso_SOURCE_DIR}/*.cc")
#set(output_folder "${CMAKE_CURRENT_BINARY_DIR}/CoMISo/include/CoMISo")
#message(VERBOSE "Copying CoMISo headers to '${output_folder}'")
#foreach(filepath IN ITEMS ${INC_FILES})
#    file(RELATIVE_PATH filename "${comiso_SOURCE_DIR}" ${filepath})
#    configure_file(${filepath} "${output_folder}/${filename}" COPYONLY)
#endforeach()

#target_include_directories(CoMISo PUBLIC ${CMAKE_CURRENT_BINARY_DIR}/CoMISo/include)
#
#set_target_properties(CoMISo PROPERTIES FOLDER ThirdParty)

# Install rules
set(CMAKE_INSTALL_DEFAULT_COMPONENT_NAME comiso)
set_target_properties(CoMISo PROPERTIES EXPORT_NAME CoMISo)
install(DIRECTORY ${comiso_SOURCE_DIR}/CoMISo DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(TARGETS CoMISo EXPORT ComisoTargets)
install(EXPORT ComisoTargets DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/comiso NAMESPACE CoMISo::)
