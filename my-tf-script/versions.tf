/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.47.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
  required_version = ">= 0.13"
}

provider "google" {
    credentials = file("/home/runner/work/_temp/105bf773-f0e2-4d81-a205-59dde38e65c8/terraform-bin plan -input=false -var-file=terraform.tfvars")
    project     = var.project
    region      = var.region
}
