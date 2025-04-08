#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/aws/aws-sam-cli"
TOOL_NAME="samcli"
TOOL_TEST="sam --version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if samcli is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' |
		grep -v '\.dev' | grep -E -v '^1\.(1[0-9]|[0-9])\.'
}

list_all_versions() {
	list_github_tags
}

get_os() {
	case "$(uname -s)" in
	Linux) echo "linux" ;;
	Darwin) echo "macos" ;;
	*) fail "Unsupported OS: $(uname -s)" ;;
	esac
}

get_arch() {
	# for linux
	case "$(uname -m)" in
	x86_64) echo "x86_64" ;;
	Aarch64) echo "arm64" ;;
	aarch64) echo "arm64" ;;
	*) fail "Unsupported architecture: $(uname -m)" ;;
	esac
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	echo "$GH_REPO"
	url="$GH_REPO/releases/download/v${version}/aws-sam-cli-$(get_os)-$(get_arch).zip"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		(cd "$ASDF_DOWNLOAD_PATH" && ./install -i "$install_path" -b "$install_path")

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
