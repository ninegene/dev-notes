#!/bin/bash

BASE_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
HARP_HOME=${BASE_DIR}/node_modules/harp

cd "${BASE_DIR}"
"${HARP_HOME}/bin/harp" server
