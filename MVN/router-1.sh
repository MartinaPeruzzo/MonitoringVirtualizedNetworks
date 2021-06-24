export DEBIAN_FRONTEND=noninteractive

#Startup commands go here
#Enable routing
sudo sysctl -w net.ipv4.ip_forward=1
#Network and VLAN interface config
sudo ip link add link enp0s8 name enp0s8.1 type vlan id 1
sudo ip link add link enp0s8 name enp0s8.2 type vlan id 2
sudo ip addr add 192.168.0.1/23 dev enp0s8.1
sudo ip addr add 192.168.2.1/23 dev enp0s8.2
#Using Linux Traffic Control to limitate the bandwidth
sudo tc qdisc add dev enp0s8.1 root tbf rate 1mbit burst 64kbit latency 200ms
sudo tc qdisc add dev enp0s8.2 root tbf rate 1mbit burst 64kbit latency 200ms
sudo ip link set dev enp0s8 up

