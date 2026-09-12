# Restore GRUB Booting on HP Laptops

On many HP laptops, the UEFI always boots to Windows when dual-booting, even if you change the boot order in the UEFI settings. This script replaces the Windows EFI file with the GRUB one, effectively tricking the HP firmware into booting GRUB.

## Requirements

- A UEFI-based Linux installation with GRUB
- GRUB installed at `/boot/EFI/GRUB/grubx64.efi`*
- Windows Boot Manager installed at `/boot/EFI/Microsoft/Boot/bootmgfw.efi`*
- `sudo` access

*If you use different paths, modify the `GRUB_EFI` and/or `WIN_EFI` variables in the script.

> [!WARNING]
> This script modifies the Windows bootloader. A backup is highly recommended before continuing.

## Usage

1. Make a manual copy of the Windows bootloader with a name you will remember:

```bash
sudo cp /boot/EFI/Microsoft/Boot/bootmgfw.efi \
  /boot/EFI/Microsoft/Boot/bootmgfw-copy.efi
```

2. Run the script:

```bash
bash restore-grub-hp.sh
```

3. Before rebooting, add a GRUB entry that points to the new copy of the Windows bootloader.

4. Reboot. You should now boot directly into GRUB.

## After Windows or Firmware Updates

Windows or UEFI updates may restore the original `bootmgfw.efi`, which bypasses GRUB and causes the system to boot directly into Windows again. If that happens, boot Linux and rerun:

```bash
bash restore-grub-hp.sh
```

## Restoring the Original Windows Bootloader

To undo this script, replace the original Windows bootloader with your copy:

```bash
# Change the backup path to match yours.
sudo cp /boot/EFI/Microsoft/Boot/bootmgfw-copy.efi \
  /boot/EFI/Microsoft/Boot/bootmgfw.efi
```
