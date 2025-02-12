# focom-operator

## Description
Deployment of the FOCOM Operator bundle for Nephio 

## Usage

### Fetch the package
`kpt pkg get REPO_URI[.git]/PKG_PATH[@VERSION] focom-operator`
Details: https://kpt.dev/reference/cli/pkg/get/

### View package content
`kpt pkg tree focom-operator`
Details: https://kpt.dev/reference/cli/pkg/tree/

### Apply the package
```
kpt live init focom-operator
kpt live apply focom-operator --reconcile-timeout=2m --output=table
```
Details: https://kpt.dev/reference/cli/live/
