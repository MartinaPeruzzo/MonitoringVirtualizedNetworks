export DEBIAN_FRONTEND=noninteractive

#Startup commands go here
sudo ip addr add 192.168.0.2/23 dev enp0s8
#Network interface config
sudo ip link set dev enp0s8 up
#Defaul gateway set up
sudo ip route add 192.168.0.0/22 via 192.168.0.1
#Using Linux Traffic Control to limitate the bandwidth
sudo tc qdisc add dev enp0s8 root tbf rate 1mbit burst 64kbit latency 200ms
