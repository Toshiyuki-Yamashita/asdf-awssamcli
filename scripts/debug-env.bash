#!/usr/bin/env bash

if [ "${ASDF_PLUGIN_DEBUG:-0}" = "1" ]; then
	PS4='+ ${BASH_SOURCE}:${LINENO}: '
	set -x
fi
