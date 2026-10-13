#!/usr/bin/env bash
set -ex
START_COMMAND="wordcraft"
DEFAULT_ARGS=""
ARGS=${APP_ARGS:-$DEFAULT_ARGS}

/usr/bin/filter_ready
/usr/bin/desktop_ready
set +e
$START_COMMAND $ARGS