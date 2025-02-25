#!/bin/sh

install_thesuffocater() 
{
    echo "[<==] Installing Archetypum theSuffocater"
    git clone https://github.com/Archetypum/theSuffocater
    mv theSuffocater ~
    verify
}

verify()
{
    if [ ! -d /root/theSuffocater ]; then
        echo "[!] Error! [verify()]: 'theSuffocater' is not found after installation."
        return 1
    else
        echo "[!] Success! [verify()]: 'theSuffocater' is successfully found on the system after installation."
        return 0
    fi
}

install_thesuffocater

