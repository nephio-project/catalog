# kubeadm-cluster-template-staticip

## Description

kubeadm cluster provider package that supports cluster creation with static IP addressing.
Note that this is specific to creating a single node cluster.

## build

### Pre-requisistes:
- Ensure clusterctl is installed by following instructions at https://cluster-api.sigs.k8s.io/user/quick-start#install-clusterctl

### Generate the base cluster template
```
cat << EOF > exports.sh
export CLUSTER_APIENDPOINT_HOST=PLACEHOLDER_CLUSTER_APIENDPOINT_HOST
export CLUSTER_APIENDPOINT_PORT=PLACEHOLDER_CLUSTER_APIENDPOINT_PORT
export CTLPLANE_KUBEADM_EXTRA_CONFIG=""
export IMAGE_CHECKSUM=PLACEHOLDER_IMAGE_CHECKSUM
export IMAGE_CHECKSUM_TYPE=PLACEHOLDER_IMAGE_CHECKSUM_TYPE
export IMAGE_FORMAT=PLACEHOLDER_IMAGE_FORMAT
export IMAGE_URL=PLACEHOLDER_IMAGE_URL
export KUBERNETES_VERSION=PLACEHOLDER_KUBERNETES_VERSION
export WORKERS_KUBEADM_EXTRA_CONFIG=""
EOF

chmod +x exports.sh

source exports.sh

clusterctl generate cluster my-cluster --control-plane-machine-count 1 --worker-machine-count 0 > kubeadm-cluster-template-staticip.yaml

```

### Edits to be made to generated base template to support 
a) static ip assignment 
b) cluster control plane node access
c) parameterize resource field values by adding setter comments.

#### Changes to support static ip assignment

##### Create the `ippool.yaml` file with below contents.
NOTE: Use the command `kubectl explain IPPool.spec` to understand the fields.
```
apiVersion: ipam.metal3.io/v1alpha1
kind: IPPool
metadata:
  name: provisioning-pool
  namespace: default
spec:
  clusterName: my-cluster
  namePrefix: my-cluster-prov
  pools:
    - start: 172.168.14.37
      end: 172.168.14.47
  prefix: 27
```

##### Edit the base template to add `Metal3DataTemplate.spec.networkData` section for the `my-cluster-controlplane-template`
```bash
apiVersion: infrastructure.cluster.x-k8s.io/v1beta1
kind: Metal3DataTemplate
metadata:
  name: my-cluster-controlplane-template
  namespace: default
spec:
  clusterName: my-cluster
  networkData:
    links:
      ethernets:
        - type: "phy"
          id: "ens1f0"
          macAddress:
            fromHostInterface: "ens1f0"
            string: "b4:96:91:e0:31:64"
          mtu: 1500
    services:
      dns:
        - 172.168.14.35
    networks:
      ipv4:
        - id: "baremetal"
          link: "ens1f0"
          ipAddressFromIPPool: "provisioning-pool"
          routes:
            - gateway:
                string: 172.168.14.33
              network: 0.0.0.0
```

#### Changes to access the cluster control plane node

##### Add `KubeadmControlPlane.spec.kubeadmConfigSpec.users` data to the KubeadmControlPlane section named `my-cluster` to specify a user, hashed password and ssh key.
```bash
apiVersion: controlplane.cluster.x-k8s.io/v1beta1
kind: KubeadmControlPlane
metadata:
  name: my-cluster
  namespace: default
spec:
  kubeadmConfigSpec:
    initConfiguration:
      nodeRegistration:
        kubeletExtraArgs:
          node-labels: metal3.io/uuid={{ ds.meta_data.uuid }}
        name: '{{ ds.meta_data.name }}'
    joinConfiguration:
      controlPlane: {}
      nodeRegistration:
        kubeletExtraArgs:
          node-labels: metal3.io/uuid={{ ds.meta_data.uuid }}
        name: '{{ ds.meta_data.name }}'
    users:
    - name: PLACEHOLDER_USER_CTRL_NODE
      passwd: PLACEHOLDER_HASHED_PASSWD_CTRL_NODE
      sudo: "ALL=(ALL) NOPASSWD:ALL"
      lockPassword: false
      shell: /bin/bash
      sshAuthorizedKeys:
      - PLACEHOLDER_SSH_KEY_CTRL_NODE
  machineTemplate:
    infrastructureRef:
      apiVersion: infrastructure.cluster.x-k8s.io/v1beta1
      kind: Metal3MachineTemplate
      name: my-cluster-controlplane
      namespace: default
    nodeDrainTimeout: 0s
  replicas: 1
  rolloutStrategy:
    rollingUpdate:
      maxSurge: 1
    type: RollingUpdate
  version: PLACEHOLDER_KUBERNETES_VERSION
```

#### Changes to parameterize resource field values and add `setter` comments.

##### Create `create-setters.yaml` file to identify values of fields that can be parameterized and add `setter` comments.
```bash
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: create-setters-fn-config
  annotations:
    config.kubernetes.io/local-config: "true"
data:
  cluster-name: my-cluster
  namespace-value: default
  pods-cidr: |
    - 192.168.0.0/18
  services-cidr: |
    - 10.96.0.0/12
  services-domain: cluster.local
  ctrl-plane-ip: PLACEHOLDER_CLUSTER_APIENDPOINT_HOST
  ctrl-plane-port: PLACEHOLDER_CLUSTER_APIENDPOINT_PORT
  k8s-version: PLACEHOLDER_KUBERNETES_VERSION
  img-checksum: PLACEHOLDER_IMAGE_CHECKSUM
  img-checksum-type: PLACEHOLDER_IMAGE_CHECKSUM_TYPE
  img-format: PLACEHOLDER_IMAGE_FORMAT
  img-url: PLACEHOLDER_IMAGE_URL
  ippool-name: provisioning-pool
  ippool-start-ip: 172.168.14.37
  ippool-end-ip: 172.168.14.47
  ippoot-prefix: 27
  net-link-eth-id: "ens1f0"
  net-link-eth-mac-addr: "b4:96:91:e0:31:64"
  net-svc-dns: |
    - 172.168.14.35
  net-ipv4-id: "baremetal"
  net-ipv4-gw: 172.168.14.33
  net-ipv4-nw-addr: 0.0.0.0
  ctrl-node-user: PLACEHOLDER_USER_CTRL_NODE
  ctrl-node-hashed-passwd: PLACEHOLDER_HASHED_PASSWD_CTRL_NODE
  ctrl-node-ssh-key: PLACEHOLDER_SSH_KEY_CTRL_NODE

```

##### Add setter comments to the template files (ippool.yaml and kubeadm-cluster-template-staticip.yaml)
```bash
mkdir -p /tmp/kpt_setter

cd /tmp/kpt_setter

cp kubeadm-cluster-template-staticip.yaml /tmp/kpt_setter

cp ippool.yaml /tmp/kpt_setter

cp create-setters.yaml /tmp/kpt_setter

kpt pkg init

kpt fn eval --image ghcr.io/kptdev/krm-functions-catalog/create-setters:v0.1.0 --fn-config create-setters.yaml 
```

##### Upload the transformed `ippools.yaml` file and `kubeadm-cluster-template-staticip.yaml` file to the catalog repo