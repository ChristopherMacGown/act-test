#!/usr/bin/env bash

set -euox pipefail

source ${BASH_SOURCE%/*}/common.sh

COMMAND=${1:-""}
case "${COMMAND}" in
check)
    install_pip_package ruff
    report $(
        ruff check --format=json . |
            jq -S 'group_by(.fix | type) 
            | map({(if .[0].fix == null then "remaining" else "fixable" end ): length})
            | add
            | @json'
    )
    ;;
format)
    install_pip_package ruff
    report $(
        ruff check --fix --format=json . |
            jq 'group_by(.fix | type) 
            | map({(if .[0].fix == null then "remaining" else "fixable" end ): length})
            | add'
    )
    ;;
*)
    echo -n "Usage: $0 [check|format]"
    exit 1
    ;;
esac
