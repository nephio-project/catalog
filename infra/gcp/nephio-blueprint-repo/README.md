# nephio-blueprint-repo

## Description

Package for provisioning Nephio blueprint repositories. This includes a
PackageVariant resource to create a Cloud Source Repository in GCP, and a Porch
Repository resource to register that with Nephio. The Porch respository will be
configured to authenticate to the CSR via Workload Identity.

This is used to create new team and organizational blueprint repositories; it
does not create *deployment* repositories that are used directly by clusters.

By default, it creates Organizational repositories. Change the label
`kpt.dev/repository-content` to `team-blueprints` to create a Team repository
instead.

## Usage

* Requires the GCP context ConfigMap.
* PackageVariant name and downstream package name (in the CC repository) will
  both be set to the name used when cloning this package.
