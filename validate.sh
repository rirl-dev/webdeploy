#!/usr/bin/env bash
# Simple validate wrapper for docker webdeploy container.
# Use curl, grep, cut, tr to show the "VersionTag" from the version.txt (added to content).
# Assume container has been built (build.sh) and started (runner.sh)...
echo "[$0]:: Begin [$*]"

WEBDEPLOY_VERSION_EXPECTED="1.0"

WEBDEPLOY_PORT=9090
WEBDEPLOY_URL="http://$(hostname):${WEBDEPLOY_PORT}/version.txt"
WEBDEPLOY_URL="http://192.168.56.201:${WEBDEPLOY_PORT}/version.txt"

status=0

echo "[$0]:: Validate [${WEBDEPLOY_URL}] Expected [${WEBDEPLOY_VERSION_EXPECTED}]"

WEBDEPLOY_VERSION_ACTUAL=$(curl -s ${WEBDEPLOY_URL}| grep VersionInfo| cut -d':' -f2| tr -d " \t\n\r")
status=$?

echo "[$0]:: Actual [${WEBDEPLOY_VERSION_ACTUAL}] Expected [${WEBDEPLOY_VERSION_EXPECTED}]"

echo "[$0]:: End   [$status]"
exit $status