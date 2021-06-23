#!/bin/bash
vagrant up
PS3='Please enter your choice: '
options=("Collecting information host-a" "Collecting information host-b" "Collecting information router" "Collecting information switch" "Visualize information host-a" "Visualize information host-b" "Visualize information router" "Visualize information switch" "Visualize information bandwidth" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "Collecting information host-a")
            echo "$opt"
            echo "Processing..."
            VBoxManage metrics collect --period 4 --samples 1 worker-1 CPU/Loader/User,CPU/Load/Kernel,RAM/Usage/Used,Disk/Usage/Used,Net/Rate/Rx,Net/Rate/Tx,Guest/RAM/Usage/Total,Guest/RAM/Usage/Free | tee host-a.txt
            echo "You can find your information in 'host-a.txt'; to visualize it digit '5'"
            ;;
        "Collecting information host-b")
            echo "$opt"
            echo "Processing..."
            VBoxManage metrics collect --period 4 --samples 1 worker-2 CPU/Loader/User,CPU/Load/Kernel,RAM/Usage/Used,Disk/Usage/Used,Net/Rate/Rx,Net/Rate/Tx,Guest/RAM/Usage/Total,Guest/RAM/Usage/Free | tee host-b.txt
            echo "You can find your information in 'host-b.txt'; to visualize it digit '6'"
            ;;
        "Collecting information router")
            echo "$opt"
            echo "Processing..."
            VBoxManage metrics collect --period 4 --samples 1 Router CPU/Loader/User,CPU/Load/Kernel,RAM/Usage/Used,Disk/Usage/Used,Net/Rate/Rx,Net/Rate/Tx,Guest/RAM/Usage/Total,Guest/RAM/Usage/Free | tee router.txt        
            echo "You can find your information in 'router.txt'; to visualize it digit '7'"
            ;;
        "Collecting information switch") 
            echo "$opt"
            echo "Processing..."
            VBoxManage metrics collect --period 4 --samples 1 Switch CPU/Loader/User,CPU/Load/Kernel,RAM/Usage/Used,Disk/Usage/Used,Net/Rate/Rx,Net/Rate/Tx,Guest/RAM/Usage/Total,Guest/RAM/Usage/Free | tee switch.txt
            echo "You can find your information in 'switch.txt'; to visualize it digit '8'"
            ;;
        "Visualize information host-a")
            echo "$opt"
            cat host-a.txt
            ;;
        "Visualize information host-b")
            echo "$opt"
            cat host-b.txt
            ;;
        "Visualize information router")
            echo "$opt"
            cat router.txt
            ;;
        "Visualize information switch")
            echo "$opt"
            cat switch.txt
            ;;
        "Visualize information bandwidth")
            echo "$opt"
            echo "Please, choose a device"
            echo "Enter the number: (1) host-a, (2) host-b, (3) switch, (4) router or digit exit to quit"
read number

if test $number = "1"
    then
    echo "Processing..."
    vagrant ssh host-a -c "sudo tc qdisc show dev enp0s8"
    
else if test $number = "2"
    then
    echo "Processing..."
    vagrant ssh host-b -c "sudo tc qdisc show dev enp0s8"
else if test $number = "3"
    then
    echo "Please choose:"
    switchlist=("enp0s8" "enp0s9" "enp0s10" )
    select swl in "${switchlist[@]}"
    do
        case $swl in
            "enp0s8")
                echo "Processing..."
                vagrant ssh switch -c "sudo tc qdisc show dev enp0s8"
                ;;
            "enp0s9")
                echo "Processing..."
                vagrant ssh switch -c "sudo tc qdisc show dev enp0s9"
                ;;
            "enp0s10")
                echo "Processing..."
                vagrant ssh switch -c "sudo tc qdisc show dev enp0s10"
                ;;
            *) echo "Invalid entry."
                break
            ;;
        esac
    done
else if test $number = "4"
    then
    echo "Please choose:"
    routerlist=("enp0s8.2" "enp0s8.3")
    select rul in "${routerlist[@]}"
    do
        case $rul in
            "enp0s8.2")
                echo "Processing..."
                vagrant ssh router -c "sudo tc qdisc show dev enp0s8.2"
                ;;
            "enp0s8.3")
                echo "Processing..."
                vagrant ssh router -c "sudo tc qdisc show dev enp0s8.3"
                ;;
            *) echo "Invalid entry."
                break
            ;;
        esac
    done
else if test $number = "exit"
    then 
    echo "Quitting..."
    exit 1
else
    echo "Not a known interface"
    exit 1
    fi
fi
fi
fi
fi       
            ;;
            "Exit")
            break
            ;;
        *);;
    esac
done