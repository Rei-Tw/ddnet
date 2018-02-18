if(NOT PREFER_BUNDLED_LIBS)
  set(CMAKE_MODULE_PATH ${ORIGINAL_CMAKE_MODULE_PATH})
  find_package(GLEW)
  set(CMAKE_MODULE_PATH ${OWN_CMAKE_MODULE_PATH})
  if(GLEW_FOUND)
    set(GLEW_BUNDLED OFF)
    set(GLEW_DEP)
  endif()
endif()

if(NOT GLEW_FOUND)
  set(GLEW_BUNDLED ON)
  set(GLEW_SRC_DIR src/engine/external/glew)
  set_glob(GLEW_SRC GLOB ${GLEW_SRC_DIR} glew.c)
  set_glob(GLEW_INCLUDES GLOB ${GLEW_SRC_DIR}/GL eglew.h glew.h glxew.h wglew.h)
  add_library(glew EXCLUDE_FROM_ALL OBJECT ${GLEW_SRC} ${GLEW_INCLUDES})
  set(GLEW_INCLUDEDIR ${GLEW_SRC_DIR})
  target_include_directories(glew PRIVATE ${GLEW_INCLUDEDIR})

  set(GLEW_DEP $<TARGET_OBJECTS:glew>)
  set(GLEW_INCLUDE_DIRS ${GLEW_INCLUDEDIR})
  set(GLEW_LIBRARIES)

  list(APPEND TARGETS_DEP glew)

  include(FindPackageHandleStandardArgs)
  find_package_handle_standard_args(GLEW DEFAULT_MSG GLEW_INCLUDEDIR)
endif()
