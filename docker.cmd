ip link add link  enp9s0f0 name enp9s0f0.1108 type vlan id 1108
ip link set enp9s0f0.1108 up
docker network  create  -d macvlan --subnet=192.168.13.0/24 --gateway=192.168.13.1 -o parent=enp9s0f0.1108  macvlan1108

docker network connect macvlan2234 1c7d590d04da

apt -y update &&  apt -y upgrade && apt -y install iproute2
docker inspect 61548b4d1fa1 --format '{{.NetworkSettings.Networks.bridge.IPAddress}}'
docker inspect --format='{{json .NetworkSettings.IPAddress}}' 04bcffdaec34
