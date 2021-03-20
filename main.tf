terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.59.0"
    }
  }
}

provider "google" {

  credentials = file(var.credentials_file)

  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "datalake"
  friendly_name               = "datalake"
  location                    = var.region
}

resource "random_string" "bucket" {
  length  = 8
  special = false
  upper   = false
}

resource "google_storage_bucket" "bucket" {
  name     = "${var.project}-${random_string.bucket.result}"
  location = var.region
}

resource "google_notebooks_instance" "instance" {
  name = "ai-notebook"
  location = var.zone
  machine_type = "n1-standard-4"
  vm_image {
    project      = "deeplearning-platform-release"
    image_family = "tf-latest-cpu"
  }

  desired_status = "TERMINATED"
}
