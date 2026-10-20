# AMD Radeon Profile

Simple application to read current clocks of ATi Radeon cards (xf86-video-ati, xf86-video-amdgpu).

**[2026-05] Forked to fix issues with latest GPUs and LTS kernel.**

# `xf86-video-ati` and `xf86-video-amdgpu` driver

Install and run [`radeon-profile-daemon`](https://github.com/MaesterZ/radeon-profile-daemon) for using this app as normal user. Otherwise app need to be run with root privileges for changing power profiles (and clocks readings sometimes).

# Functionality

* Monitoring of basic GPU parameters (frequencies, voltages, usage, temperature, fan speed)
* DPM profiles and power levels
* Fan control (HD 7000+), definition of multiple custom curves or fixed speed
* Per app profiles/Event definitions (i.e. change fan profile when temp above defined or set DPM to high when selected binary executed)
* Define binaries to run with set of environment variablees (i.e. GALLIUM_HUD, MESA, LIBGL etc)

# Dependencies

* Qt 6 (qt6-base and qt6-charts) (On Debian/Ubuntu: `qt6-base-dev qt6-charts-dev qmake6`)
* libxrandr
* libdrm (for amdgpu, 2.4.79<=, more recent, the better)
* recent kernel (for amdgpu 4.12<=, more recent, the better)
* radeon card

For full functionality:
* glxinfo - info about OpenGL, mesa
* xdriinfo - driver info
* xrandr - connected displays

# Build

```bash
./build.sh
```

Or manually:

```bash
cd radeon-profile/
qmake6
make
```

The resulting binary is `./target/radeon-profile`.

# Installation

Will copy the binary to `/usr/local/bin/`.

```bash
./install.sh
```

# Links

* [System daemon](https://github.com/MaesterZ/radeon-profile-daemon)
* [Forum thread](http://phoronix.com/forums/showthread.php?83602-radeon-profile-tool-for-changing-profiles-and-monitoring-some-GPU-parameters)
* [Icons](http://proicons.deviantart.com/art/Graphics-Cards-Icons-H1-Pack-161178339)

