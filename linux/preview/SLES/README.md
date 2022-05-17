# How to build a SQL Server on SLES container image

1. Ensure that host machine is running the same version of the SLES that you will build SQL Server 2019 container image, in this case we are using a host which is running SLES15 SP3 and building the SQL Server also on top of SLES15 SP3.

2. Please ensure the host machine is registered using the SUSEConnect command as documented here: https://www.suse.com/support/kb/doc/?id=000018564

3. You can verify that the host machine is registered using a command shown below, the output you should see the status as registered and other details like the regcode.
    ```
    SUSEConnect -s
    ```

4. Depending on how your host machine is registered, setup your machine for SUSE [container-suseconnect](https://github.com/SUSE/container-suseconnect) correctly so the credentials can be made available to the container. Instructions differ for [RMT/SMT](https://github.com/SUSE/container-suseconnect#building-images-on-sle-systems-registered-with-rmt-or-smt), [on-demand/PAYG in the cloud](https://github.com/SUSE/container-suseconnect#building-images-on-demand-sle-instances-in-the-public-cloud), and [non SLES distros](https://github.com/SUSE/container-suseconnect#building-images-on-non-sle-distributions).

**Steps to building SQL Server on SLES container image**

1.	Create the dockerfile as shown in the dockerfile command and save it into your working directory

2.	[optional] Customize the mssql.conf file. Example mssql.conf entries can be found here: https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-configure-mssql-conf?view=sql-server-2017#mssql-conf-format 

3.	Build the docker image.

    when host is registered against RMT/SMT
    ```
    docker build . -t mssql-sles-tools-nonroot
    ```
    when host is on-demand or payg in the public cloud
    ```
    docker build --network host -t mssql-sles-tools-nonroot .
    ```
    when using non SLES distros (Note: building on non SLES distros will require [additonal changes](https://github.com/SUSE/container-suseconnect#building-images-on-non-sle-distributions) to the Dockerfile)
    ```
    docker build -t mssql-sles-tools-nonroot \
        --secret id=SUSEConnect,src=SUSEConnect \
        --secret id=SCCcredentials,src=SCCcredentials .
    ```

4. Confirm the image is successfully created using the command
    ```
    docker images
    ```
4. Run the docker image. 
    ```
    sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=<YourStrong!Passw0rd>' \
   -p 1433:1433 --name sql1 \
   -d mssql-sles-tools-nonroot
    ```
