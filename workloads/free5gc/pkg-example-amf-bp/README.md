# pkg-amf

## Description
Example blueprint package for free5gc AMF network function

The blueprint package is modeled by multiple parties working together including
NF Vendors, Network Service Designers, NF Deployment Engineers, and Infra Deployment
Engineers to express the NF resource requirements on the infrastructure.

Resources in the blueprint package will be modified as the package moves through the 
Nephio toolchain. Modifications to the blueprint may be invoked manually as well as   
automated injections that are specific to the target workload cluster.

All blueprint package requirements must be fulfilled before the NF can be 
deployed to a workload cluster. 
  
## Usage

### Fetch the package
`kpt pkg get https://github.com/nephio-project/free5gc-packages/pkg-example-amf-bp@main`
Details: https://kpt.dev/reference/cli/pkg/get/

### View package content
`kpt pkg tree pkg-example-amf-bp`
Details: https://kpt.dev/reference/cli/pkg/tree/

### Apply the package
```
kpt live init pkg-example-amf-bp
kpt live apply pkg-example-amf-bp --reconcile-timeout=2m --output=table
```
Details: https://kpt.dev/reference/cli/live/