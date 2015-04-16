#
# Cookbook Name:: bt_avaloq
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
case node['platform_family']
when 'rhel', 'fedora', 'redhat', 'centos'
  bash "install pre-reqs" do
    code <<-EOF



# Disk partitioning
yum -y install lvm2
pvcreate /dev/xvdf
vgcreate vg_da1 /dev/xvdf
lvcreate --name lv_orabin --size 25G vg_da1
lvcreate --name lv_XXX --size 99G vg_da1
mkfs.xfs /dev/mapper/vg_da1-lv_orabin
mkfs.xfs /dev/mapper/vg_da1-lv_XXX
mkdir /oraXXX
mkdir /orabin

##JP##cat << EOF >> /etc/fstab 
/dev/mapper/vg_da1-lv_XXX /oraXXX      xfs    defaults        1 2
/dev/mapper/vg_da1-lv_orabin /orabin   xfs    defaults        1 2
##JP##EOF

mount -a


# Config files
##JP##cat << EOF > /etc/auto.adaimnt
#
#       WBC SDI SOE for RHEL6
#       File: /etc/auto.adaimnt
#       Channel: ux_el6_x86-64_adai
#       V 1.0 - Ben Babich - Initial Version
#
# auto.adaimnt configuration for a guest

/adaimnt        -ro,soft,bg,intr   adai920:/adaistr/adai/main
/var_adaimnt    -soft,bg,intr      adai920:/adaistr/adai/var_main
##JP##EOF


chmod 644 /etc/auto.adaimnt

##JP##cat << EOF > /etc/auto.master
#
#       WBC SDI SOE for RHEL6
#       File: /etc/auto.master
#       Channel: ux_el6_x86-64_adai
#       V 1.0 - Ben Babich - Initial Version

# Use automount for ADAI Guests
/-      /etc/auto.adaimnt
##JP##EOF
chmod 644 /etc/auto.master

##JP##cat << EOF > /etc/security/limits.conf
#       WBC PS UNIX SOE for RHEL6
#	Specific for app=avaloq
#       File: /etc/security/limits.conf
#
#       V 1.0 - 16/03/2015 - Ben Babich - Initial Version
#   
#<domain>      <type>  <item>         <value>
#

oracle          soft    nproc           2048
oracle          hard    nproc           16384
oracle          soft    nofile          1024
oracle          hard    nofile          65536
oracle          hard    stack           10240
oracle          soft    stack           32768
##JP##EOF
chmod 644 /etc/security/limits.conf

##JP##cat << EOF > /etc/sudoers.d/avaloq
oracle ALL=NOPASSWD:    /orabin/app/oracle/product/11.2.0.4.3-61/root.sh -silent
oracle ALL=NOPASSWD:    /orabin/app/oracle/product/11.2.0.3.9-58/root.sh -silent
oracle ALL=NOPASSWD: /orabin/app/oracle/product/11.2.0.4.3-63/root.sh -silent
##JP##EOF
chmod 400 /etc/sudoers.d/avaloq


##JP##cat << EOF >> /etc/sysctl.conf

# Oracle Specifics
fs.aio-max-nr = 1048576
fs.file-max = 6815744
kernel.shmall = 2097152
kernel.shmmax = 536870912
kernel.shmmni = 4096
kernel.sem = 250 32000 100 128
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
##JP##EOF
chmod 600 /etc/sysctl.conf

# Create Users
groupadd -g 101 dba
useradd -u 100 -g 101 -d /home/oracle -c "Oracle User@\$(hostname)" -s /bin/ksh -m oracle

# Install missing packages
yumaction() {
        package=$2
        action=$1
	options=$3
        /usr/bin/yum -y $action $package $options > /dev/null 2>&1
        if [[ $? == 0 ]]
        then
                echo "Package $action success: $package"
        else
                echo "Package $action FAILED: $package"
        fi
}

yumaction install libaio
yumaction install autofs
yumaction install ksh 
yumaction install samba 
yumaction groupinstall "Development Tools"

# Turn services on
systemctl enable smb
systemctl enable autofs

#Define SID (Aliased short-name) - Later to be moved to facter (puppet)
shn=$(hostname -s)
sid="XXX"

#----------------------------------
# Description:
#   Create Avaloq Folder Structure
#
# Parameters:
#   none

mkdir -p /orabin/app/oracle
mkdir -p /ora/oradata/${sid}
mkdir -p /var/opt/sysman/bin
mkdir -p /var/opt/sysman/log
mkdir -p /var/opt/oracle/bin
mkdir -p /usr/local/bin
mkdir -p /var/opt/adai

# Fix ownership
chown -R oracle:dba /orabin
chown -R oracle:dba /oraXXX
chown -R oracle:dba /var/opt/oracle
chown -R oracle:dba /var/opt/sysman
chown -R oracle:dba /var/opt/adai

#----------------------------------------------------------------
# Variables
conf=/etc/samba/smb.conf

# Create Samba folder & Softlinks
mkdir /${sid}
chown oracle:dba /${sid}
ln -s /orabin/app/oracle/admin/${sid}/bdump /${sid}/bdump
ln -s /orabin/app/oracle/admin/${sid}/udump /${sid}/udump
ln -s /orabin/app/oracle/admin/${sid}/diag /${sid}/diag
ln -s /home/oracle/aaa/img /${sid}/img
ln -s /home/oracle/aaa/log /${sid}/oralog
ln -s /orabin/app/oracle/admin/${sid}/aaa/io /${sid}/aaaio
ln -s /orabin/app/oracle/admin/${sid}/aaa/log /${sid}/aaalog
ln -s /orabin/app/oracle/admin/relman/log /${sid}/relmanlog

##JP##cat << EOT >$conf
[global]
comment = Adai Server ${hostname}
server string = ${hostname}
workgroup = WORKGROUP
security = SHARE
local master = yes
dns proxy = no
force user = oracle
force group = dba
read only = yes
create mask = 640
directory mask = 775
guest ok = yes
guest account = oracle
browseable = yes

[aaaio]
comment = ${sid} io directory (rw)
path = /${sid}/aaaio
read only = no

[aaalog]
comment = ${sid} log directory (ro)
path = /${sid}/aaalog

[bdump]
comment = ${sid} bdump directory (ro)
path = /${sid}/bdump

[oralog]
comment = ${sid} oralog directory (rw)
path = /${sid}/oralog
read only = no

[diag]
comment = ${sid} diag directory (ro)
path = /${sid}/diag

[udump]
comment = ${sid} udump (ro)
path = /${sid}/udump

[img]
comment = ${sid} img (rw)
path = /${sid}/img
read only = no

[relmanlog]
comment = ${sid} relmanlog directory (ro)
path = /${sid}/relmanlog
##JP##EOT

# Remove bashrc
rm -f '/home/oracle/.bashrc'

##JP##echo $(ifconfig eth0|grep "inet "|awk '{print $2}'|cut -f 2 -d :) XXX >> /etc/hosts



    EOF
  end
else
  Chef::Log.fatal(
    '"bt_avaloq" not supported'
  )
end