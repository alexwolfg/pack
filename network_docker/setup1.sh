#!/bin/bash

lan1="docker exec -it network_docker-host1-1"
lan2="docker exec -it network_docker-host2-1"
lan3="docker exec -it network_docker-host3-1"
switch="docker exec -it network_docker-switch-1"


create_setup () {
echo "Creating setup"

$lan1 ip addr add 10.0.1.2 dev eth1
$lan1 ip route add 10.0.0.0/16 dev eth1

$lan2 ip addr add 10.0.2.2 dev eth1
$lan2 ip route add 10.0.0.0/16 dev eth1

$lan3 ip addr add 10.0.3.2 dev eth1
$lan3 ip route add 10.0.0.0/16 de eth1

$switch ip addr add 10.0.1.1 dev eth1
$switch ip route add 10.0.1.0/24 dev eth1

$switch ip addr add 10.0.2.1 dev eth2
$switch ip route add 10.0.2.0/24 dev eth2

$switch ip addr add 10.0.3.1 dev eth3
$switch ip route add 10.0.3.0/24 dev eth3
}

delete_setup () {

echo "Deleting setup"
$lan1 ip addr del 10.0.1.2 dev eth1
#$lan1 ip route add 10.0.0.0/16 dev eth1

$lan2 ip addr del 10.0.2.2 dev eth1
#$lan2 ip route add 10.0.0.0/16 dev eth1

$lan3 ip addr del 10.0.3.2 dev eth1
#$lan3 ip route add 10.0.0.0/16 de eth1

$switch ip addr del 10.0.1.1 dev eth1
#$switch ip route add 10.0.1.0/24 dev eth1

$switch ip addr del 10.0.2.1 dev eth2
#$switch ip route add 10.0.2.0/24 dev eth2

$switch ip addr del 10.0.3.1 dev eth3
#$switch ip route add 10.0.3.0/24 dev eth3

}

if [ $# != 1 ]; then
    echo "Specify the input: delete or create"
elif [ $1 == "delete" ]; then
    delete_setup
elif [ $1 == "create" ]; then
    create_setup
else
    echo "Specify the input: delete or create"
fi