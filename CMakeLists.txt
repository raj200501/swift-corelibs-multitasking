cmake_minimum_required(VERSION 3.0)
project(Multitasking)

set(CMAKE_CXX_STANDARD 14)

include_directories(src/core)
include_directories(src/advanced_scheduling)
include_directories(src/swift_integration)
include_directories(tools/build)
include_directories(tools/deploy)
include_directories(tools/monitor)

add_subdirectory(src)
add_subdirectory(tests)

add_executable(multitasking src/main.cpp)
target_link_libraries(multitasking core advanced_scheduling swift_integration build deploy monitor)
