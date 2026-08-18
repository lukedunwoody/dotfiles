# Zed

My config for the text editor Zed.

## Installation

1. Install Zed if you haven't already:

```bash
sudo pacman -S zed
```

2. Ensure the target config directory exists (helps Stow create only the file/symlinks you expect):

```bash
mkdir -p ~/.config/zed
```

3. From the repository root, link this module using Stow:

```bash
stow zed
```
