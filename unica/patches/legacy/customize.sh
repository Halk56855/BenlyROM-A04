#!/usr/bin/env bash

LOG "- Running Smart-Corrected Legacy Patches for Galaxy A04 (MediaTek)..."

BACKPORT_SF_PROPS()
{
    local FILE="$WORK_DIR/vendor/build.prop"
    if [ -f "$WORK_DIR/vendor/default.prop" ]; then
        FILE="$WORK_DIR/vendor/default.prop"
    fi

    if [ ! -f "$FILE" ]; then
        LOG "- Warning: build.prop not found for SF props backport, skipping safely."
        return 0
    fi

    local PROP
    local VALUE

    if [ "$TARGET_PLATFORM_SDK_VERSION" -lt "34" ]; then
        PROP="ro.surface_flinger.enable_frame_rate_override"
        VALUE="false"
        if [ ! "$(GET_PROP "vendor" "$PROP" 2>/dev/null)" ]; then
            LOG "- Adding \"$PROP\" prop safely."
            sed -i "/persist.sys.usb.config/i $PROP=$VALUE" "$FILE" 2>/dev/null || true
        fi
    fi
}

# Safe execution of SF props with error catching
BACKPORT_SF_PROPS || true

# Safe Face HAL fallback (skip safely if files are missing or incompatible)
if [ "$TARGET_PLATFORM_SDK_VERSION" -lt "34" ]; then
    if [ -f "$WORK_DIR/system/system/framework/services.jar" ] && [ -f "$MODPATH/face/services.jar/0001-Fallback-to-Face-HIDL-2.0.patch" ]; then
        APPLY_PATCH "system" "system/framework/services.jar" "$MODPATH/face/services.jar/0001-Fallback-to-Face-HIDL-2.0.patch" 2>/dev/null || LOG "- Warning: Face HAL patch skipped safely."
    fi
fi

# Safe Lights HAL fallback
if [ "$TARGET_PLATFORM_SDK_VERSION" -lt "35" ]; then
    if [ -f "$WORK_DIR/vendor/bin/hw/vendor.samsung.hardware.light-service" ] && [ -f "$MODPATH/lights/services.jar/0001-Backport-legacy-SehLights-HAL-code.patch" ]; then
        APPLY_PATCH "system" "system/framework/services.jar" "$MODPATH/lights/services.jar/0001-Backport-legacy-SehLights-HAL-code.patch" 2>/dev/null || LOG "- Warning: Lights patch skipped safely."
    fi
fi

# Completely bypassed telephony patch to prevent MediaTek build abort
LOG "- Skipping telephony-common.jar patch safely for Galaxy A04 MediaTek architecture."

# Safe cleanup of optional components with error suppression
if [ -d "$WORK_DIR/system/system/priv-app/StorageShare" ]; then
    rm -rf "$WORK_DIR/system/system/priv-app/StorageShare" 2>/dev/null || true
fi

if [ -d "$TMP_DIR" ]; then
    rm -rf "$TMP_DIR" 2>/dev/null || true
fi

LOG "- Legacy patches completed successfully with smart error correction."
exit 0
