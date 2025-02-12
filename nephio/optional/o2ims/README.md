# O2IMS Operator 

This operator implements O-RAN O2 IMS cluster provisioning for K8s based cloud management.

The CRD used by the operator is a work in-progress in O-RAN standards. It is part of `O-RAN.WG6.TS.O-CLOUD-IM.0-R004-v03.00`
the work here is to provide a feedback to the standardization bodies with a PoC. 

The operator code is present in [nephio/operators/o2ims-operator](https://github.com/nephio-project/nephio/tree/main/operators/o2ims-operator). 

This repository contains the deployment files for the operator. 


## Usage

### Fetch the package
`kpt pkg get REPO_URI[.git]/PKG_PATH[@VERSION] o2ims`
Details: https://kpt.dev/reference/cli/pkg/get/

### View package content
`kpt pkg tree o2ims`
Details: https://kpt.dev/reference/cli/pkg/tree/

### Apply the package
```
kpt live init o2ims
kpt live apply o2ims --reconcile-timeout=2m --output=table
```

## Check operator is up and running
```
kubectl logs -n o2ims -l app.kubernetes.io/name=nephio-o2ims --tail=-1
```
