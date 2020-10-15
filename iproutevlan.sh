ip link add link  ens1f1 name ens1f1.3001 type vlan id 3001
ip link set  ens1f1.3001 up
ip addr add 192.168.60.4/24 dev  ens1f1.3001
