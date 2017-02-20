
project(3DUIExample)

cmake_minimum_required (VERSION 2.8.2) 
SET(CMAKE_MODULE_PATH  ${CMAKE_CURRENT_SOURCE_DIR}/cmake ${CMAKE_MODULE_PATH} )

#---------------------- Source Files ----------------------

set(source_files
  main.cpp
  QuickShapes.cpp
  UIExample.cpp
)

set(header_files
  QuickShapes.h
  UIExample.h
)


set(extra_files
  CMakeLists-ExternalProj-GLM.txt
  README.md
)


set_source_files_properties(${extra_files} PROPERTIES HEADER_FILE_ONLY TRUE)


#---------------------- Dependencies ----------------------

find_package(OpenGL REQUIRED)
find_package(MinVR REQUIRED)

find_package(glm)
if (NOT ${glm_FOUND})
  message(STATUS "Package not found (glm): Ok, will download into 3rdparty directory when building ${PROJECT_NAME}")
  include(CMakeLists-ExternalProj-GLM.txt)
endif (NOT ${glm_FOUND})


include_directories(
	${OPENGL_INCLUDE_DIR}
	${MinVR_INCLUDE_DIR}
  ${glm_INCLUDE_DIR}
)

#---------------------- Build Directory Setup ----------------------

# Let's follow the convention of putting all of the libs in "build/lib" and all
# of the exes in "build/bin".  To distingusih between debugging, release, and
# other builds, we'll add a postfix to the name of the lib or exe that we generate.

if(NOT CMAKE_DEBUG_POSTFIX)
  set(CMAKE_DEBUG_POSTFIX "d")
endif()
set(CMAKE_RELEASE_POSTFIX "")
set(CMAKE_RELWITHDEBINFO_POSTFIX "rd")
set(CMAKE_MINSIZEREL_POSTFIX "s")

if (CMAKE_BUILD_TYPE MATCHES "Release")
  set(CMAKE_BUILD_POSTFIX "${CMAKE_RELEASE_POSTFIX}")
elseif (CMAKE_BUILD_TYPE MATCHES "MinSizeRel")
  set(CMAKE_BUILD_POSTFIX "${CMAKE_MINSIZEREL_POSTFIX}")
elseif (CMAKE_BUILD_TYPE MATCHES "RelWithDebInfo")
  set(CMAKE_BUILD_POSTFIX "${CMAKE_RELWITHDEBINFO_POSTFIX}")
elseif (CMAKE_BUILD_TYPE MATCHES "Debug")
  set(CMAKE_BUILD_POSTFIX "${CMAKE_DEBUG_POSTFIX}")
else()
  set(CMAKE_BUILD_POSTFIX "")
endif()

set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -DMinVR_DEBUG")
add_definitions(-DINSTALLPATH="${CMAKE_INSTALL_PREFIX}")

make_directory(${CMAKE_BINARY_DIR}/lib)
make_directory(${CMAKE_BINARY_DIR}/bin)
set (CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set (CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set (CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
foreach (CONF ${CMAKE_CONFIGURATION_TYPES})
  string (TOUPPER ${CONF} CONF)
  set (CMAKE_RUNTIME_OUTPUT_DIRECTORY_${CONF} ${CMAKE_BINARY_DIR}/bin)
  set (CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${CONF} ${CMAKE_BINARY_DIR}/lib)
  set (CMAKE_LIBRARY_OUTPUT_DIRECTORY_${CONF} ${CMAKE_BINARY_DIR}/lib)
endforeach(CONF CMAKE_CONFIGURATION_TYPES)

#---------------------- OS Specific Config ----------------------

if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  # Apple-specific code
  set(CMAKE_CXX_FLAGS "-DOSX")
endif (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")

if (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
	find_package(Threads)
	find_package(X11)
	set(ALL_LIBS ${ALL_LIBS} ${CMAKE_THREAD_LIBS_INIT} rt Xrandr Xxf86vm Xi m dl ${X11_LIBRARIES})
endif()

#---------------------- Create Executable ----------------------

add_executable(${PROJECT_NAME} ${source_files} ${header_files} ${extra_files})
target_link_libraries(${PROJECT_NAME} ${MinVR_LIBRARIES} ${OPENGL_gl_LIBRARY} ${ALL_LIBS})

# if not found on the system, add dependency to the glm external project
if (NOT ${glm_FOUND})
  add_dependencies(${PROJECT_NAME} glm)
endif (NOT ${glm_FOUND})
