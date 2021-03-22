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

resource "google_project_service" "ai-notebook-service" {
  project = var.project
  service = "notebooks.googleapis.com"

  disable_dependent_services = true
}

resource "google_project_service" "resourcemanager-service" {
  project = var.project
  service = "cloudresourcemanager.googleapis.com"

  disable_dependent_services = true
}

resource "google_project_service" "monitoring-service" {
  project = var.project
  service = "monitoring.googleapis.com"

  disable_dependent_services = true
}


resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "datalake"
  friendly_name               = "datalake"
  location                    = var.region
}


resource "google_storage_bucket" "bucket" {
  name     = "${var.project}-datalake-storage"
  location = var.region
}

resource "google_notebooks_instance" "instance" {
  depends_on = [google_project_service.ai-notebook-service]

  count = var.create_ai_notebook #conditional creation - if this is 1, will create, if 0, then no
  name = "ai-notebook"
  location = var.zone
  machine_type = "n1-standard-4"
  vm_image {
    project      = "deeplearning-platform-release"
    image_family = "tf-latest-cpu"
  }

}

