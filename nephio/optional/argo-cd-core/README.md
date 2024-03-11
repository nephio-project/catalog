# argo-cd-core

## Description
kpt package for deploying argo-cd-core

## Usage

### Fetch the package
`kpt pkg get REPO_URI[.git]/PKG_PATH[@VERSION] argo-cd-core`
Details: https://kpt.dev/reference/cli/pkg/get/

### View package content
`kpt pkg tree argo-cd-core`
Details: https://kpt.dev/reference/cli/pkg/tree/

### Apply the package
```
kpt live init argo-cd-core
kpt live apply argo-cd-core --reconcile-timeout=2m --output=table
```
Details: https://kpt.dev/reference/cli/live/
