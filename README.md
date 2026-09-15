# CommonLibSSE-NG xmake template

SKSE plugin template using [CommonLibSSE-NG](https://github.com/alandtse/CommonLibVR/tree/ng) and [xmake](https://xmake.io). Builds on Windows with MSVC, and on Linux with the same compiler through [msvc-wine](https://github.com/mstorsjo/msvc-wine).

Based on [libxse/commonlibsse-ng-template](https://github.com/libxse/commonlibsse-ng-template).

## Requirements

**Windows:** [Visual Studio 2022 (C++ desktop workload)](https://visualstudio.microsoft.com/) and [xmake](https://xmake.io) 3.0+.

**Linux (Arch / CachyOS):**

```bash
sudo pacman -S --needed wine xmake python msitools samba python-simplejson
```

Debian / Ubuntu: `wine64`, `python3`, `msitools`, `winbind`, and [xmake 3.0+](https://xmake.io/#/guide/installation) if the distro package is too old.

The first Linux build installs MSVC and the Windows SDK into `~/msvc-bins` (override with `MSVC_BINS`). You can also run `./tools/setup-msvc-wine.sh` on its own.

## Clone

```bash
git clone --recurse-submodules https://github.com/MissCorruption/CommonLibSSE-NG-Linux.git
cd CommonLibSSE-NG-Linux
```

`--recurse-submodules` is required so CommonLib's nested OpenVR tree is present (needed for VR). `./tools/build.sh` will also initialize it if it is missing.

If you already cloned without it:

```bash
git submodule update --init --recursive lib/CommonLibSSE-NG
```

## Customize

Edit the identity block at the top of `xmake.lua` (`PLUGIN`, `AUTHOR`, `CONTACT`, `DESCRIPTION`, `VERSION`, `LICENSE`).

Runtime flags (`skse_xbyak`, `skyrim_se` / `skyrim_ae` / `skyrim_vr`) are set in the same file, above `includes()`. Uncomment `rex_ini` / `rex_toml` there if you need REX config parsers.

Optional layout, picked up if present:

- `src/` — plugin sources and `pch.h` (or `PCH.h`)
- `include/` — extra public headers
- `package/` — Data-layout files installed next to the DLL (`SKSE/Plugins/*.ini`, `Scripts/`, `Interface/`, …)

## Build

Linux:

```bash
./tools/build.sh
```

Linux uses a Wine prefix at `build/wineprefix` (override with `MSVC_WINEPREFIX`) and stops that wineserver when the script exits, including Ctrl+C.

Windows:

```bat
tools\build.bat
```

There is also a default VS Code / Cursor build task that runs those scripts.

Default mode is `releasedbg`. Pass `debug` or `release` as the first argument, or set `MODE`:

```bash
./tools/build.sh debug
MODE=release ./tools/build.sh
```

A copy goes to `build/install/SKSE/Plugins/`. To install into a mod manager or Skyrim instead, set `XSE_TES5_MODS_PATH` or `XSE_TES5_GAME_PATH`.

Zip from the install tree: `xmake package`

Visual Studio project: `xmake project -k vsxmake`
