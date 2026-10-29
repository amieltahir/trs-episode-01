#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
VERSION="${1:-$(git rev-parse --short HEAD)}"

podman run --rm --user 0:0 -v "$PWD:/workspace:Z" -v trs-m2:/root/.m2 \
  -w /workspace/app/trs-demo-api --entrypoint bash trs-episode-01-dev:local \
  -lc './mvnw -B clean test package'

podman build -t "trs-demo-api:${VERSION}" app/trs-demo-api
echo "Built trs-demo-api:${VERSION}"
