#!/usr/bin/env bash

set -euxo pipefail

# Run Minio
# docker run -d -p 9000:9000 --name minio \
#             -e "MINIO_ACCESS_KEY=minioadmin" \
#             -e "MINIO_SECRET_KEY=minioadmin" \
#             -v /tmp/data:/data \
#             -v /tmp/config:/root/.minio \
#             minio/minio server /data
#
# export AWS_ACCESS_KEY_ID=minioadmin
# export AWS_SECRET_ACCESS_KEY=minioadmin
# export AWS_EC2_METADATA_DISABLED=true

poetry install -E slack
poetry run pytest --cov .
