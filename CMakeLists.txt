cmake_minimum_required(VERSION 3.6)
set(wrench_module file)
project(module_${wrench_module})

# This is the plugin to be loaded with dlopen
add_library(module_${wrench_module} SHARED ${CMAKE_CURRENT_SOURCE_DIR}/src/${wrench_module}.c)
set_target_properties(module_${wrench_module} PROPERTIES PREFIX "")
set_target_properties(module_${wrench_module} PROPERTIES OUTPUT_NAME "${wrench_module}")
target_link_libraries(module_${wrench_module} PUBLIC wren_runtime)

# This is the static module to be included in the runtime host
add_library(module_${wrench_module}_static STATIC ${CMAKE_CURRENT_SOURCE_DIR}/src/${wrench_module}.c)
target_link_libraries(module_${wrench_module}_static PUBLIC wren_runtime)

# Copy script file to binary folder
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/wren/${wrench_module}.wren ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${wrench_module}.wren COPYONLY)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/wren/${wrench_module}.spec.wren ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/../tests/${wrench_module}.spec.wren COPYONLY)

