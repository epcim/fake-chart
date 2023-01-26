
This is fake-helm chart, to be used with [kluctl.io](kluctl.io) to deploy "pure" go templated formated manifests for Kubernetes.

Templated manifests to be stored under `fake-helm/manifests`. I use [vendir](https://carvel.dev/vendir/) to synchronize all
resources into subfolders.


## Example

helm-chart.yml:
```yaml
helmChart:
  path: fake-chart
  releaseName: argo-cd
  namespace: argo

  # kluctl addon:
  output: deploy.yml
```


helm-values.yml:
```yaml
argo_bootstrap: true
```

vendir.yml
```yaml
# https://carvel.dev/vendir/docs/v0.32.0/vendir-spec/

apiVersion: vendir.k14s.io/v1alpha1
kind: Config
directories:
- path: .tools
  contents:
  - path: kluctl
    git:
      url: https://github.com/kluctl/kluctl
      ref: origin/main
  - path: kluctl-examples
    git:
      url: https://github.com/kluctl/kluctl-examples
      ref: origin/main
- path: .repos
  contents:
  - path: cicd-deployment
    git:
      url: git@gitlab.com:myorg/mysub/cicd-deployment.git
      ref: origin/master

# upload templates to fake helm charts
- path: deploy-service/argo/fake-chart/manifests
  contents:
  - path: .
    directory:
      path: .repos/cicd-deployment/argo/k8s/argo-cd
    excludePaths:
      - "*.matrix"
```
