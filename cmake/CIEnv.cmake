if(DEFINED ENV{CI})
    set(output_env_file "${CMAKE_SOURCE_DIR}/.env.ci")
    message(STATUS "Writing ENV file for CI: ${output_env_file}")

    set(required_vars PRODUCT_NAME PACKAGE_DIRECTORY PACKAGE_FILE_NAME PROJECT_VERSION)
    foreach(var IN LISTS required_vars)
        if(NOT DEFINED ${var})
            message(FATAL_ERROR "Required environment variable '${var}' is not defined.")
        endif()
    endforeach()

    set(PACKAGE_FILE_EXT "")
    if(APPLE)
        set(PACKAGE_FILE_EXT ".pkg")
    elseif(WIN32)
        set(PACKAGE_FILE_EXT ".exe")
    endif()

    set(PACKAGE_FILE_PATH "${PACKAGE_DIRECTORY}/${PACKAGE_FILE_NAME}${PACKAGE_FILE_EXT}")
    set(env_vars
        "PRODUCT_NAME=${PROJECT_NAME}"
        "PACKAGE_FILE_NAME=${PACKAGE_FILE_NAME}"
        "PACKAGE_FILE_PATH=${PACKAGE_FILE_PATH}"
        "VERSION=${PROJECT_VERSION}"
    )

    file(WRITE "${output_env_file}" "")
    foreach(var IN LISTS env_vars)
        file(APPEND "${output_env_file}" "${var}\n")
    endforeach()

    message(STATUS "ENV file for CI generated: ${output_env_file}")
    message(STATUS "Contents of ${output_env_file}:")
    foreach(var IN LISTS env_vars)
        message(STATUS "  ${var}")
    endforeach()
endif()
