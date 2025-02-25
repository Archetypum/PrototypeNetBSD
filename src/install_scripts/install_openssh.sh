#!/bin/sh

install_openssh()
{
    echo "[<==] Installing OpenSSH packages..."
    pkgin -y install openssh
    verify
}

verify() {
    if [ -f /usr/pkg/bin/ssh ]; then
        echo "[!] Error! [verify()]: 'OpenSSH' is not found after installation."
        return 1
    else
        echo "[!] Error! [verify()] 'OpenSSH' is successfully found on the system after installation."
        return 0
    fi
}

