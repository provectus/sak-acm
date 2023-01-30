## Requirements

```
terraform >= 1.1
 ```

 
## Providers

| Name | Version |
|------|---------|
| aws | >= 3.0 |
| helm | >= 1.0 |
| kubernetes | >= 1.11 |
| local | >=2.1.0 |
# Nginx Ingress Controller

Based on <https://kubernetes.github.io/ingress-nginx>

## For Example with TLS offload

``` hcl
module "nginx" {
  depends_on   = [module.sak-acm]
  source       = "https://github.com/provectus/sak-nginx.git"
  argocd       = module.argocd.state
  conf = {
    "controller.service.targetPorts.http"                                                                = "http"
    "controller.service.targetPorts.https"                                                               = "http"
    "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-cert"         = module.clusterwide.this_acm_certificate_arn
    "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-backend-protocol" = "http"
    "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-ssl-ports"        = "https"
  }
  tags = {}
}
```

## Example without SSL or with cert-manager

``` hcl
module "nginx" {
  source       = "github.com/provectus/sak-nginx.git"
  argocd       = module.argocd.state
  conf = {}
  tags = {}
}
```

## Providers

| Name | Version |
|------|---------|
| helm | n/a |
| kubernetes | n/a |
| local | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| argocd | A set of values for enabling deployment through ArgoCD | `map(string)` | `{}` | no |
| aws\_private | Set true or false to use private or public infrastructure | `bool` | `false` | no |
| conf | A set of parameters to pass to Nginx Ingress Controller chart | `map` | `{}` | no |
| module\_depends\_on | A list of explicit dependencies for the module | `list` | `[]` | no |
| namespace | A name of the existing namespace | `string` | `""` | no |
| namespace\_name | A name of namespace for creating | `string` | `"ingress-system"` | no |

## Outputs

No output.

## Update version

- Found the latest stable version of the helm chart from <https://github.com/kubernetes/ingress-nginx/releases>
- Change the version in the default section, example:
To test the SAK_NGINX module

- Deploy SAK-NGINX by SAK (namespace ingress-system)
- Deploy sample backend app:

```
kubectl create deployment web --image=registry.k8s.io/echoserver:1.4 --namespace ingress-system
kubectl expose deployment web --type=NodePort --port=8080 --namespace ingress-system
```

- Get published hostname from column EXTERNAL-IP of ingress-Nginx: ```kubectl get svc -n ingress-system```
- Publish web app on ingress controller:
- Check the web app from <http://EXTERNAL-IP>
