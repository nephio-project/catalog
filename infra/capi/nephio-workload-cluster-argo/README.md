# workload-cluster-argo

## Description

Deploying this package to the Nephio management cluster will result in the
provisioning of a workload cluster, associated repository, tokens, secrets,
and other resources needed to fully register the new cluster with Nephio.

To accomplish this, the package will deploy additional packages to the management
cluster repo (for the cluster, repository, VLANIndex, and ArgoCD Application).
The names of those packages will be based on the name of the cluster-name. So, if this package
is cloned to the name "cluster-01", it will deploy additional packages:
"cluster-01-cluster", "cluster-01-repo", "cluster-01-vlanindex", and "cluster-01-argo-cd-app".

