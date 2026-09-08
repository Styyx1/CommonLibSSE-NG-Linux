# CommonLibSSE-NG xmake template

SKSE plugin template using [CommonLibSSE-NG](https://github.com/alandtse/CommonLibVR/tree/ng) and [xmake](https://xmake.io). Builds on Windows with MSVC, and on Linux with the same compiler through [msvc-wine](https://github.com/mstorsjo/msvc-wine).

Based on [libxse/commonlibsse-ng-template](https://github.com/libxse/commonlibsse-ng-template).

## Requirements

**Windows:** Visual Studio 2022 (C++ desktop workload) and [xmake](https://xmake.io) 3.0+. Untested.

**Linux (Arch / CachyOS):**

```bash
sudo pacman -S --needed wine xmake python msitools samba python-simplejson
```

Debian / Ubuntu: `wine64`, `python3`, `msitools`, `winbind`, and [xmake 3.0+](https://xmake.io/#/guide/installation) if the distro package is too old.

The first Linux build installs MSVC and the Windows SDK into `~/msvc-bins` (override with `MSVC_BINS`). You can also run `./scripts/setup-msvc-wine.sh` on its own.

## Clone

```bash
git clone --recurse-submodules https://github.com/MissCorruption/CommonLibSSE-NG-Linux.git
cd CommonLibSSE-NG-Linux
```

`--recurse-submodules` is required. If you already cloned without it:

```bash
git submodule update --init --recursive
```

## Build

Linux:

```bash
./scripts/build.sh
```

Windows:

```bat
scripts\build.bat
```

DLL: `build/windows/x64/releasedbg/commonlibsse-ng-template.dll`

A copy goes to `build/install/SKSE/Plugins/`. To install into a mod manager or Skyrim instead, set `XSE_TES5_MODS_PATH` or `XSE_TES5_GAME_PATH`.

Rename the plugin in `xmake.lua` (`set_project`, `target`, and the `commonlibsse-ng.plugin` `name` field).

Visual Studio project: `xmake project -k vsxmake`

If Linux configure hangs, leftover `mspdbsrv.exe` is usually the problem. `build.sh` kills it; otherwise `killall -9 mspdbsrv.exe`.
