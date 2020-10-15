sh -i .ssh/id_rsa_burn  root@ub10.myktt.net "tcpdump  -i ens1f1 -e -n -w -" | /usr/local/bin/wireshark -k -i -
