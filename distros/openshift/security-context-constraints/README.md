# distros/openshift/security-context-constraints

## Security Context Constraints

OpenShift deployments require Security Context Constraints to be applied for containers to function properly. The ones defined here were identified through testing the deployment against an OpenShift cluster and creating SCCs. These are prerequisites, and should be applied before attempting to install Nephio components.

## Storage

Gitea requires storage to be configured on the OpenShift cluster. Whether LVM, Local Storage, etc. there needs to be storage and a default Storage Class for the Persistent Volumes to be allocated.