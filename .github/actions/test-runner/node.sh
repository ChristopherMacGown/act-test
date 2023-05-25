#!/usr/bin/env bash

set -euxo pipefail

yarn --cwd front-end test:unit
yarn --cwd build
