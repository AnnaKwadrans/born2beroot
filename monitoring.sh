#arquitecture
arch=$(uname -a)

#physical CPU
fcpu=$(grep -c "physical id" /proc/cpuinfo)

#virtual CPU
vcpu=$(grep -c "processor" /proc/cpuinfo)

#RAM
ram_used=$(free --mega | awk '$1 == "Mem:" {print $3}')
ram_total=$(free --mega | awk '$1 == "Mem:" {print $2}')
ram_percent=$(free --mega | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}')

#disk usage
mem_in_use=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{memory_use += $3} END {print memory_use}')
mem_total=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{mem_res += $2} END {printf("%0.fGb\n"), mem_res/10>
mem_perc=$(df -m | grep "/dev/" | grep -v "/boot" | awk '{mem_use += $3} {mem_res += $2} END {printf ("%0.f")>

#CPU usage
cpu_id=$(vmstat 1 2 | tail -1 | awk '{printf $15}')
cpu_load=$(expr 100 - $cpu_id)
cpu_per=$(printf "%.1f" $cpu_load)

#last reboot
boot=$(who -b | awk '{print $3, $4}')

#LVM
lvm=$(if [ $(lsblk | grep -c "lvm") -gt 0 ]; then echo yes ; else echo no ; fi)

#active connections
tcp=$(ss -ta | grep -c "ESTAB")

#users
users=$(users | wc -w)

#IPv4/MAC
ip=$(hostname -I)
mac=$(ip link | grep "link/ether" | awk '{print $2}')

#sudo
sudo=$(journalctl _COMM=sudo | grep -c "COMMAND")



wall "Architecture: $arch
CPU physical: $fcpu
vCPU: $vcpu
Memory Usage: $ram_used/${ram_total}MB ($ram_percent)%
Disk Usage: $mem_in_use/$mem_total ($mem_perc%)
CPU load: $cpu_per%
Last boot: $boot
LVM use: $lvm
TCP Connections: $tcp
User log: $users
Network: IP $ip ($mac)
Sudo: $sudo cmd
"