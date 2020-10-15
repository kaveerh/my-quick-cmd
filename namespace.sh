#create name name space
ip netns add blue
# create the vlan interface
ip link add link  ens1f0 name ens1f0.100 type vlan id 100
# bind interface to name space
ip link set ens1f0.100 netns blue
# enter name space
ip netns exec blue bash
# enable interface in name space
ip -c link set  ens1f0.100 up
# add ip address to name space
ip address add 192.168.1.2/24 dev ens1f0.100
# add route in name space
ip route add 192.168.1.0/24  dev ens1f1.200 via  192.168.2.1
cp /etc/resolv.conf /etc/netns/fortigate30e/
