
# For headers and libs:
# 1. ideally: these are already installed on the system at a location
#    specified by the envvar MINVR_ROOT.
# 2. if not, guess that MinVR might be compiled locally in ../MinVR,
#    check there for the install directory in ../MinVR/build/install

find_path(MinVR_INCLUDE_DIR MinVR.h
          HINTS $ENV{MINVR_ROOT}/include/api
          ${CMAKE_SOURCE_DIR}/../MinVR/build/install/include/api)

if(MinVR_INCLUDE_DIR)
	set(MinVR_INCLUDE_DIR ${MinVR_INCLUDE_DIR}/..)
endif()

find_library(MinVR_OPT_LIBRARIES NAMES libMinVR.a MinVR.lib MinVR
             HINTS $ENV{MINVR_ROOT}/lib
             ${CMAKE_SOURCE_DIR}/../MinVR/build/install/lib)
          
find_library(MinVR_DEBUG_LIBRARIES NAMES libMinVRd.a MinVRd.lib MinVRd
             HINTS $ENV{MINVR_ROOT}/lib
             ${CMAKE_SOURCE_DIR}/../MinVR/build/install/lib)

if(MinVR_OPT_LIBRARIES AND MinVR_DEBUG_LIBRARIES)
	set(MinVR_OPT_LIBRARIES optimized ${MinVR_OPT_LIBRARIES} )
	set(MinVR_DEBUG_LIBRARIES debug ${MinVR_DEBUG_LIBRARIES} )
#if only opt is found, use it for both
elseif(MinVR_OPT_LIBRARIES AND NOT MinVR_DEBUG_LIBRARIES)
	set(MinVR_DEBUG_LIBRARIES debug ${MinVR_OPT_LIBRARIES} )
	set(MinVR_OPT_LIBRARIES optimized ${MinVR_OPT_LIBRARIES} )
#if only debug is found, use it for both
elseif(NOT MinVR_OPT_LIBRARIES AND MinVR_DEBUG_LIBRARIES)
	set(MinVR_OPT_LIBRARIES optimized ${MinVR_DEBUG_LIBRARIES} )
	set(MinVR_DEBUG_LIBRARIES debug ${MinVR_DEBUG_LIBRARIES} )
endif()

set(MinVR_LIBRARIES ${MinVR_OPT_LIBRARIES} ${MinVR_DEBUG_LIBRARIES})

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(MinVR  DEFAULT_MSG
                                  MinVR_INCLUDE_DIR MinVR_OPT_LIBRARIES MinVR_DEBUG_LIBRARIES MinVR_LIBRARIES)

mark_as_advanced(MinVR_INCLUDE_DIR MinVR_OPT_LIBRARIES MinVR_DEBUG_LIBRARIES MinVR_LIBRARIES)
