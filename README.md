# unix_bootstrap

Small Arch Linux bootstrap scripts for base setup, desktop apps, and a few dev helpers.

## Requirements

- Arch Linux (or Arch-based)
- `sudo` access
- `git` for build scripts
- SSH key added to GitHub (required for `build_suckless.sh` SSH clones)

## Suggested order

1) `install_base.sh` - core system packages and services
2) `install_amd_nvidia.sh` - AMD Ryzen + NVIDIA stack (microcode, drivers, Vulkan/OpenCL, Docker runtime integration)
3) `install_paru.sh` - AUR helper
4) `install_desktop.sh` - desktop apps + AUR apps
5) `install_optional_apps.sh` - optional heavy apps (LibreOffice, GIMP, csvlens, Burp Suite, Postman)
6) `build_suckless.sh` - optional local builds (st/dmenu)
7) `build_nvim_from_source.sh` - optional Neovim build

## Usage

Base system:

```bash
./install_base.sh
```

AUR helper:

```bash
./install_paru.sh
```

AMD Ryzen + NVIDIA:

```bash
./install_amd_nvidia.sh
```

Desktop apps:

```bash
./install_desktop.sh
```

Optional apps:

```bash
./install_optional_apps.sh
```

Suckless builds:

```bash
./build_suckless.sh --all
# or
./build_suckless.sh --st
./build_suckless.sh --dmenu
```

Neovim from source (kills running `nvim`, builds, checks out stable branch):

```bash
./build_nvim_from_source.sh
```

## Config

Edit `config.sh` to change the git clone path, GitHub username, or tmp dir.

## Notes

- These scripts are designed to be idempotent and safe to re-run.
- `install_base.sh` enables NetworkManager, Bluetooth, Docker, and PipeWire services.
