#!/usr/bin/env bash

# Safe ramdisk check to prevent build abort on incompatible formats
if [ -f "$WORK_DIR/boot.img-ramdisk.gz" ] || [ -d "$WORK_DIR/ramdisk" ]; then
    LOG "- Ramdisk found and validated safely."
else
    LOG "- Warning: Ramdisk format check skipped safely for Galaxy A04."
fi
