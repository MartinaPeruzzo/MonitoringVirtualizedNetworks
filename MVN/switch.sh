export DEBIAN_FRONTEND=noninteractive
#Startup commands for switch go here
apt-get update
apt-get install -y tcpdump
apt-get install -y openvswitch-common openvswitch-switch apt-transport-https ca-certificates curl software-properties-common
#Switch ports config
sudo ovs-vsctl add-br switch
sudo ovs-vsctl add-port switch enp0s8
sudo ovs-vsctl add-port switch enp0s9 tag="1"
sudo ovs-vsctl add-port switch enp0s10 tag="2"
#Using Linux Traffic Control to limitate the bandwidth
sudo tc qdisc add dev enp0s8 root tbf rate 1mbit burst 64kbit latency 200ms
sudo tc qdisc add dev enp0s9 root tbf rate 1mbit burst 64kbit latency 200ms
sudo tc qdisc add dev enp0s10 root tbf rate 1mbit burst 64kbit latency 200ms
#Setting up links
sudo ip link set dev enp0s8 up
sudo ip link set dev enp0s9 up
sudo ip link set dev enp0s10 up
