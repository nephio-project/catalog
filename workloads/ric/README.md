# RIC packages

Packages for deploying the following are stored in the folder

- RIC custom controller
- RIC
- Workload cluster for RIC deployments

PackageVariant and PackageVariantSets for deploying RIC are also stored in this folder.

# Steps to manually deploy RIC on Nephio

## Step 0: Prerequisite

1. Nephio should be installed.
2. Regional cluster should be running.
3. Catalog repository need to be registered. 
   Since the RIC packages are in workloads/ric of https://github.com/nephio-project/catalog.git repository,
   we need to register the repository with --directory option

   e.g. kpt alpha repo register --namespace default https://github.com/nephio-project/catalog.git --directory=workloads/ric

   Also the following tags need to be created for upstream repository(https://github.com/nephio-project/catalog.git) used:
   1. workloads/oai/ric-operator/v1
   2. workloads/oai/pkg-example-ric/v1