# fluxcd

## Description
Deployment of the following fluxcd core components. Helm controller, Kustomize controller, Source Controller, Notification controller

## Usage

### Fetch the package
`kpt pkg get REPO_URI[.git]/PKG_PATH[@VERSION] fluxcd`
Details: https://kpt.dev/reference/cli/pkg/get/

### View package content
`kpt pkg tree fluxcd`
Details: https://kpt.dev/reference/cli/pkg/tree/

### Apply the package
```
kpt live init fluxcd
kpt live apply fluxcd --reconcile-timeout=2m --output=table
```
Details: https://kpt.dev/reference/cli/live/
