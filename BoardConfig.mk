#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

USE_PREBUILT_KERNEL ?= true

# Partitions
BOARD_SUPER_PARTITION_SIZE := 14612955136

# Include the common OEM chipset BoardConfig.
include device/oneplus/sm8850-common/BoardConfigCommon.mk

DEVICE_PATH := device/oneplus/iceland

# Assert
TARGET_OTA_ASSERT_DEVICE := OP6547L1,OP657AL1

# Display
TARGET_SCREEN_DENSITY := 420

# Kernel
ifeq ($(USE_PREBUILT_KERNEL), true)
include device/oneplus/iceland-kernel/BoardConfig.mk
else
TARGET_KERNEL_ADDITIONAL_FLAGS += CONFIG_ICELAND_DTB=y OPLUS_WIFI_ONLY=true
endif

# Properties
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_DEFAULT_TOUCH_ROTATION := ROTATION_RIGHT

# SEPolicy
include $(DEVICE_PATH)/sepolicy/SEPolicy.mk

# Include the proprietary files BoardConfig.
include vendor/oneplus/iceland/BoardConfigVendor.mk
