#!/bin/bash -x

VERSION=$1
if [[ ! -z $VERSION ]]; then
    export NODE_OPTIONS=--max_old_space_size=1536
    cd ..
    podman build --pull --no-cache --rm=true -f docker/Dockerfile.node -t europe-west6-docker.pkg.dev/pure-quasar-407114/docdok-registry/openvidu-call:$VERSION --build-arg BASE_HREF=/ .
else
    echo "Error: You need to specify a version as first argument"
fi
