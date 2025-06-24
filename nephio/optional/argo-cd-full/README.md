# argocd-full

## Description
kpt package for deploying argocd-full

## Usage

### Fetch the package
`kpt pkg get REPO_URI[.git]/PKG_PATH[@VERSION] argocd-full`
Details: https://kpt.dev/reference/cli/pkg/get/

### View package content
`kpt pkg tree argocd-full`
Details: https://kpt.dev/reference/cli/pkg/tree/

### Apply the package
```
kpt live init argocd-full
kpt live apply argocd-full --reconcile-timeout=2m --output=table
```
Details: https://kpt.dev/reference/cli/live/
