#!/bin/bash


set -x

# image should be downloaded from ubuntu site
hostname=$1
os_variant="ubuntu18.04"
baseimg=ubuntu-18.04-server-cloudimg-amd64.img
if [ ! -f ~/qmeu-run/$baseimg ]; then
  echo "ERROR did not find ~/Downloads/$baseimg"
  echo "Doing download...."
  wget https://cloud-images.ubuntu.com/bionic/current/$baseimg -O ~/qmeu-run/$baseimg
  echo ""
  echo "$baseimg downloaded now.  Run again"
#  exit 2
fi

if [ ! -f id_rsa ]; then
  echo "ERROR did not find ssh public/private key, generating now"
  ssh-keygen -t rsa -b 4096 -f id_rsa -N '' -q -C quickkey
  echo ""
  echo "The contents of id_rsa.pub need to be manually copied into cloud_init.cfg"
#  exit 3
fi

if [ ! -f /home/ubuntu/qmeu-run/$hostname ]; then
   echo create config file
   mykey=`cat /home/ubuntu/qmenu-run/id_rsa.pub`
   echo $mykey
   echo "set hostname"
   sed  s#\<insert-hostname\>#$hostname#g cloud_init.cfg > $hostname.cfg
   echo "add key to config"
   sed -i "s#insertkey#$mykey#g" $hostname.cfg
fi

snapshot=$hostname-snapshot-cloudimg.qcow2
seed=$hostname-seed.img
disk2=$hostname-extra.qcow2
# vnc|none
graphicsType=none

# create working snapshot, increase size to 5G
rm $snapshot
qemu-img create -b $baseimg -f qcow2 $snapshot 5G
qemu-img info $snapshot

# insert metadata into seed image
echo "instance-id: $(uuidgen || echo i-abcdefg)" > $hostname-metadata
cloud-localds -v --network-config=network_config_static.cfg $seed $hostname.cfg $hostname-metadata

# ensure file permissions belong to kvm group
chmod 666 $baseimg
chmod 666 $snapshot
sudo chown $USER:kvm $snapshot $seed

# create 2nd data disk, 20G sparse
rm $disk2
qemu-img create -f  qcow2 $disk2 20G
chmod 666 $disk2
sudo chown $USER:kvm $disk2
sudo virt-install --name $hostname \
  --virt-type kvm --memory 2048 --vcpus 2 \
  --boot hd,menu=on \
  --disk path=$seed,device=cdrom \
  --disk path=$snapshot,device=disk \
  --disk path=$disk2,device=disk \
  --graphics $graphicsType \
  --os-type Linux --os-variant $os_variant \
  --network network:default \
  --console pty,target_type=serial \
  --noautoconsole
