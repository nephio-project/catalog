# free5gc-cp

## Description
Package representing free5gc control plane NFs.

Package definition is based on [Towards5gs helm charts](https://github.com/Orange-OpenSource/towards5gs-helm), 
and service level configuration is preserved as defined there.

### Network Functions (NFs)

free5gc project implements following NFs:


| NF | Description | local-config |
| --- | --- | --- |
| AMF | Access and Mobility Management Function | true |
| AUSF | Authentication Server Function | false |
| NRF | Network Repository Function | false |
| NSSF | Network Slice Selection Function | false |
| PCF | Policy Control Function | false |
| SMF | Session Management Function | true |
| UDM | Unified Data Management | false |
| UDR | Unified Data Repository | false |

also Database and Web UI is defined:

| Service | Description | local-config |
| --- | --- | --- |
| mongodb | Database to store free5gc data | false |
| webui | UI used to register UE | false |

Note: `local-config: true` indicates that this resources won't be deployed to the workload cluster

### Dependencies

- `mongodb` requires `Persistent Volume`. We need to assure that dynamic PV provisioning will be available on the cluster
- `NRF` should be running before other NFs will be instantiated
    - all NFs packages contain `wait-nrf` init-container
- `NRF` and `WEBUI` require DB
    - packages contain `wait-mongodb` init-container
- `WEBUI` service is exposed as `NodePort` 
    - will be used to register UE on the free5gc side
- Communication via `SBI` between NFs and communication with `mongodb` is defined using K8s `ClusterIP` services
    - it forces you to deploy all NFs on a single cluster or consider including `service mesh` in a multi-cluster scenario

## Usage

### Fetch the package
`kpt pkg get REPO_URI[.git]/PKG_PATH[@VERSION] free5gc-cp`

Details: https://kpt.dev/reference/cli/pkg/get/

### View package content
`kpt pkg tree free5gc-cp`

Details: https://kpt.dev/reference/cli/pkg/tree/

### Apply the package
```
kpt live init free5gc-cp
kpt live apply free5gc-cp --reconcile-timeout=2m --output=table
```

Details: https://kpt.dev/reference/cli/live/

