#!/bin/bash
#
#Name: idchange.sh.
#Package: Awesome Script System.
#Purpose: Change MAC address and hostname.
#Parameters: None.
#Author: Adam Webber.
#Date: 2019-10-28.
#

# Declare and initialise hexadecimal array.
declare -a HX=(0 1 2 3 4 5 6 7 8 9 a b c d e f)

# Declare and initialise array of MAC vendor strings. Use only those likely to be legitimate mobile devices in your country, as per http://standards-oui.ieee.org.
declare -a VN=(
	"48:ad:08" "2c:ab:00" "00:e0:fc" "80:38:bc" "64:a6:51" # Huawei
	"00:cd:fe" "18:af:61" "cc:44:63" "6c:72:e7" "08:74:02" # Apple
	"38:f2:3e" "38:25:6b" "30:0d:43" "60:7e:dd" "a4:51:6f" # Microsoft
	"80:7a:bf" "90:e7:c4" "7c:61:93" "2c:8a:72" "98:0d:2e" # HTC
	"4c:7f:62" "40:7a:80" "b0:5c:e5" "48:dc:fb" "6c:9b:02" # Nokia
	"6c:0e:0d" "b4:52:7d" "e0:63:e5" "00:0e:07" "00:1d:28" # Sony
	"30:96:fb" "f0:ee:10" "9c:d3:5b" "10:30:47" "38:d4:0b" # Samsung
	)

# Extract wireless interface name from ip link. Or just hard code the interface name.
WIFI=$(ip link | grep -o 'wl[^:]*')

# A couple of empty lines for easy reading.
echo -e '\n''\n'

# Get and show current hostname.
HN=$(hostname)
echo -e Your current hostname is: $HN

# Get and show current wireless interface name.
WIFI=$(ip link | grep -o 'wl[^:]*')
echo -e Your wireless interface name is: $WIFI

# Get and show current MAC address.
MAC=$(cat /sys/class/net/$WIFI/address)
echo -e Your current wifi MAC address is: $MAC

# Assemble new MAC sequence.
MAC=${VN[$(($RANDOM%15))]}:${HX[$(($RANDOM%15))]}${HX[$(($RANDOM%15))]}:${HX[$(($RANDOM%15))]}${HX[$(($RANDOM%15))]}:${HX[$(($RANDOM%15))]}${HX[$(($RANDOM%15))]}

# Disable current wireless interface.
echo -e -n Attempting to disable wireless interface $WIFI...
if ! ip link set dev $WIFI down
	then
		echo -e "\e[91mFAILED.\e39m"
		exit
	else
		echo -e "\e[32mSUCCEEDED.\e[39m"
	fi

# Generate new hostname.
echo -e -n Attempting to generate new hostname.
if ! HN=$(shuf -n1 /usr/share/dict/cracklib-small)
	then
		echo -e "\e[91mFAILED.\e[39m"
		exit
	else
		echo -e "\e[32mSUCCEEDED.\e[39m"
	fi

# Assign new hostname.
echo -e -n Attempting to assign new hostname...
if ! hostnamectl set-hostname $HN
	then
		echo -e "\e[91mFAILED.\e[39m"
		exit
	else
		echo -e "\e[32mSUCCEEDED.\e[39m"
	fi

# Generate new wifi MAC address.
echo -e -n Attempting to change wireless interface $WIFI MAC address...
if ! ip link set dev $WIFI address $MAC
	then
		echo -e "\e[91mFAILED.\e[39m"
		exit
	else
		echo -e "\e[32mSUCCEEDED.\e[39m"
	fi

# Enable wireless interface.
echo -e -n Attempting to enable wireless interface $WIFI...
if ! ip link set dev $WIFI up
	then
		echo -e "\e[91mFAILED.\e[39m"
		exit
	else
		echo -e "\e[32mSUCCEEDED.\e[39m"
	fi

# Echo current values.
echo -e Your new hostname is: $(hostname)
echo -e Your new MAC address for wireless interface $WIFI is: $(cat /sys/class/net/$WIFI/address)

# A couple of empty lines for easy reading.
echo -e '\n''\n'
