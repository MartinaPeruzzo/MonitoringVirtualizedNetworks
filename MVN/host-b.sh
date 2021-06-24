export DEBIAN_FRONTEND=noninteractive

#Startup commands go here
#Download package information from all configured sources
sudo apt-get update
#Network interface config
sudo ip addr add 192.168.2.2/23 dev enp0s8
sudo ip link set dev enp0s8 up
#Using Linux Traffic Control to limitate the bandwidth
sudo tc qdisc add dev enp0s8 root tbf rate 1mbit burst 64kbit latency 200ms
#Defaul gateway set up
sudo ip route add 192.168.0.0/22 via 192.168.2.1

