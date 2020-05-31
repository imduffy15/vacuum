#!/bin/bash
# Add librespot to the firmware

LIST_CUSTOM_PRINT_USAGE+=("custom_print_usage_librespot")
LIST_CUSTOM_PRINT_HELP+=("custom_print_help_librespot")
LIST_CUSTOM_PARSE_ARGS+=("custom_parse_args_librespot")
LIST_CUSTOM_FUNCTION+=("custom_function_librespot")
ENABLE_librespot=${ENABLE_librespot:-"0"}

function custom_print_usage_librespot() {
    cat << EOF

Custom parameters for '${BASH_SOURCE[0]}':
[--enable-librespot]
EOF
}

function custom_print_help_librespot() {
    cat << EOF

Custom options for '${BASH_SOURCE[0]}':
  --enable-librespot           Add librespot to the firmware
EOF
}

function custom_parse_args_librespot() {
    case ${PARAM} in
        *-enable-librespot)
            ENABLE_librespot=1
            ;;
        -*)
            return 1
            ;;
    esac
}

function custom_function_librespot() {
    if [ $ENABLE_librespot -eq 1 ]; then
        echo "+ Installing librespot"
        install -D -m 0755 "${FILES_PATH}/librespot" "${IMG_DIR}/usr/local/bin/librespot"
        install -D -m 0755 "${FILES_PATH}/librespot-daemon.sh" "${IMG_DIR}/usr/local/bin/librespot-daemon.sh"
        install -D -m 0755 "${FILES_PATH}/S11librespot" "${IMG_DIR}/etc/init/S11librespot"
    fi
}
