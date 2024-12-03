# flux-gitrepo-kustomize

## Description

Provisions Flux GitRepository Source and Kustomize CRs for a Nephio workload cluster.
Both the GitRepository and Kustomize CRs will be named after the package name.

This package is designed to be deployed to the mgmt cluster's default namespace as PackageVariant in  
an infra.nephio.org/v1alpha1/WorkloadCluster.

It assumes the existence of the following:

A git repository at http://<git-url:port>/nephio/<example-cluster-name>.git with an associated access token.
A WorkloadCluster kubeconfig for the target cluster in the mgmt cluster's default namespace.