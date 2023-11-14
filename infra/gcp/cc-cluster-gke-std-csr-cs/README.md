# cc-cluster-gke-std-csr-cs

## Description
Provisions a GKE Standard cluster with a single node pool and autoscaling
enabled. It also provisions a Cloud Source Repository, joins the cluster to a
Fleet, installs and enables Config Sync on the cluster, and points Config Sync
to the new Cloud Source Repository.

## Usage

The package should be cloned to the Config Controller's repository, or directly
applied to Config Controller via `kpt live apply` or `kubectl`.

* Requires the GCP context ConfigMap.
* The GKE cluster created will have the name used when cloning this package.
* The CSR created will have the name used when cloning this package.
* The project ID from the GCP context will be used for the cluster and CSR
  creation, as well as for the Fleet (that is, the cluster is assumed to be in
  the same project as the Fleet in this package).
* The nephio-config-sync service account will be used for Config Sync to access
  the repository via Workload Identity.
