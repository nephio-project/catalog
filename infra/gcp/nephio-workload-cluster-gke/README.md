# nephio-workload-cluster-gke

## Description

Deploying this package to the Nephio management cluster will result in the
provisioning of a GKE workload cluster, associated repository, and other
resources needed to fully register the new cluster with Nephio.

This is done by creating a WorkloadCluster, Porch Repository, and PackageVariant
resource in the management cluster, all named based upon the name used to clone
this package. The PackageVariant will in turn deploy a package to the
`config-control` repository to actually create the cluster and CSR.

## Usage

The package should be cloned to the Nephio management cluster's repository, or
directly applied to management cluster via `kpt live apply` or `kubectl`.

* Requires the GCP context ConfigMap.
* The following will all be named based upon the name used for cloning this
  package:
  * The WorkloadCluster resource in the management cluster.
  * The Porch Repository resource in the management cluster.
  * The PackageVariant resource in the management cluster.
  * The GKE cluster package in the config-control repository.
  * The GKE cluster
  * The Cloud Source Repository
* The project ID from the GCP context will be used for the cluster and CSR
  creation, as well as for the Fleet (that is, the cluster is assumed to be in
  the same project as the Fleet in this package).
* The nephio-config-sync service account will be used for Config Sync to access
  the repository via Workload Identity.
