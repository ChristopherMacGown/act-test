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

    for output in $(echo "${report}" | jq 'fromjson 
                            | to_entries
                            | map("\(.key)=\(.value)")
                            | join("\n")'); do
        echo ${output} >>$GITHUB_OUTPUT
        echo ${output}
    done
    exit 1
}
