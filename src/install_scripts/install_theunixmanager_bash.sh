#!/bin/sh

install_theunixmanager_bash() 
{
    echo "[<==] Installing theUnixManager-bash..."
    git clone https://github.com/Archetypum/theUnixManager-bash
    mv theUnixManager-bash ~
    verify
}

verify()
{
    if [ ! -d /root/theUnixManager-bash ]; then
        echo "[!] Error! [verify()]: 'theUnixManager-bash' is not found after installation."
        return 1
    else
        echo "[!] Success! [verify()]: 'theUnixManager-bash' is successfully found on the system after installation."
        return 0
    fi
}

install_theunixmanager_bash

