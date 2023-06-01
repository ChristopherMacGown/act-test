#!/usr/bin/env bash

set -euxo pipefail

source ${BASH_SOURCE%/*}/common.sh

COMMAND=${1:-""}
case "${COMMAND}" in
check)
    install_node_package prettier
    report $(
        prettier -c . |
            tail -1 |
            python "${BASH_SOURCE%/*}/parse_to_json_output.py" prettier |
            jq -s 'add
                | select(. != null)
                | @json'
    )

    ;;
format)
    install_node_package prettier
    report $(
        printf "[warn] Code style issues found in %d files." $(prettier --write . | wc -l) |
            python "${BASH_SOURCE%/*}/parse_to_json_output.py" prettier |
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
