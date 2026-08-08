#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'hardware/oplus',
    'hardware/qcom-caf/sm8850',
    'vendor/oneplus/sm8850-common',
    'vendor/qcom/opensource/commonsys-intf/display',
]


def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None

lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    (
        'libhcsutils',
    ): lib_fixup_vendor_suffix,
}

blob_fixups: blob_fixups_user_type = {
    (
        'odm/bin/nvram_diag',
        'odm/bin/nvram_server',
    ): blob_fixup()
        .binary_regex_replace(b'vendor.oplus.caihong.serialno', b'ro.boot.chipid' + 15 * b'\x00'),
    'odm/etc/init/init.camera_process.rc': blob_fixup()
        .regex_replace('    delete_recursion', '    #delete_recursion'),
    'odm/firmware/fastchg/25927/charging_hyper_mode_config.txt': blob_fixup()
        .regex_replace(r"(PROJECT:=)25978", r"\g<1>25927"),
    (
        'odm/lib64/libAlgoProcess.so',
        'odm/lib64/libEIS.so',
        'odm/lib64/libEISLive.so',
        'odm/lib64/libFaceBeautyJni.so',
        'odm/lib64/libFaceDistortionCorrection.so',
        'odm/lib64/libOPAlgoCamAiBeautyFaceRetouchCn.so',
        'odm/lib64/libOPAlgoCamAiUnifySkin.so',
        'odm/lib64/libOPAlgoCamFaceBeautyCap.so',
        'odm/lib64/libaiboost_te.so',
    ): blob_fixup()
        .clear_symbol_version('AHardwareBuffer_acquire')
        .clear_symbol_version('AHardwareBuffer_allocate')
        .clear_symbol_version('AHardwareBuffer_describe')
        .clear_symbol_version('AHardwareBuffer_lock')
        .clear_symbol_version('AHardwareBuffer_lockPlanes')
        .clear_symbol_version('AHardwareBuffer_release')
        .clear_symbol_version('AHardwareBuffer_unlock'),
    (
        'odm/lib64/libarcsoft_turbo_fusion_raw_portrait_super_night.so',
        'odm/lib64/libarcsoft_turbo_fusion_raw_super_night.so',
    ): blob_fixup()
        .clear_symbol_version('remote_register_buf')
        .clear_symbol_version('rpcmem_alloc')
        .clear_symbol_version('rpcmem_free')
        .clear_symbol_version('rpcmem_to_fd'),
    'odm/lib64/libAlgoProcess.so': blob_fixup()
        .replace_needed('android.hardware.graphics.common-V5-ndk.so', 'android.hardware.graphics.common-V7-ndk.so'),
    (
        'vendor/lib64/camera/components/com.qti.node.dewarp.so',
        'vendor/lib64/vendor.qti.hardware.camera.offlinecamera-service-impl.so',
    ): blob_fixup()
        .replace_needed('android.hardware.graphics.allocator-V1-ndk.so', 'android.hardware.graphics.allocator-V2-ndk.so'),
    (
        'vendor/lib64/camera/components/com.qti.node.fd.so',
        'vendor/lib64/hw/camera.qcom.core.so',
        'vendor/lib64/libcamxdumpinforecorder.so',
    ): blob_fixup()
        .replace_needed('libtinyxml2.so', 'libtinyxml2-v36.so'),
}  # fmt: skip

module = ExtractUtilsModule(
    'iceland',
    'oneplus',
    namespace_imports=namespace_imports,
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    add_firmware_proprietary_file=True,
)

if __name__ == '__main__':
    utils = ExtractUtils.device_with_common(
        module, 'sm8850-common', module.vendor
    )
    utils.run()
