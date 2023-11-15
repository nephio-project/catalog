# Infrastructure Blueprints for use in the GCP Installation

There are two types of packages here: ones that are intended to be applied to
the Nephio managment cluster (`nephio-*`), and those that are meant to be
applied to the Config Controller cluster (`cc-*`).

The Nephio managment cluster-bound packages typically include a PackageVariant
or PackageVariantSet which refer to the CC-bound packages as upstreams, and the
`config-control` repository itself as the downstream. The CC-bound packages will
not contain Nephio resources, but only resources that may be processed by
controllers found in CC.
