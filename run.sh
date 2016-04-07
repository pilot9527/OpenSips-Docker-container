#!/bin/bash
sudo /etc/init.d/mysql start

/usr/local/sbin/opensipsdbctl create


if [[ -z $ADVERTISED_IP ]]; then
	echo "ERROR : "
	echo "請設定ADVERTISED_IP，ex: [ ADVERTISED_IP＝10.21.20.11 ]"
	exit 1
fi

if [[ -z $alias_IP ]]; then
	echo "ERROR : "
	echo "請設定alias_IP，ex: [ alias_IP＝10.21.20.11 ]"
	exit 1
fi

if [[ -z $listen_IP ]]; then
	echo "ERROR : "
	echo "請設定listen_IP，ex: [ listen_IP＝192.168.11 ]"
	exit 1
fi

echo "設定 advertised_address & alias_ip"

export advertised_address="10.26.1.25"\usr\local\etc\opensips\opensips.cfg
sed -i -e 's/#advertised_address=/advertised_address="${ADVERTISED_IP}" /g' /usr/local/etc/opensips/opensips.cfg
sed -i -e 's/#alias=/alias="${alias_IP}" /g' /usr/local/etc/opensips/opensips.cfg
sed -i -e 's/listen=udp:/listen=udp:${listen_IP} /g' /usr/local/etc/opensips/opensips.cfg
/usr/local/sbin/opensipsctl start
