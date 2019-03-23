#!/usr/bin/env bash
# Simple build wrapper for docker webdeploy container.
# Unit testing prior to publishing container to Docker hub (see publish.sh)
# See runner.sh to run the container local.
# See validate.sh to test version deployed by container (see testapp/version.txt).
export WEBDEPLOY_VERSION=v3
echo "[$0]:: Begin [$*]"
status=0

set -x; docker build --file Dockerfile --tag webdeploy:${WEBDEPLOY_VERSION} $(pwd); status=$?; set +x

echo "[$0]:: End   [$status]"
exit $status