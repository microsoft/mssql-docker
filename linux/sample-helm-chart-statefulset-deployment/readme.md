# Readme.md

This HELM chart is a sample "as-is" chart provided for reference to help guide with SQL Server deployment on Kubernetes cluster. 
 
## Prerequisites:
 
1.	This chart is built on helm v3. It requires a kubernetes cluster to be running for you to deploy SQL container using this chart. 
2.	Ensure you have the helm installed on the client from where you will connect to the kubernetes cluster to deploy using the helm chart.
3.	For minimum hardware requirement for the host to run SQL Server containers please refer to the system requirements section for SQL on Linux. 
4.	Requires the following variables to be set or changed in the values.yaml file :<br/> 
    a.  Please ensure that you accept the EULA for SQL Server, by changing the value of ACCEPT_EULA.value=y in values.yaml file or set it during the helm install command --set ACCEPT_EULA.value=Y.<br/> 
    b.	Please do choose the right edition of SQL Server that you would like to install you can change the value of the MSSQL_PID.value in the values file to the edition that you want to install or you can also 
        change it during the helm install command using the option --set MSSQL_PID.value=Enterprise, If you do not pass the flag and do not change it in the yaml, then by default it is going to install developer edition.<br/> c. Also please do provide your customized value for the sa_password, if you do not provide it then by default the sa_password will the value as shown in the below table.<br/> 
 
Note: Once you deploy SQL server containers using the chart below, please log into SQL Server using sa account and change the password for sa, this ensures that as DBA you have the control of the sa user and password.  
 
  
## Chart usage:
 
On the client machine where you have the Helm tools installed, download the chart on your machine and make the required changes to the values.yaml file as per your requirement. To see the list of settings that can be changed using the values.yaml file please refer to the table below.


 
|     Configuration parameters                 |     Description                                                                                                                                                                  |     Default_Value                      |
|----------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------- |
|     Values.image.repository                  |     The   SQL image to be downloaded and used for container deployment.                                                                                                          |     mcr.microsoft&#46;com/mssql/server |
|     Values.image.tag                         |     The   tag of the image to be download for the specific SQL image.                                                                                                            |     2019-latest                        |
|     Values.ACCEPT_EULA.value                 |     Set   the ACCEPT_EULA variable to any value to confirm your acceptance of   the SQL Server EULA, please refer environment   variable  for more details.                      |     Y                                  |
|     Values.MSSQL_PID.value                   |     Set   the SQL Server edition or product key. please refer environment   variable  for more details                                                                           |     Developer                          |
|     Values.MSSQL_AGENT_ENABLED.value         |     Enable   SQL Server Agent. For example, 'true' is enabled and 'false' is disabled. By   default, agent is disabled. please refer environment   variable for more details.    |     TRUE                               |
|     Values.containers.ports.containerPort    |     Port   on which the SQL Server is listening inside the container.                                                                                                            |     1433                               |
|     Values.podSecurityContext.fsgroup        |     Security   context at the pod level.                                                                                                                                         |     10001                              |
|     Values.service.port                      |     The   service port number.                                                                                                                                                   |     1433                               |
|     Values.replicas                          |     This value controls the number of SQL Server deployments that would be done, consider this as the number of SQL Server instances that will run.                              |     3                                  |

<br/>

## Deployment details:
 
> [!NOTE]
> Here are my deployment details, please make changes to the values.yaml or other files as per your requirement.
 
<br/>

In this scenario, I am deploying three SQL Server containers on a Azure Kubernetes Service (AKS) as statefulset deployments. You can follow [Setup and connect to AKS](https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough-portal) to read instructions on setting up AKS and connecting to it. Also the storage class that I am using here is "Azure-disk". Please do find details below for each of the yaml file used in the template folder of this chart.
 
| File Name | Description |
|-|-|
| _helpers.tpl | Template file with all the template definitions that will be used in this chart. |
| deployment.yaml | A manifest file to describing the deployment details for SQL Server. |
| mssqlconfig.yaml | SQL server   mssql.conf file and its content that you would like to mount to the SQL Server container. For parameters that you can pass in this file please refer mssql.conf documentation. To modify the mssql.conf settings please modify this file. |
| sc.yaml | A manifest file that describes the storage class (SC) to be deployed. To make any changes to the sc please modify this file accordingly. |
| service.yaml | A manifest file that defines the kubernetes service type and port. Because this is a statefulset deployment, this manifest files helps in creating the headless service. Please modify this for any service modification that is needed. |

<br/>

