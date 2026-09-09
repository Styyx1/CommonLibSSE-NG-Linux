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

## Customize

Edit the identity block at the top of `xmake.lua` (`PLUGIN`, `AUTHOR`, `CONTACT`, `DESCRIPTION`, `VERSION`, `LICENSE`). That is the only required change.

Optional, picked up automatically if present:

- `include/` — extra headers
- `package/` — Data-layout files installed next to the DLL (`SKSE/Plugins/*.ini`, `Scripts/`, `Interface/`, …)
- `src/pch.h` or `src/PCH.h` — precompiled header

CommonLib flags must be set above `includes()` in `xmake.lua`, or at configure time:

```bash
xmake f --skse_xbyak=y --rex_ini=y --skyrim_vr=n
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

There is also a build task for VSC and derivatives running those scripts.

Default mode is `releasedbg`. `debug` and `release` are also available (`xmake f -m release`).

DLL: `build/windows/x64/releasedbg/commonlibsse-ng-template.dll`

A copy goes to `build/install/SKSE/Plugins/`. To install into a mod manager or Skyrim instead, set `XSE_TES5_MODS_PATH` or `XSE_TES5_GAME_PATH`.

Visual Studio project: `xmake project -k vsxmake`
