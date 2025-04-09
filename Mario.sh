#!/bin/sh
echo -ne '\033c\033]0;Mario\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Mario.arm64" "$@"
