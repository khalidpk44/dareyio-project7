# dareyio-project7 
# Prepare NFS Server
1. Spin up a new EC2 instance with RHEL Linux 8 Operating System.
2. Create and Configure 3 LVM on the Server and format them as xfs
3. Ensure there are 3 Logical Volumes. lv-opt lv-apps, and lv-logs
(Create mount points on /mnt directory for the logical volumes as follow:
Mount lv-apps on /mnt/apps – To be used by webservers
Mount lv-logs on /mnt/logs – To be used by webserver logs
Mount lv-opt on /mnt/opt – To be used by Jenkins server in Project 8)
4. Use gdisk utility to create new disks (sudo gdisk /dev/xvdf, sudo gdisk /dev/xvdg, sudo gdisk /dev/xvdh)
5. Enter n to create a new partition
6. Press enter to accept default partition no 1
7. Press enter to accept dfault first sector
8. Press enter to accept default last sector 
9. press 8E00 for type system and press enter
10. Press w to write table to disk and exit
11. Press Y to proceed
12. Repeat step 4 to 11 for other two disk as well
13. Use lsblk command to confirm the disk has been created
14. Run nfsserver_config.sh file (./nfsserver_config.sh)
15. Update /etc/fstab file so that the mount configuration will persist after restart of the server.
16. Run sudo blkid command to get UUID for apps, logs and opt (sudo blkid)
17. Open the /etc/fstab file and add the follwoing line (sudo vi /etc/fstab) (UUID=<UUID of Apps> /mnt/apps     xfs     defaults       0       0, 
UUID=<UUID of logs> /mnt/logs     xfs     defaults        0       0,
UUID=<UUID of opt> /mnt/opt      xfs     defaults        0       0
18. Run nfsserver_config1.sh to install and configure NFS Server (./nfsserver_config1.sh)
19. Configure access to NFS for clients within the same subnet, open /etc/exports file (sudo vi /etc/exports) and add the following code (/mnt/apps <Subnet-CIDR>(rw,sync,no_all_squash,no_root_squash, /mnt/logs <Subnet-CIDR>(rw,sync,no_all_squash,no_root_squash), /mnt/opt <Subnet-CIDR>(rw,sync,no_all_squash,no_root_squash))
20. Save the file and run sudo exportfs -arv command
21. Check which port is used by NFS and open it using Security Groups with rpcinfo -p | grep nfs command (In order for NFS server to be accessible from your client, you must also open following ports: TCP 111, UDP 111, UDP 2049)

  #  CONFIGURE THE DATABASE SERVER
1. Launch a new EC2 instance with UBUNTU 20.4 Operating System
2. Run dbserver.sh script (./dbserver.sh)
  
# Prepare the Web Servers
1. Launch 3 new EC2 instance with RHEL Linux 8 Operating System.
2. Run webserver.sh script (./webserver.sh) (change the private ip address for NFS Server)
3. add following line to /etc/fstab (<NFS-Server-Private-IP-Address>:/mnt/apps /var/www nfs defaults 0 0)
4. Deploy the tooling website’s code to the Webserver. Ensure that the html folder from the repository is deployed to /var/www/html
5. Update the website’s configuration to connect to the database (in /var/www/html/functions.php file). Apply tooling-db.sql script to your database using this command (mysql -h <databse-private-ip> -u <db-username> -p <db-pasword> < tooling-db.sql)
### Note 2: If you encounter 403 Error – check permissions to your /var/www/html folder and also disable SELinux sudo setenforce 0
To make this change permanent – open following config file sudo vi /etc/sysconfig/selinux and set SELINUX=disabledthen restrt httpd.
  
