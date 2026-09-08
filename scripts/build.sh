#!/usr/bin/env bash
# Build the plugin. On Linux this uses msvc-wine; on Windows, native MSVC.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$ROOT"

if command -v git >/dev/null && [[ -d "$ROOT/.git" ]]; then
	git submodule update --init --recursive
fi

if [[ ! -f "$ROOT/lib/commonlibsse-ng/xmake.lua" ]]; then
	echo "CommonLibSSE-NG submodule is missing." >&2
	echo "Clone with: git clone --recurse-submodules <url>" >&2
	exit 1
fi

if [[ "$(uname -s)" == Linux ]]; then
	MSVC_BINS="${MSVC_BINS:-$HOME/msvc-bins}"
	if [[ ! -x "$MSVC_BINS/bin/x64/cl" ]]; then
		echo "msvc-wine SDK not found at $MSVC_BINS; running setup (accepts Microsoft VS/WinSDK terms)..."
		"$ROOT/scripts/setup-msvc-wine.sh"
	fi
	export MSVC_BINS
	export WINEDEBUG="${WINEDEBUG:--all}"
	killall -9 mspdbsrv.exe 2>/dev/null || true
	if command -v wineserver >/dev/null 2>&1; then
		wineserver -p || true
	fi
	echo "Configuring (first Wine compiler probe can sit silent for about a minute)..."
fi

xmake build -y
