#! /usr/bin/env sh

SCRIPT_DIRECTORY="$(dirname -- "$(readlink -f -- "$0")")"
PROJECT_DIRECTORY="$(dirname -- "$SCRIPT_DIRECTORY")"

"$SCRIPT_DIRECTORY/_build_inner.sh" 2>&1 | tee -a "$PROJECT_DIRECTORY/output.log"