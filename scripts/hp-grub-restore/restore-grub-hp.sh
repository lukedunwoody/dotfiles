#!/bin/bash
set -e

GRUB_EFI="/boot/EFI/GRUB/grubx64.efi"
WIN_EFI="/boot/EFI/Microsoft/Boot/bootmgfw.efi"

echo "Backing up current Windows bootloader..."
sudo cp "$WIN_EFI" "${WIN_EFI}.bak.$(date +%Y%m%d-%H%M%S)"

echo "Replacing Windows bootloader with GRUB..."
sudo cp "$GRUB_EFI" "$WIN_EFI"

echo "Done."
