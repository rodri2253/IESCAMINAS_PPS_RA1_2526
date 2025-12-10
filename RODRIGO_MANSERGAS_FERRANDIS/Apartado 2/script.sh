#!/bin/bash

if command -v ip >/dev/null 2>&1; then
    MAC=$(ip link show | awk '/link\/ether/ {print $2; exit}')
else
    MAC=$(getmac.exe | awk 'NR==4 {print $1}')
fi

OS=$(uname -s)

HOSTNAME=$(hostname)

USER=$(whoami)

echo "MAC: $MAC | Sistema Operativo: $OS | Equipo: $HOSTNAME | Usuario: $USER"
