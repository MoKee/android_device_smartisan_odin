#!/bin/bash
#
# Copyright (C) 2018 The MoKee Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e

export DEVICE=odin
export DEVICE_COMMON=msm8953-common
export VENDOR=smartisan

export DEVICE_BRINGUP_YEAR=2018

./../../$VENDOR/$DEVICE_COMMON/extract-files.sh $@

MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi
MK_ROOT="$MY_DIR"/../../..

BLOB_ROOT="$MK_ROOT"/vendor/"$VENDOR"/"$DEVICE"/proprietary

# Camera
sed -i 's|/system/etc/|/vendor/etc/|g' $BLOB_ROOT/vendor/lib/libmmcamera2_sensor_modules.so

# Fingerprint - Idex
sed -i 's|idex_fingerprint\x00|fingerprint\x00\x00\x00\x00\x00\x00|g' $BLOB_ROOT/vendor/lib64/hw/fingerprint.idex.so
