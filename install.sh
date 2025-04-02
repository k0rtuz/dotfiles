#!/usr/bin/env bash
LOG_FILE="install.log"
CONFIG_DIR="${XDG_CONFIG_HOME:-~/.config}"
CACHE_DIR="${XDG_CACHE_HOME:-~/.cache}"
DATA_DIR="${XDG_DATA_HOME:-~/.local/share}"
STATE_DIR="${XDG_STATE_HOME:-~/.local/state}"

LOCAL_BIN="${HOME}/.local/bin"

ensure_dir() {
    if [[ ! -d "$1" ]]; then
        mkdir -p "$1"
    fi
}

ensure_dirs() {
    for folder in "$@"; do
        ensure_dir ${folder}
    done
}

setup_nvim() {
    if [[ -x $(which nvim) ]]; then
        echo "Setting up Neovim configuration..."
    fi
}

setup_awesome() {
    if [[ -x $(which awesome) ]]; then
        if $(awesome -k -c ./awesome/rc.lua); then
            echo "AwesomeWM configuration is correct."
            echo "Setting up AwesomeWM configuration..."
        else
            echo "AwesomeWM configuration presents some errors."
        fi
    fi
}

main() {
    ensure_dir "${LOCAL_BIN}"
    local -r -a xdg_dirs="${CONFIG_DIR} ${CACHE_DIR} ${DATA_DIR} ${STATE_DIR}"
    ensure_dirs $xdg_dirs

    setup_nvim
    setup_awesome
}

main
