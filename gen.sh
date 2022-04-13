#!/bin/bash

set -eo pipefail

function generate() {
    TAG="$1"
    URL="https://raw.githubusercontent.com/docker-library/wordpress/master/latest/${TAG}/apache/Dockerfile"
    DOCKERFILE="Dockerfile.${TAG}"

    echo "Generating $DOCKERFILE"

    echo -e "# Generated from $URL" >$DOCKERFILE
    curl --silent "$URL" \
        | grep -B1000000 "LogFormat" \
        | grep -A1000000 "^FROM" >>"$DOCKERFILE"
}

generate php7.4
generate php8.0
generate php8.1
