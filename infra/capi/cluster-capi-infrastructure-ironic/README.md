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


## Adding image tags
The yaml generated by the above step does not add an image tag and uses the default `latest` for the tag, hence, follow below steps to add image tag.

1. Get the released version of a image tag or digest by looking up
    a. https://quay.io/repository/metal3-io/ironic?tab=tags for the ironic image
    b. https://quay.io/repository/metal3-io/ironic-ipa-downloader?tab=tags for the ironic-ipa-downloader image
2. Next, create a directory such as `/tmp/ironic` and copy the above generated `cluster-api-infrastructure-ironic.yaml` file to this directory.
3. ```bash
   cd /tmp/ironic
   kpt pkg init
   ```
4. Edit the `Kptfile` to add the below contents
   ```bash
    pipeline:
    mutators:
    - image: gcr.io/kpt-fn/set-image:v0.1.1
      configMap:
        name: quay.io/metal3-io/ironic
        newTag: v29.0.0
    - image: gcr.io/kpt-fn/set-image:v0.1.1
      configMap:
        name: quay.io/metal3-io/ironic-ipa-downloader
        digest: sha256:dd12162be596a4c23e53c87600292c19030b7029ebadcbd9f3789fa5379d4abf
    ```
5.  The new `Kptfile` contents would look similar to below
   ```bash
apiVersion: kpt.dev/v1
kind: Kptfile
metadata:
  name: ironic
  annotations:
    config.kubernetes.io/local-config: "true"
pipeline:
  mutators:
  - image: gcr.io/kpt-fn/set-image:v0.1.1
    configMap:
      name: quay.io/metal3-io/ironic
      newTag: v29.0.0
  - image: gcr.io/kpt-fn/set-image:v0.1.1
    configMap:
      name: quay.io/metal3-io/ironic-ipa-downloader
      digest: sha256:dd12162be596a4c23e53c87600292c19030b7029ebadcbd9f3789fa5379d4abf
info:
  description: cluster-api ironic operator provider package
   ```
6. Next, execute the `kpt fn render` to apply the mutators in the pipeline that will set the image tag,
```bash
/tmp/ironic$ kpt fn render
Package "ironic": 
[RUNNING] "gcr.io/kpt-fn/set-image:v0.1.1"
[PASS] "gcr.io/kpt-fn/set-image:v0.1.1" in 400ms
  Results:
    [info] apps/v1/Deployment/baremetal-operator-system/baremetal-operator-ironic spec.template.spec.containers.image: set image from quay.io/metal3-io/ironic to quay.io/metal3-io/ironic:v29.0.0
    [info] apps/v1/Deployment/baremetal-operator-system/baremetal-operator-ironic spec.template.spec.containers.image: set image from quay.io/metal3-io/ironic to quay.io/metal3-io/ironic:v29.0.0
    [info] apps/v1/Deployment/baremetal-operator-system/baremetal-operator-ironic spec.template.spec.containers.image: set image from quay.io/metal3-io/ironic to quay.io/metal3-io/ironic:v29.0.0
    [info] apps/v1/Deployment/baremetal-operator-system/baremetal-operator-ironic spec.template.spec.containers.image: set image from quay.io/metal3-io/ironic to quay.io/metal3-io/ironic:v29.0.0
[RUNNING] "gcr.io/kpt-fn/set-image:v0.1.1"
[PASS] "gcr.io/kpt-fn/set-image:v0.1.1" in 300ms
  Results:
    [info] apps/v1/Deployment/baremetal-operator-system/baremetal-operator-ironic spec.template.spec.initContainers.image: set image from quay.io/metal3-io/ironic-ipa-downloader to quay.io/metal3-io/ironic-ipa-downloader@sha256:dd12162be596a4c23e53c87600292c19030b7029ebadcbd9f3789fa5379d4abf

Successfully executed 2 function(s) in 1 package(s).
```
7. The updated `cluster-api-infrastructure-ironic.yaml` file with image tag set can next be uploaded the catalog repo.