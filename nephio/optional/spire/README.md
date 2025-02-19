# spire

## Description
sample description

## Usage

### Fetch the package
`kpt pkg get REPO_URI[.git]/PKG_PATH[@VERSION] spire`
Details: https://kpt.dev/reference/cli/pkg/get/

### View package content
`kpt pkg tree spire`
Details: https://kpt.dev/reference/cli/pkg/tree/

### Apply the package
```
kpt live init spire
kpt live apply spire --reconcile-timeout=2m --output=table
```
Details: https://kpt.dev/reference/cli/live/
