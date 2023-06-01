# syntax=docker/dockerfile:1

# BASE
FROM python:3.9.7-slim as base
ENV PYTHONFAULTHANDLER=1 \
    PYTHONHASHSEED=random \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    POETRY_VERSION=1.3.2 \
    POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=true
WORKDIR /app
RUN pip install "poetry==${POETRY_VERSION}"

# BUILDER
FROM base AS builder
COPY pyproject.toml poetry.lock ./
RUN apt-get update && \
    export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends postgresql-client
RUN poetry install --no-dev


FROM builder as api

FROM builder as bit-runner

FROM builder as task-scheduler