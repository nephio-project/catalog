# cluster-gke-standard-autoscaling

## Description
sample description

## Usage

### Fetch the package
`kpt pkg get REPO_URI[.git]/PKG_PATH[@VERSION] cluster-gke-standard-autoscaling`
Details: https://kpt.dev/reference/cli/pkg/get/

### View package content
`kpt pkg tree cluster-gke-standard-autoscaling`
Details: https://kpt.dev/reference/cli/pkg/tree/

### Apply the package
```
kpt live init cluster-gke-standard-autoscaling
kpt live apply cluster-gke-standard-autoscaling --reconcile-timeout=2m --output=table
```
Details: https://kpt.dev/reference/cli/live/
