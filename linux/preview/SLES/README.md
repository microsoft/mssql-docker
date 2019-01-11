# How to build a SQL Server on SLES container image

**Prerequisites - Get SLES Container Images** 
SUSE Enterprise Linux Containers are not avalaible on any public repositories. Follow the steps below to get the container base OS locally:

a.	Activate the container module via yast by typing in ```yast2``` and following the prompts. 

b.	Search for the available SLES images with ```zypper se *-image```

c.	Install one of those images with zypper install, for example, ```zypper in sles12sp2-docker-image```

d.	List out the installed images with ```sle2docker list```

e.	Activate the image with sle2docker, for example ```sle2docker activate sles12sp1-docker.x86_64-1.0.5-Build10.18```

f.	Check that the image available with ```docker image ls```


For full details: https://www.suse.com/documentation/sles-12/singlehtml/book_sles_docker/book_sles_docker.html#docker.building.images

**Steps to building SQL Server on SLES container image**

1.	Copy the  SUSE_Linux_Enterprise_Server zypper repository and service files into this directory which is required for the *libsss_nss_idmap0* package. Example:
    ```
     sudo cp /etc/zypp/services.d/SUSE_Linux_Enterprise_Server_12_SP4_x86_64.service /path/to/dockerfile/
     sudo cp /etc/zypp/repo.d/SUSE_Linux_Enterprise_Server_12_SP4_x86_64:SLES12-SP4-Pool.repo /path/to/dockerfile/
    ```
2.	[optional] Customize the mssql.conf file. Example mssql.conf entries can be found here: https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-configure-mssql-conf?view=sql-server-2017#mssql-conf-format 

3.	Build the docker image. 
    ```
    docker build . -t mssql-sles
    ```
4. Run the docker image. 
    ```
    sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=<YourStrong!Passw0rd>' \
   -p 1433:1433 --name sql1 \
   -d mssql-sles
    ```
