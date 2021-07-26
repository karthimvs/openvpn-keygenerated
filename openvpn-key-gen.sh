#!/usr/bin/env bash

##############################################################################
#Ver = 1.0
#Description = Generate Openvpn-Server RSA Client Keys in Vyos 
#Author = KarthiMvs
##############################################################################

#Auto genrate Easy rsa user key

if [[ $(id -u) -eq 0 ]];
    then
        cd /etc/openvpn/easy-rsa/
        source ./vars
        echo
        read -p "Enter the start key value : " USERNAME
        echo
        read -p "Enter the Last Key Value  : " KEYS
        echo
while [ $USERNAME -le $KEYS ]
        do
           { echo -ne '\n\n\n\n\n\n\n\n\n\n' ; yes y ; } | ./build-key client$USERNAME >/dev/null 2>&1

           echo -e  "'\033[1;93m'client$USERNAME key file sucessfully created'\033[0m'"
           karthi=$(( USERNAME = USERNAME+1 ))
           datcop=$(( karthi = karthi-1))
        # Creating Backup folder to store RAW key files.
           mkdir -p /key-backup/users/client$karthi
           cp -ar ./samples/sample-unified-key.ovpn /key-backup/unified-keys/client$datcop.ovpn
        #Generating Unified keys from using raw key files.
        if [[ "$karthi"  == $karthi ]];
        then
                echo " " >> /key-backup/unified-keys/client$datcop.ovpn
                echo "<cert>" >> /key-backup/unified-keys/client$datcop.ovpn
                cat /etc/openvpn/easy-rsa/keys/client$datcop.crt >> /key-backup/unified-keys/client$datcop.ovpn
                echo "</cert>" >> /key-backup/unified-keys/client$datcop.ovpn
                echo " " >>  /key-backup/unified-keys/client$datcop.ovpn
                echo "<key>" >> /key-backup/unified-keys/client$datcop.ovpn
                cat /etc/openvpn/easy-rsa/keys/client$datcop.key >> /key-backup/unified-keys/client$datcop.ovpn
                echo "</key>" >> /key-backup/unified-keys/client$datcop.ovpn
        fi

sleep 1

        if [[ "$karthi"  == $karthi ]];
        then
                cp -ar /key-backup/unified-keys/client$datcop.ovpn /tmp/
                cp -ar /etc/openvpn/easy-rsa/keys/client$datcop.* /key-backup/users/client$datcop
	  sleep 1
	  	chmod 777 /tmp/client$datcop.ovpn
        fi

done

echo
echo
echo -e "'\033[1;32m'Your stuff are created sucessfully, Please collect keys from following location \"\tmp\" Thanks for the using me!!!'\033[0m'"
echo

else
	echo
	echo
        echo -e "'\033[1;31m'Your are not a root user'\033[0m'"
        echo
        echo -e "'\033[1;31m'Please run the script in root user'\033[0m'"
	echo
	echo
fi
