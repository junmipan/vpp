#!/bin/bash
# Copyright (c) 2017 Cisco and/or its affiliates.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at:
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# fail in case of error
set -e

# default values for build args and VPP commit ID
export DOCKER_BUILD_ARGS=""
export VPP_COMMIT_ID=""

# override defaults from arguments
while [ "$1" != "" ]; do
    case $1 in
        -d | --docker-build-args )
            shift
            export DOCKER_BUILD_ARGS=$1
            echo "Using Docker build args: ${DOCKER_BUILD_ARGS}"
            ;;
        -v | --vpp )
            shift
            export VPP_COMMIT_ID=$1
            echo "Using VPP commit ID: ${VPP_COMMIT_ID}"
            ;;
        * )
            echo "Invalid parameter: "$1
            exit 1
    esac
    shift
done

# builds contiv-vswitch (a specific VPP commit ID can be specified as the argument of the build.sh script)
cd contiv-vswitch
./build.sh

# builds all contiv plugins
cd ../contiv-plugins
./build.sh