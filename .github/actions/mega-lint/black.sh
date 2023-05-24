#!/usr/bin/env bash

set -eux

source ${BASH_SOURCE%/*}/common.sh

COMMAND=${1:-""}
case "${COMMAND}" in
check)
    install_pip_package black
    report $(
        black --check . 2>&1 |
            tail -1 |
            python "${BASH_SOURCE%/*}/black_json_output.py" |
            jq -s 'add
                | select(. != null)
                | @json'
    )

    ;;
format)
    install_pip_package black
    report $(
        black . 2>&1 |
            tail -1 |
            python "${BASH_SOURCE%/*}/black_json_output.py" |
            jq -s 'add
                | select(. != null)
                | @json'
    )
    ;;
*)
    echo -n "Usage: $0 [check|format]"
    exit 1
    ;;
esac
