# WIP 

## TODO: 
- DNS, certs
- Challenge cluster
- cluster hardening


# CTFd-HA-v2

V2 of HS-CTF infra. This year we're doing multicluster. The architecture will be fairly simple on the Kubernetes-side of things. Two clusters (red and blue), one for infra and one for challenges. This allows for tightening up the security individually. Considering if we should use Open policy agent to lock down blue even more, by disallowing certain pods to run. 

In Red each challenge get their own namespace, and netpols should be a thing we utilize heavily. Here, we can deploy OPA (alternative to PSP now that it's retired, and new K8S native replacement is still in alpha/beta) to disallow all pods that doesn't come from the private challenge registry. With exceptions for Prometheus and OPA, of course. 

One Prometheus install in each cluster, but only Grafana in blue. Grafana ingress and eg Prometheus and alertmanager could be hidden behind IAP as well.

Old upstream: https://github.com/mtverraen/ctfd-ha

## Pipeline

ArgoCD? GH actions?

Pipeline must build docker-image / push to registry, then push to CTFd through API and also deploy neccessary resources to the Red cluster + update DNS. Ideally, The Prometheus blackbox exporter should automagically create a probe for it as well. 

Look at [ctfup](https://github.com/csivitu/ctfup). This does not support different deployment models. We need CRDs like servicemonitors and the possiblity to expose loadbalancers. Challenges will either be exposed through Ingress or directly as a loadbalancer. 

## Coms
Monitoring goes through grafana. Unsure if we should make alertmanager alarms or just use grafana.
Discord bot calling out first bloods could be cool: Kuwu-bot https://github.com/csivitu/Kuwu#installation


## Upstream:

https://github.com/mtverraen/ctfd-ha

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