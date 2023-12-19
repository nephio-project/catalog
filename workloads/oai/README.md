# OAI Packages

Packages for deploying the following are stored in the folder

- OAI RAN custom controller
- OAI CU-CP
- OAI CU-UP
- OAI DU
- OAI UE SIM
- Network for RAN and Core deployments
- Workload cluster for RAN and Core deployments

PackageVariant and PackageVariantSets for deploying OAI RAN are also stored in this folder.

# Steps to manually deploy OAI RAN on Nephio

Note: Scripts to automatically deploy OAI RAN on Nephio, will be available here: https://github.com/nephio-project/test-infra/tree/main/e2e/tests/oai

## Step 0: Prerequisite

1. Nephio should be installed.
2. Verify Network required for OAI RAN and Core should should be installed.
   Perform the following to verify in the Nephio management cluster.
3. Catalog repository need to be registered. 
   Since the OAI RAN packages are in workloads/oai of https://github.com/nephio-project/catalog.git repository,
   we need to register the repository with --directory option

   e.g. kpt alpha repo register --namespace default https://github.com/nephio-project/catalog.git --directory=workloads/oai

   Also the following tags need to be created for upstream repository(https://github.com/nephio-project/catalog.git) used:
   1. workloads/oai/oai-ran-operator/v1
   2. workloads/oai/pkg-example-cucp-bp/v1
   3. workloads/oai/pkg-example-cuup-bp/v1
   4. workloads/oai/pkg-example-du-bp/v1
   5. workloads/oai/pkg-example-ue-bp/v1
   
```bash
kubectl get networks
```
Verify output as shown below.

```console
    NAME               REPO_STATUS
    vpc-cu-e1-srl      True
    vpc-cudu-f1-srl    True
    vpc-internal-srl   True
    vpc-internet-srl   True
    vpc-ran-srl        True
```
3. OAI core components should be deployed before deploying OAI RAN.
   Steps are mentioned here: https://github.com/OPENAIRINTERFACE/oai-packages/blob/r2/README.md


## Step 2: Deploy OAI RAN NF operator

Execute the command as shown below in Nephio Management cluster

```bash
kubectl apply -f package-variants/oai-ran-operator.yaml
```
Check OAI RAN operators pods are in running state in all clusters.

```bash
kubectl get pods -n oai-ran-operators
```

## Step 3: Deploy OAI RAN NFs

Deploy OAI CU CP using the below command in Nephio Management cluster

```bash
kubectl apply -f package-variants/oai-cucp.yaml
```
Check OAI CU CP pod is in running state in regional cluster.

```bash
kubectl get pods -n oai-ran-cucp
```
Deploy OAI CU UP using the below command in Nephio Management cluster

```bash
kubectl apply -f package-variants/oai-cuup.yaml
```

Check OAI CU UP pod is in running state in edge cluster.

```bash
kubectl get pods -n oai-ran-cuup
```
Deploy OAI DU using the below command in Nephio Management cluster

```bash
kubectl apply -f package-variants/oai-du.yaml
```

Check OAI DU pod is in running state in edge cluster.

```bash
kubectl get pods -n oai-ran-du
```
