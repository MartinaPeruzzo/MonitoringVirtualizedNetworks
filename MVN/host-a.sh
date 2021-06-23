export DEBIAN_FRONTEND=noninteractive

#Startup commands go here
sudo ip addr add 192.168.0.2/23 dev enp0s8
#Network interface config
sudo ip link set dev enp0s8 up
#Defaul gateway set up
sudo ip route add 192.168.0.0/22 via 192.168.0.1
sudo apt-get update
sudo apt -y install docker.io
sudo systemctl start docker
sudo tc qdisc add dev enp0s8 root tbf rate 1mbit burst 64kbit latency 200ms
