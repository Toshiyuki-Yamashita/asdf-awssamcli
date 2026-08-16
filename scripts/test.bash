#!/usr/bin/env bash

set -euo pipefail

current_script_path=${BASH_SOURCE[0]}
plugin_dir=$(cd "$(dirname "$current_script_path")/.." && pwd)

if ! command -v asdf >/dev/null 2>&1; then
	printf 'asdf is required to run this test.\n' >&2
	exit 1
fi

version=${1:-latest}
if [ "$#" -gt 0 ]; then
	shift
fi

if [ "$#" -eq 0 ]; then
	set -- sam --version
fi

test_root=$(mktemp -d "${TMPDIR:-/tmp}/asdf-samcli-test.XXXXXX")

cleanup() {
	if [ "${ASDF_TEST_KEEP_TEMP:-0}" = "1" ]; then
		printf 'Test environment kept at %s\n' "$test_root"
	else
		rm -rf "$test_root"
	fi
}
trap cleanup EXIT

export ASDF_DATA_DIR="$test_root/asdf"
mkdir -p "$ASDF_DATA_DIR/plugins" "$test_root/project"
ln -s "$plugin_dir" "$ASDF_DATA_DIR/plugins/samcli"

if [ "${ASDF_PLUGIN_DEBUG:-0}" = "1" ]; then
	export BASH_ENV="$plugin_dir/scripts/debug-env.bash"
	set -x
fi

if [ "$version" = "latest" ]; then
	latest_output=
	if ! latest_output=$(asdf latest samcli); then
		printf '%s\n' "$latest_output" >&2
		exit 1
	fi
	version=$latest_output
fi

(
	cd "$test_root/project"
	asdf install samcli "$version"
	asdf set samcli "$version"
	asdf exec "$@"
)
