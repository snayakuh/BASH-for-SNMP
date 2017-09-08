#!/bin/bash
n=1
for rt in  145 147 148 162 178
do
 echo "####################################################3### INFORMATION FOR DEVICE $n ################################################################"
 echo "Device Name         := $(snmpget -Oqv -v1 -c public 10.10.10.$rt SNMPv2-MIB::sysName.0 )"
 echo "Device Serial Number:= "
 echo "$(snmpwalk -Oqv -v1 -c public 10.10.10.$rt entPhysicalSerialNum)"
 echo "************************************************** INTERFACE INFO FOR ABOVE DEVICE $n ***********************************************************"
 intf=$(snmpget -Oqv -v1 -c public 10.10.10.$rt 1.3.6.1.2.1.2.1.0)
 echo "no of interface= $intf "
 IPacketperDev=0
 OPacketperDev=0
 for i in $(snmpwalk -Oqv -v1 -c public 10.10.10.$rt ifIndex)
 do
   echo "-----------------------------------------------------Information for Interface $i---------------------------------------------------------------------"
   echo "Name            := $(snmpget -Oqv -v1 -c public 10.10.10.$rt 1.3.6.1.2.1.31.1.1.1.1.$i)"
   echo "Type            := $(snmpget -Oqv -v1 -c public 10.10.10.$rt 1.3.6.1.2.1.2.2.1.3.$i )"
   echo "MAC             := $(snmpget -Oqv -v1 -c public 10.10.10.$rt 1.3.6.1.2.1.2.2.1.6.$i )"
   echo "Operative Status:= $(snmpget -Oqv -v1 -c public 10.10.10.$rt 1.3.6.1.2.1.2.2.1.8.$i )"
   uni=$(snmpget -Oqv -v1 -c public 10.10.10.$rt 1.3.6.1.2.1.2.2.1.11.$i )
   multi=$(snmpget -Oqv -v1 -c public 10.10.10.$rt 1.3.6.1.2.1.2.2.1.12.$i )
   tot=`expr $uni + $multi`
   echo "Total Packets IN (unicast + multicast) := $tot"
   Ouni=$(snmpget -Oqv -v1 -c public 10.10.10.$rt 1.3.6.1.2.1.2.2.1.17.$i )
   Omulti=$(snmpget -Oqv -v1 -c public 10.10.10.$rt 1.3.6.1.2.1.2.2.1.18.$i )
   Otot=`expr $Ouni + $Omulti`
   echo "Total Packets OUT(unicast + multicast) := $Otot"
   IPacketperDev=`expr $IPacketperDev + $tot`
   OPacketperDev=`expr $OPacketperDev + $Otot`
 done
  echo "IP addresses for interfaces   :=$(snmpwalk -Oqv -v1 -c public 10.10.10.$rt 1.3.6.1.2.1.4.20.1.1)"
  echo "Total Packets In at device $n  :=$IPacketperDev"
  echo "Total Packets OUT at device $n :=$OPacketperDev"
  echo "-------------------------------------------------routing table entry for device $n --------------------- ------------------------------"
  echo "only destination and next hop is printed and all others are excluded"
  echo "To print all info we can include OID as  1.3.6.1.2.1.4.21"
  snmpwalk  -v1 -c public 10.10.10.$rt 1.3.6.1.2.1.4.21.1.1
  snmpwalk  -v1 -c public 10.10.10.$rt 1.3.6.1.2.1.4.21.1.7
  echo "--------------------------Other Info at device $n --------------------------------------------------------"
  echo "Total No of GET  IN  :=$(snmpget   -Oqv -v1 -c public 10.10.10.$rt SNMPv2-MIB::snmpInGetRequests.0)"
  echo "Total No of GET  OUT :=$(snmpget   -Oqv -v1 -c public 10.10.10.$rt SNMPv2-MIB::snmpOutGetRequests.0)"

  echo "Total No of SET  IN  :=$(snmpget   -Oqv -v1 -c public 10.10.10.$rt SNMPv2-MIB::snmpInSetRequests.0)"

  echo "Total No of SET  OUT :=$(snmpget   -Oqv -v1 -c public 10.10.10.$rt SNMPv2-MIB::snmpInSetRequests.0)"
  echo "Total No of TRAP IN  :=$(snmpget   -Oqv -v1 -c public 10.10.10.$rt SNMPv2-MIB::snmpInTraps.0)"

  echo "Total No of TRAP OUT :=$(snmpget   -Oqv -v1 -c public 10.10.10.$rt SNMPv2-MIB::snmpOutTraps.0)"
  n=`expr $n + 1`
done

