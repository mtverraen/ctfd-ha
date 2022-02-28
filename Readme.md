# WIP 

## TODO: 
- Configure Kong
- Setup dns and tls




# CTFd-HA-v2

V2 of HS-CTF infra. This year we're doing multicluster. The architecture will be fairly simple on the Kubernetes-side of things. Two clusters (red and blue), one for infra and one for challenges. This allows for tightening up the security individually. Considering if we should use Open policy agent to lock down blue even more, by disallowing certain pods to run. 

In Red each challenge get their own namespace, and netpols should be a thing we utilize heavily. Here, we can deploy OPA (alternative to PSP now that it's retired, and new K8S native replacement is still in alpha/beta) to disallow all pods that doesn't come from the private challenge registry. With exceptions for Prometheus and OPA, of course. 

One Prometheus install in each cluster, but only Grafana in blue. Grafana ingress and eg Prometheus and alertmanager could be hidden behind IAP as well.

Previous year's CTF: https://github.com/mtverraen/ctfd-ha

## Pipeline

ArgoCD? 

Pipeline must build docker-image / push to registry, then push to CTFd through API and also deploy neccessary resources to the Red cluster + update DNS. Ideally, The Prometheus blackbox exporter should automagically create a probe for it as well. 

Look at [ctfup](https://github.com/csivitu/ctfup). This does not support different deployment models. We need CRDs like servicemonitors and the possiblity to expose loadbalancers. Challenges will either be exposed through Ingress or directly as a loadbalancer. 

## Coms
Monitoring goes through grafana. Unsure if we should make alertmanager alarms or just use grafana.
Discord bot calling out first bloods could be cool: Kuwu-bot https://github.com/csivitu/Kuwu#installation
