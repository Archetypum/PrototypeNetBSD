#!/bin/sh

install_sshield() 
{
    echo "[<==] Installing Archetypum SSHield..."
    git clone https://github.com/Archetypum/SSHield
    mv SSHield ~
    verify
}

verify()
{
    if [ ! -d /root/SSHield ]; then
        echo "[!] Error! [verify()]: 'SSHield' is not found after installation."
        return 1
    else
        echo "[!] Success! [verify()]: 'SSHield' is successfully found on the system after installation."
        return 0
    fi
}

install_sshield

