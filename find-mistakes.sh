#!/bin/bash
SCRIPT_PATH="$(dirname $BASH_SOURCE)"


MISTAKE_DB_PATH="${SCRIPT_PATH}/search_pattern"

LITERAL_STR_PATTER_FILE="${MISTAKE_DB_PATH}/literal"

# DEFAULT_IGNORE_PATTERNS="--ignore \"*.ag_ingore\" --ignore \"vendor\""
DEFAULT_IGNORE_PATTERNS="--ignore-dir vendor --ignore-dir search_pattern"
# DEFAULT_IGNORE_PATTERNS=""

if [ ! -r ${LITERAL_STR_PATTER_FILE} ]; then
    echo "cannot read database"
fi

LITERAL_SEARCH_OPTIONS="-Q ${DEFAULT_IGNORE_PATTERNS}"
# LITERAL_SEARCH_OPTIONS="-Q"


while read -r LITERAL; do
    # echo ${LITERAL}
    if [ "${LITERAL}" = "" ]; then
        continue
    fi
    # silversearcher-ag is way faster but ack produce the pretty
    # formated output even in pipe mode. We search with ag first and
    # check if there were results found. If results are available
    # search again with ack for nicer output.
    MATCH_COUNT=$(ag ${LITERAL_SEARCH_OPTIONS} "${LITERAL}" . | wc -l)
    echo ${MATCH_COUNT}
    # continue
    if [ ${MATCH_COUNT} -eq 0 ]; then continue; fi
    ack ${LITERAL_SEARCH_OPTIONS} "${LITERAL}" .
done < ${LITERAL_STR_PATTER_FILE}
