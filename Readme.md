# CTFd-HA

High availablity deployment of CTFd on Kubernetes. 

## Setup

variables can be added easily with a .tfvars file. See hs_ctf.tfvars

```
export PROJECT=my-project
export LOCATION=europe-north1
gcloud config set project $PROJECT
```

Create Google Cloud Storage Bucket for Terraform State

```
export TERRAFORM_STATE_GCP_BUCKET=$PROJECT-tf-state

gsutil mb -b on -c standard -l $LOCATION gs://$TERRAFORM_STATE_GCP_BUCKET
```

Create Terraform Service Account

```
gcloud iam service-accounts create terraform
gcloud iam service-accounts keys create \
  --iam-account terraform@$PROJECT.iam.gserviceaccount.com \
  $PROJECT.json

gcloud projects add-iam-policy-binding $PROJECT \
  --member serviceAccount:terraform@$PROJECT.iam.gserviceaccount.com \
  --role roles/editor
```

Create Terraform Encryption Key

```
export GOOGLE_ENCRYPTION_KEY=$(openssl rand -base64 32)
export GOOGLE_APPLICATION_CREDENTIALS=$PROJECT.json
export GOOGLE_CREDENTIALS=$(cat $GOOGLE_APPLICATION_CREDENTIALS | tr -d '\n')
```

## hs_ctf.tfvars
```
cert_manager_enabled        = "false"
cloudflare_api_token        = ""
cloudflare_email            = ""
cloudflare_zone_id          = ""
cluster_name                = ""
domain                      = ""
google_project              = ""
google_region               = ""
google_zone                 = ""
grafana_password            = ""
kong_enabled                = true
node_pool_name              = ""
prometheus_blackbox_enabled = false
prometheus_blackbox_targets = ""
storage_bucket              = ""
```