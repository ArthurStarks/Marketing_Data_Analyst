#!/bin/bash
# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


if [ $# != 3 ]; then
    echo "Usage: $0 gcp_project_id bucket_name region"
    exit 1
fi

gcloud config set project $1
token=$(gcloud auth application-default print-access-token)
curl -H "Authorization: Bearer $token" -H "Content-Type:application/json" "https://dataflow.googleapis.com/v1b3/projects/$1/locations/$3/templates:launch?gcsPath=gs://$2/templates/mds" --data-binary "@cloud_config/scheduler.json"
