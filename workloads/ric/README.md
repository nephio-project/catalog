# OSC RIC packages
We will be deploying [OSC RIC](https://docs.o-ran-sc.org/en/latest/projects.html#near-realtime-ran-intelligent-controller-ric) using Nephio.

Packages for deploying the following are stored in the folder

- RIC custom controller
- RIC

PackageVariant and PackageVariantSets for deploying RIC are also stored in this folder.

# Steps to manually deploy RIC on Nephio

## Step 0: Prerequisite

1. Install Nephio as per the [user guide](https://github.com/nephio-project/docs/blob/main/content/en/docs/guides/install-guides/_index.md)
2. Follow [exercise to install OAI components](https://github.com/nephio-project/docs/blob/main/content/en/docs/guides/user-guides/exercise-2-oai.md) to setup regional cluster.RIC will be installed on the regional cluster.
3. Register the RIC repository using

```bash
 kpt alpha repo register --namespace default https://github.com/nephio-project/catalog.git --directory=workloads/ric
```

## Step 2: Deploy OSC-RIC operator

Execute the command as shown below in Nephio Management cluster

```bash
kubectl apply -f package-variants/ric-operator.yaml
```
Check RIC operator pod is in running state in regional clusters.

```bash
kubectl get pods -n ric-operators --context regional-admin@regional
```

## Step 3: Deploy OSC-RIC

Deploy RIC using the below command in Nephio Management cluster

```bash
kubectl apply -f package-variants/ric.yaml
```
Check RIC pods is in running state in regional cluster.

```bash
kubectl get pods -n ricplt --context regional-admin@regional
```