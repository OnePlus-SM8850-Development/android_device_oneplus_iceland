#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Inherit from iceland device
$(call inherit-product, device/oneplus/iceland/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_tablet_wifionly.mk)

PRODUCT_NAME := lineage_iceland
PRODUCT_DEVICE := iceland
PRODUCT_MANUFACTURER := OnePlus
PRODUCT_BRAND := OnePlus
PRODUCT_MODEL := OPD2514
PRODUCT_CHARACTERISTICS := nosdcard,tablet

PRODUCT_GMS_CLIENTID_BASE := android-oneplus

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="qssi_64-user 16 BP2A.250605.015 1782819369982 release-keys" \
    BuildFingerprint=OnePlus/OPD2514IN/OP657AL1:16/BP2A.250605.015/B.R4T3.2d0ffd0-8961fd-8b49a5:user/release-keys \
    DeviceName=OP657AL1 \
    DeviceProduct=OPD2514 \
    SystemDevice=OP657AL1 \
    SystemName=OPD2514
