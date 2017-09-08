# BASH-for-SNMP
Bash script which fetches device informations, interface informations, SNMP status and routing table entries from routers using snmpwalk and snmpget  and displays them .
At each switch and router the SNMP is enabled by using the following command: 
<i>Snmp-server community public ro.</i>
The script file <b><i>snmpscript.sh </i></b> finds
1.	Device serial number 
2.	Device name 
3.	Then for each of the interfaces, displays (using one line per interface):
I.	Name of the interface 
II.	Type of interface 
III.	 MAC address 
IV.	 Operative status 
V.	Total number of packets in 
VI.	Total number of packets out vii. IP address 
4.	d) After printing this per-interface information, calculates and prints the total number of packets entering the device and leaving each device
5.	Routing table per device 
6.	Prints the total number of SNMP Get, Set and Trap requests received/sent by each device. 

 The script file <b><i>runinevery30.sh </i></b>runs in every 30 seconds (use a loop and “sleep”, do not use the crontab) to retrieve the above
