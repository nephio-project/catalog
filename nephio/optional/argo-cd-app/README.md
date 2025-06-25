# argo-cd-app

## Description

Provisions an ArgoCD Applicationion, Respository, and Secrets for a Nephio workload cluster.
The provisioned resources will be named after the package name.

This package is designed to be deployed to the mgmt cluster's default namespace as a PackageVariant in  
an infra.nephio.org/v1alpha1/WorkloadCluster.

It assumes the existence of the following:

A git repository at http://<git-url:port>/nephio/<example-cluster-name>.git with an associated access token.
A WorkloadCluster kubeconfig for the target cluster in the mgmt cluster's default namespace.
ArgoCD deployed in the cluster in the argocd namespace.
ArgoCD's repo server patched with ArgoCD CMPs to handle creation of Apps and deployment of manifests.
