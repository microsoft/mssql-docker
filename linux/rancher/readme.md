# SQL Server Chart for Rancher
This helm chart provided for reference to help guide with  SQL Server deployments on SUSE Rancher with no warranties or support. While it will be geared towards using on Rancher it's simply a helm chart so can be used in any helm deployments.
 
## Prerequisites:
1. Kubernetes 1.19+ cluster 
1. [Helm >= 3.2 client](https://helm.sh/docs/intro/install) installed on the machine where you will deploy from
1. Connectivity to the Kubenetes cluster api endpoint from your machine
1. [kubeconfig](https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/) for the cluster you will deploy to with `cluster-admin` permissions.

## Chart Usage

### SQL Server EULA
NOTE: By deploying this Chart you are agreeing to the [SQL Server EULA](http://go.microsoft.com/fwlink/?LinkId=746388)

### Quickstart
1. Clone this repo.
1. Change to the repo directory
    - `cd linux/rancher`
1. Change the `sa` password in [values.example.yaml](./values.example.yaml)
1. Deploy the chart with:
    - `helm install --create-namespace -n sql-server -f values.example.yaml .`

### Defaults:
For chart defaults take a look at [values.yaml](./values.yaml). Some notable ones are:
- `mssql.pid` to change the SQL Server edition
- `statefulset.template.spec.containers.sqlServer.image` to change the deployed image

### StorageClasses
By default the chart uses the default storage class of the cluster. You can configure a 
CSI storage class for AKS/GKE/EKS. Please see [values.test.yaml](./values.test.yaml) for an example.
Further details are in [storageclass.yaml](./templates/storageclass.yaml)


## Contributing
Contributions are welcome. Please open a pull request. Remember to:
- bump the version in [Chart.yaml](./Chart.yaml#18) accordingly
- add any defaults to [values.yaml](./values.yaml)
- add variables to be tested in [values.test.yaml](./values.test.yaml)
- ensure the lint passes with `make lint`
- test your changes on a deployment
