# bmh_template

## Description
sample description

## Usage

### Fetch the package
`kpt pkg get REPO_URI[.git]/PKG_PATH[@VERSION] bmh_template`
Details: https://kpt.dev/reference/cli/pkg/get/

### View package content
`kpt pkg tree bmh_template`
Details: https://kpt.dev/reference/cli/pkg/tree/

### Apply the package
```
kpt live init bmh_template
kpt live apply bmh_template --reconcile-timeout=2m --output=table
```
Details: https://kpt.dev/reference/cli/live/