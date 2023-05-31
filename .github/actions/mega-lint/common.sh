install_pip_package() {
    local package_name=${1:-""}
    if [ -z "${package_name}" ]; then
        exit -1
    fi

    pip install --disable-pip-version-check ${package_name}
}

report() {
    local report=${@:-""}
    if [ -z "${report}" ]; then
        exit 0
    fi

    REPORTS=$(
        echo "${report}" | jq -r 'fromjson 
                            | to_entries
                            | map("\(.key)=\(.value)")
                            | join("\n")'
    )

    for output in ${REPORTS}; do
        echo ${output} >>$GITHUB_OUTPUT
    done
    exit 1
}
