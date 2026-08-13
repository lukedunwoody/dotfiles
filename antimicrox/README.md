# AntiMicroX

A simple controller mapping to enable switching Hyprland workspace with the controller.

## Installation

1. Install AntiMicroX if you haven't already:

```bash
sudo pacman -S antimicrox
```

2. Ensure the target config directory exists (helps Stow create only the file/symlinks you expect):

```bash
mkdir -p ~/.config/antimicrox
```

3. From the repository root, link this module using Stow:

```bash
stow antimicrox
```

4. Open `antimicrox` and import the profile:

`~/.config/antimicrox/virtual-desktop.gamecontroller.amgp`
