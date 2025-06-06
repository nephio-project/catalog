# bmh-template

## Description
BareMetalHost CRD template with minimal required fields

## Usage

### Fetch the package
`kpt pkg get REPO_URI[.git]/PKG_PATH[@VERSION] bmh-template`
Details: https://kpt.dev/reference/cli/pkg/get/

### View package content
`kpt pkg tree bmh-template`
Details: https://kpt.dev/reference/cli/pkg/tree/

### Apply the package
```
kpt live init bmh-template
kpt live apply bmh-template --reconcile-timeout=2m --output=table
```
Details: https://kpt.dev/reference/cli/live/