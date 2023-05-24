install_pip_package() {
    local package_name=${1:-""}
    if [ -z "${package_name}" ]; then
        exit -1
    fi

    echo pip config set global.disable-pip-version-check true
    echo pip install ${package_name}
}

report() {
    local report=${@:-""}
    if [ -z "${report}" ]; then
        exit -1
    fi
    echo -n "report=${report}"
}
