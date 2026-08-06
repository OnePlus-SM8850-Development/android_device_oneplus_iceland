#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

TARGET_IS_TABLET := true

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio/audio_module_config_primary.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/audio_module_config_primary.xml \
    $(LOCAL_PATH)/configs/audio/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    $(LOCAL_PATH)/configs/audio/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml

# Boot animation
TARGET_SCREEN_HEIGHT := 3392
TARGET_SCREEN_WIDTH := 2400

# Carrier
PRODUCT_VENDOR_PROPERTIES += \
    ro.carrier=wifi-only

# GMS
WITH_GMS_COMMS_SUITE := false

# Hardware
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml

# Init
PRODUCT_PACKAGES += \
    init.iceland.rc

# Input
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/idc/Vendor_22d9_Product_3869.idc:$(TARGET_COPY_OUT_ODM)/usr/idc/Vendor_22d9_Product_3869.idc

# Keylayout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/keylayout/Vendor_22d9_Product_3869.kl:$(TARGET_COPY_OUT_ODM)/usr/keylayout/Vendor_22d9_Product_3869.kl

# LiveDisplay
$(call soong_config_set_bool,OPLUS_LINEAGE_LIVEDISPLAY_HAL,ENABLE_AB,true)

# Overlays
PRODUCT_PACKAGES += \
    OPlusFrameworksResTarget \
    OPlusPenResTarget \
    OPlusSettingsProviderResTarget_CN \
    OPlusSettingsProviderResTarget_ROW \
    OPlusSystemUIResTarget

# Power
$(call soong_config_set,qtipower,tap_to_wake_node,/proc/touchpanel/double_tap_enable)

# Recovery
$(call soong_config_set_bool,recovery,target_recovery_uses_qti_drm,true)

# Regional properties
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/vendor/odm/etc/25927/build.default.prop:$(TARGET_COPY_OUT_ODM)/etc/25927/build.default.prop \
    $(LOCAL_PATH)/recovery/root/vendor/odm/etc/25978/build.EU.prop:$(TARGET_COPY_OUT_ODM)/etc/25978/build.EU.prop \
    $(LOCAL_PATH)/recovery/root/vendor/odm/etc/25978/build.IN.prop:$(TARGET_COPY_OUT_ODM)/etc/25978/build.IN.prop \
    $(LOCAL_PATH)/recovery/root/vendor/odm/etc/25978/build.NA.prop:$(TARGET_COPY_OUT_ODM)/etc/25978/build.NA.prop \
    $(LOCAL_PATH)/recovery/root/vendor/odm/etc/25978/build.ROW.prop:$(TARGET_COPY_OUT_ODM)/etc/25978/build.ROW.prop \
    $(LOCAL_PATH)/recovery/root/vendor/odm/etc/25978/build.default.prop:$(TARGET_COPY_OUT_ODM)/etc/25978/build.default.prop

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Wireless pen
PRODUCT_PACKAGES += \
    OplusPen

# Inherit from the common OEM chipset makefile.
$(call inherit-product, device/oneplus/sm8850-common/common.mk)

# Inherit from the proprietary files makefile.
$(call inherit-product, vendor/oneplus/iceland/iceland-vendor.mk)
