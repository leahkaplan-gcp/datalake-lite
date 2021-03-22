# datalake-lite
Easily create a datalake on GCP to begin testing and using the functionality of the data platform.

## Pre-requisites
A GCP account with permissions to create a new project, some familiarity with Cloud Shell.

## Steps
1. [Create a new project](https://cloud.google.com/resource-manager/docs/creating-managing-projects)
1. [Create a service account](https://cloud.google.com/iam/docs/creating-managing-service-accounts) for terraform with **Project Editor** permissions.
1. [Launch Cloud Shell](https://cloud.google.com/shell/docs/launching-cloud-shell).
1. Add the code snippet below to your `$HOME/.customize_environment` file.  This ensures that terraform using IPv4 addresses to call out to the google APIs that will create services in your account. If you skip this step, you may encounter strange [intermittent errors](https://github.com/hashicorp/terraform-provider-google/issues/6782).
    ```
    export APIS="googleapis.com www.googleapis.com storage.googleapis.com iam.googleapis.com container.googleapis.com cloudresourcemanager.googleapis.com bigquery.googleapis.com notebooks.googleapis.com"
    for i in $APIS
    do
      echo "199.36.153.10 $i" >> /etc/hosts
    done
    ```
1. [Create a JSON account key](https://cloud.google.com/iam/docs/creating-managing-service-account-keys) and [save it to your Cloud Shell instance](https://cloud.google.com/shell/docs/uploading-and-downloading-files).
1. Clone this repository on your Cloud Shell instance. Cloud Shell has terraform pre-installed.
1. Copy the JSON account key for your terraform service account into this directory.
1. Edit the values in `terrform.tfvars` file.
1. Create the datalake using [terraform](https://learn.hashicorp.com/collections/terraform/gcp-get-started):
    ```
    terraform init
    
    terraform plan
    
    terraform apply
    ```
    
