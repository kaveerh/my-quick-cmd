sudo  ovs-vsctl add-port   ovsbr1 vlan819 tag=819 -- set interface vlan819 type=internal
sudo ovs-vsctl set  port p3p1 trunk=230,231,232,233,240,242,800,819,882,992,993,1997,1998
