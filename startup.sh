#/bin/bash
set -e

echo "starting docker service"
service docker start
service docker status

env
