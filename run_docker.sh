#!/usr/bin/env bash

EX=${1:-factorial}

RES_FILE=results/${EX}_result.json
CONF_FILE_NAME=test_data.json

CONF_FILE=${EX}/${CONF_FILE_NAME}

docker build -t unit_test_corrector .

#docker image prune -f

if [[ ! -f ${CONF_FILE} ]]; then
    printf '\033[0;31mThere is no local config file for exercise!\n'
    exit 10
fi

if [[ ! -f ${RES_FILE} ]]; then
    touch ${RES_FILE}
else
    truncate -s 0 ${RES_FILE}
fi

docker run -it --rm \
    -v $(pwd)/${CONF_FILE}:/data/${CONF_FILE_NAME}:ro \
    -v $(pwd)/${EX}/:/data/${EX}/ \
    -v $(pwd)/${RES_FILE}:/data/result.json \
    unit_test_corrector