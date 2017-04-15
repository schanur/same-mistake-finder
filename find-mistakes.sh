#!/bin/bash
SCRIPT_PATH="$(dirname $BASH_SOURCE)"


MISTAKE_DB_PATH="${SCRIPT_PATH}/search_pattern"

LITERAL_STR_PATTER_FILE="${MISTAKE_DB_PATH}/literal"


for LITERAL in $(cat ${LITERAL_STR_PATTER_FILE}); do
    ag "${LITERAL}"
done
