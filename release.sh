#!/bin/bash

USERNAME="3mdeb"
IMAGE="edk2"

if [ $# -ne 1 ]; then
    echo "Usage:"
    echo "$0 BUMP"
    echo "Available BUMPs: major, minor, patch, pre"
    exit 1
fi

BUMP="$1"

[ "$BUMP" != "major" -a \
  "$BUMP" != "minor" -a \
  "$BUMP" != "patch" -a \
  "$BUMP" != "pre" ] && echo "Invalid BUMP" && exit 1

function errorCheck {
    ERROR_CODE="${?}"
    if [ "${ERROR_CODE}" -ne 0  ]; then
      echo "[ERROR] ${1} : (${ERROR_CODE})"
        exit 1
    fi
}

# ensure we're up to date
CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
git pull origin $CURRENT_BRANCH
errorCheck "Failed to pull $CURRENT_BRANCH"

# bump version
docker run --rm -v "$PWD":/app treeder/bump $BUMP
version="$(cat VERSION)"
echo "version: $version"
errorCheck "Failed to run \"treeder/bump\" container"

# build
./build.sh
errorCheck "Build failed"

# tag
BRANCH="rel_$version"
git checkout -b $BRANCH
errorCheck "Failed to create branch: \"$BRANCH\""
git commit -am "release $version"
errorCheck "Failed to create commit"
git tag -a "$version" -m "version $version"
errorCheck "Failed to create tag: \"$version\""
git push origin $BRANCH
errorCheck "Failed to push branch: \"$BRANCH\""
git push --tags
errorCheck "Failed to push tags"

docker tag $USERNAME/$IMAGE:latest $USERNAME/$IMAGE:$version
errorCheck "Failed to tag container: \"$USERNAME/$IMAGE\" as \"$version\""

# push
docker push $USERNAME/$IMAGE:latest
errorCheck "Failed to push container: \"USERNAME/$IMAGE:latest\""
docker push $USERNAME/$IMAGE:$version
errorCheck "Failed to push container: \"USERNAME/$IMAGE:$version\""
