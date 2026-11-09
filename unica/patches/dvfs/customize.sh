#!/usr/bin/env bash

SOURCE_FIRMWARE_PATH="$(cut -d "/" -f 1 -s <<< "$SOURCE_FIRMWARE")_$(cut -d "/" -f 2 -s <<< "$SOURCE_FIRMWARE")"
TARGET_FIRMWARE_PATH="$(cut -d "/" -f 1 -s <<< "$TARGET_FIRMWARE")_$(cut -d "/" -f 2 -s <<< "$TARGET_FIRMWARE")"

# Safe check for framework-res.apk before running DVFS patches
if [ ! -f "$FW_DIR/$SOURCE_FIRMWARE_PATH/system/system/framework/framework-res.apk" ]; then
    LOG "- Source framework-res.apk not found. Skipping DVFS patches safely."
    exit 0
fi
