#!/bin/bash
: ${CONTAINER_NAME:="dockerzcash_zcashd_1"}
docker exec ${CONTAINER_NAME} ./cli "$@"
