# [2026-10-20]

### `radeon-profile/radeon_profile.cpp` — Report a missing daemon instead of failing silently

Running as a regular user, all GPU data comes from `radeon-profile-daemon`. If the daemon was
not running, the app opened an empty window with no error, which looked like a startup failure.
A failed daemon connection now shows a warning once and the connection is retried every 5
seconds, so the UI fills in as soon as the daemon starts.

### `radeon-profile/dxorg.cpp` — Skip reading sysfs files with no path

On amdgpu the `power_method` file (radeon driver only) is never found, so its path is empty.
Reading it made Qt print `QFSFileEngine::open: No file name specified` on every launch.
`getValueFromSysFsFile()` now returns its "not available" value for an empty path.

# [2026-05-12]

## Removed overclocking features

## Linux 6.18 LTS compatibility fixes

### `radeon-profile/ioctlHandler.cpp` — Fix render node index (critical)

The code assumed the render node for `card<N>` was always `/dev/dri/renderD<128+N>`.
This breaks when the card index and render node index diverge — for example, a system
with a single discrete GPU may appear as `card1` + `renderD128` (not `renderD129`).

The constructor now scans `/sys/class/drm/card<N>/device/drm/` via `opendir()` to find
the actual `renderD*` entry before falling back to the old arithmetic. This fixes
`DRM_IOCTL_AMDGPU_INFO: Permission denied` errors on affected systems (the code was
silently falling back to the `card` device, which requires DRM Master for ioctls).

Note: `logind` grants the active user ACL access to the render node automatically;
no group changes are needed.

### `radeon-profile/dxorg.cpp` — Recover from stale shared memory

A previous crashed session can leave an orphaned System V shared memory segment.
`setupSharedMem()` now detaches from any stale segment and retries with a fresh key.
`getClocksRawData()` also recovers from a failed `lock()` by detaching and recreating
the segment rather than silently returning empty data.

### `radeon-profile/dxorg.cpp` — Fix `getCurrentPowerPlayTableId()` empty-path bug

`getValueFromSysFsFile(file)` was being called with an empty `file` string, producing
`QFSFileEngine::open: No file name specified` warnings. Added an early return guard.

The same function also had `.split(QString::SkipEmptyParts)` with no separator: the
enum value `1` was being cast to `QChar('\x01')` and used as the split delimiter
instead of `'\n'`. Fixed to `.split('\n', QString::SkipEmptyParts)`.

## Build system cleanup

### `radeon-profile.pro` — Use `CONFIG += c++11` instead of raw `QMAKE_CXXFLAGS`

Replaced `QMAKE_CXXFLAGS += -std=c++11` with `CONFIG += c++11`. The `CONFIG` directive
tells both the compiler and Qt's MOC to use C++11; the raw CXXFLAGS flag only affects
the compiler, which can cause subtle issues with MOC-generated code.

### `radeon-profile.pro` — Use `CONFIG += warn_on` for debug warnings

Replaced the direct `-Wall` CXXFLAGS addition with `CONFIG += warn_on` (the proper
qmake mechanism), with `-Wextra -Wpedantic` added on top.

### `radeon-profile.pro` — Remove translation build system entries

Removed the `TRANSLATIONS` and `DISTFILES` blocks and their associated packaging
comment. English is the default language baked into the binary; `main.cpp` already
skips translation loading for English locales, so the translation workflow entries
served no purpose in this build.

### `radeon-profile.pro` — Remove stale QtCreator boilerplate

Removed the auto-generated project header comment from 2013.
