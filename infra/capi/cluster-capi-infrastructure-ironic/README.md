# cluster-capi-infrastructure-ironic

## Description

cluster-api ironic package

## Pre-requisite

Install kustomize, refer https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/

## build

```
git clone https://github.com/metal3-io/baremetal-operator.git
cd baremetal-operator
kustomize build ironic-deployment/default > cluster-api-infrastructure-ironic.yaml
```

NOTE: 
The sources for the ironic-deployment/default/ironic_bmo_configmap.env are 
- https://book.metal3.io/ironic/ironic_installation#environmental-variables
- https://github.com/metal3-io/ironic-image

The below fields are pre-populated in the ironic-deployment/default/ironic_bmo_configmap.env file. Refer
https://github.com/metal3-io/baremetal-operator/blob/main/ironic-deployment/default/ironic_bmo_configmap.env

- HTTP_PORT
- PROVISIONING_INTERFACE
- DHCP_RANGE
- DEPLOY_KERNEL_URL
- DEPLOY_RAMDISK_URL
- IRONIC_ENDPOINT
- CACHEURL
- IRONIC_KERNEL_PARAMS
- IRONIC_INSPECTOR_VLAN_INTERFACES
- USE_IRONIC_INSPECTOR

Below fields were added to the ironic-deployment/default/ironic_bmo_configmap.env file  before generating the yaml file
- DNS_IP
- GATEWAY_IP
- IRONIC_BASE_URL
- DHCP_HOSTS
- DHCP_IGNORE
- IRONIC_RAMDISK_SSH_KEY