With this information, and probably after you have modified the required files you are now ready to deploy SQL Server using this chart. From the client machine where you have the helm chart installed, change the 
directory of the CLI to the directory where you have the chart downloaded and to deploy SQL Server using this chart run the command:
<br/>


``` bash 
helm install mssql . --set ACCEPT_EULA.value=Y --set MSSQL_PID.value=Developer
```
<br/>

After a few minutes this should deploy the SQL Server containers and you can see all the artifacts using the command :
<br/>

```bash
D:\helm-charts\sql-statefull-deploy>kubectl get all
```

The output should look as shown below:

<br/>

```bash
NAME                               READY   STATUS    RESTARTS   AGE
pod/mssql-sql-statefull-deploy-0   1/1     Running   0          12m
pod/mssql-sql-statefull-deploy-1   1/1     Running   0          12m
pod/mssql-sql-statefull-deploy-2   1/1     Running   0          12m

NAME                                   TYPE           CLUSTER-IP     EXTERNAL-IP       PORT(S)          AGE
service/mssql-sql-statefull-deploy     ClusterIP      None           <none>            1433/TCP         16m

NAME                                          READY   AGE
statefulset.apps/mssql-sql-statefull-deploy   3/3     16m
```

This chart also includes an extra folder called "services" this folder has two more manifest files as described below:

| Name             | Description                                                                                                                                                                                       |
|------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ex_service.yaml  | This containes sample code to create the external load balancer service for each of the pods created above, so SQL Server can be accessed outside the cluster                                     |
| ag_endpoint.yaml | This containes sample code to expose the AG endpoint ports within the cluster, so each pod can talk to one another on the AG port. This will be needed if you are setting up AG between the pods. |

<br/>

Once you deploy the above files as well, using the commands shown below, you should have an external load balancer service created for each of the pods and another cluster IP service for each of the pod exposing the AG (alwayson) port for each pod within the cluster. 


```bash
D:\helm-charts\sql-statefull-deploy>kubectl apply -f "D:\helm-charts\sql-statefull-deploy\services\ex_service.yaml"
D:\helm-charts\sql-statefull-deploy>kubectl apply -f "D:\helm-charts\sql-statefull-deploy\services\ag_endpoint.yaml"
```


Finally, after all the deployments here are the resources that you should see:


```bash
D:\>kubectl get all
NAME                               READY   STATUS    RESTARTS   AGE
pod/mssql-sql-statefull-deploy-0   1/1     Running   0          127m
pod/mssql-sql-statefull-deploy-1   1/1     Running   0          126m
pod/mssql-sql-statefull-deploy-2   1/1     Running   0          125m

NAME                                   TYPE           CLUSTER-IP     EXTERNAL-IP       PORT(S)          AGE
service/kubernetes                     ClusterIP      10.0.0.1       <none>            443/TCP          220d
service/mssql-mirror-0                 ClusterIP      10.0.148.0     <none>            5022/TCP         124m
service/mssql-mirror-1                 ClusterIP      10.0.254.58    <none>            5022/TCP         124m
service/mssql-mirror-2                 ClusterIP      10.0.196.129   <none>            5022/TCP         124m
service/mssql-sql-statefull-deploy     ClusterIP      None           <none>            1433/TCP         127m
service/mssql-sql-statefull-deploy-0   LoadBalancer   10.0.238.203   104.211.231.206   1433:30923/TCP   124m
service/mssql-sql-statefull-deploy-1   LoadBalancer   10.0.96.108    104.211.203.78    1433:32695/TCP   124m
service/mssql-sql-statefull-deploy-2   LoadBalancer   10.0.78.10     104.211.203.159   1433:31042/TCP   124m

NAME                                          READY   AGE
statefulset.apps/mssql-sql-statefull-deploy   3/3     127m
```

## Connect to SQL Server

Now you are ready to connect to the SQL Server using any of the familiar tools that you work with, like the [SSMS](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15) (SQL Server Management Studio) or [SQLCMD](https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility?view=sql-server-ver15) or [ADS](https://docs.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio?view=sql-server-ver15) (Azure Data Studio), etc. The IP address that you will use to connect is the External-IP address for the pod service which in this case one such example is: to connect to mssql-sql-statefull-deploy-0 SQL Server, the IP address 104.211.231.206 will be used in ssms or any other client.

For more details on the SQL Server deployment on AKS using manual method please refer [Deploy a SQL Server container in Kubernetes with Azure Kubernetes Services (AKS)](https://docs.microsoft.com/en-us/sql/linux/tutorial-sql-server-containers-kubernetes?view=sql-server-ver15).
