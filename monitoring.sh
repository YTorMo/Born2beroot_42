#!bin/bash\
hostnamectl | grep "Operating System:" | tr -d " " | cut -b 17- | awk '\{print "#OS : " $1\}'\
hostnamectl | grep "Architecture:" | tr -d " " | cut -b 14- | awk '\{print "#OS architecture: " $1\}'\
hostnamectl | grep "Kernel:" | tr -d " " | cut -b 8- | awk '\{print "#Kernel : " $1\}'\
getconf _NPROCESSORS_ONLN | awk '\{print "#CPU physical : " $1\}'\
cat /proc/cpuinfo | grep processor | wc -l | awk '\{print "#vCPU : " $1\}'\
free -m | awk 'NR==2\{printf "#Ram memory available : %sMB \\n", $7 \}'\
free -m | awk 'NR==2\{printf "#RAM memory in use : %.1f%% \\n", $3*100/$2 \}'\
df -h | awk '$NF=="/"\{printf "#Server memory available : %sB\\n", $4\}'\
df -h | awk '$NF=="/"\{printf "#Server memory in use : %s\\n", $5\}'\
top -bn1 | grep load | awk '\{printf "#CPU Load : %.1f%%\\n", $2\}'\
who -b | awk '\{printf "#Last boot : %s %s\\n", $3, $4\}'\
lsblk | grep lvm | awk '\{if ($1) \{print "#LVM use : yes";exit;\} else \{print "#LVM use : no"\}\}'\
netstat | grep ESTABLISHED | wc -l | awk '\{print "#Connections TCP : " $1 " ESTABLISHED"\}'\
who | cut -d " " -f 1 | sort -u | wc -l | awk '\{print "#User log : " $1\}'\
hostname -I | awk '\{print "#Network : IP " $1\}' | tr -d "\\n" && cat /sys/class/net/*/address | awk 'NR==1\{printf " (%s)\\n", $1\}'\
journalctl _COMM=sudo | grep COMMAND | wc -l | awk '\{print "#Sudo : " $1 " cmd"\}'}
