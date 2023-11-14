# cc-repo-csr

## Description
Package for provisioning a Google Cloud Source Repository via Config Controller.

This will create a CSR in the project associated with the injected GCP context,
with the name of the CSR set to the name of the package.

## Usage

The package should be cloned to the Config Controller's repository, or directly
applied to Config Controller via `kpt live apply` or `kubectl`.

* Requires the GCP context ConfigMap.
* The CSR created will have the name used when cloning this package.
