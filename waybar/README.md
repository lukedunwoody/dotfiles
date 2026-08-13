# Waybar

My minimal Waybar config for my Hyprland rice.

## Custom Modules

This config includes several custom modules. Their scripts can be found in the `scripts` folder inside `.config/waybar`.

##### Updates

A distro icon that turns red and displays the update count when updates are available but not installed. The tooltip shows the sources of the updates, and clicking it launches a script that automatically updates packages through `pacman`, `yay`, and `flatpak`.

##### SwayNC

A bell that turns red and displays the notification count when there are unread SwayNC notifications. Clicking it opens the SwayNC client.

##### Bluetooth

A Bluetooth icon that changes depending on whether Bluetooth is disabled, enabled and inactive, or enabled and active. The tooltip shows connected devices, and clicking it opens `blueman-manager`.

##### Proton VPN

A lock that closes and fills when a VPN is connected. The tooltip shows the server when connected, and clicking it opens `proton-vpn-app`. Because it detects the connection through `nmcli`, it can easily be adapted for other VPNs by changing its click action.

##### Power Profiles for New Firmware

The default `power-profiles-daemon` module uses `powerprofilesctl`, which breaks on certain firmware where `powerprofilesctl`'s `power-saver` profile is mapped to the firmware's `quiet` profile. This module uses a workaround that requires extra steps but handles these edge cases. For more information, see **Getting Started**.

##### Ecstasy

When enabled, prevents the computer from sleeping when the lid is closed or when the system is idle. Clicking it toggles this behavior.

##### Recording

If you use my custom Hyprland recording script, this module adds an indicator while the script is active.

## Getting Started

Before linking the configuration with Stow, there are a few device-specific changes you may need or want to make.

### Step 1: Tray

I prefer the tray to be hidden. If you want it visible, change the tray icon settings near line 79 of `config.jsonc`. Suggested values are provided. Also remove or comment out the `#tray` section near line 50 of `style.css`.

### Step 2: Power Profiles

If you are using newer firmware, your kernel-level power-profile names might not match the names used by `powerprofilesctl`.
To check, run this command:

```bash
cat /sys/firmware/acpi/platform_profile_choices
```

If it prints `quiet balanced performance`, then run `install-platform-profile-permission.sh`.

If it prints `power-saver` instead of `quiet`, then change `"custom/power-profile"` to `"power-profiles-daemon"` near line 46 of `config.jsonc`.

### Step 3: Ecstasy

If you are using a desktop, this module provides no additional functionality beyond `idle_inhibitor`, so I recommend using the built-in module instead. To do this, change `"custom/ecstasy"` to `"idle_inhibitor"` near line 47 of `config.jsonc`.

### Step 4: System stats

By default, the system-stats group displays `temperature` and `battery`, not `cpu` and `memory`. On a desktop, `battery` serves no purpose and can be removed. Enable or disable the other modules as you prefer by editing `"modules"` in `"group/system-stats"` near line 57 of `config.jsonc`.

### Step 5: Link with Stow

From the repository root, run this command:

```bash
stow waybar
```
