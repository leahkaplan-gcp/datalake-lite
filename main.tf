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

  labels = {
    env = "default"
  }

  access {
    role          = "OWNER"
    user_by_email = google_service_account.bqowner.email
  }

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

resource "google_service_account" "bqowner" {
  account_id   = "bigquery-owner"
  display_name = "BigQuery Owner Service Account"
}
