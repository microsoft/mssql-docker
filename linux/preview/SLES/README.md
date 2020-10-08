# How to build a SQL Server on SLES container image

1. Ensure that host machine is running the same version of the SLES that you will build SQL Server 2019 container image, in this case we are using a host which is running SLES 12 SP 5 and building the SQL Server also on top of SLES 12 SP 5.

2. Please ensure the host machine is registered using the SUSEConnect command as documented here: https://www.suse.com/support/kb/doc/?id=000018564

3. You can verify that the host machine is registered using a command shown below, the output you should see the status as registered and other details like the regcode.
    ```
    SUSEConnect -s
    ```

**Steps to building SQL Server on SLES container image**

1.	Create the dockerfile as shown in the dockerfile command and save it into your working directory

2.	[optional] Customize the mssql.conf file. Example mssql.conf entries can be found here: https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-configure-mssql-conf?view=sql-server-2017#mssql-conf-format 

3.	Build the docker image. 
    ```
    docker build . -t mssql-sles-tools-nonroot
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
