#!/bin/sh

install_main()
{
    if command -v pkgin >/dev/null 2>&1; then
        echo "[*] Success! [install_main()]: 'pkgin' found on the system."
        pkgin -y install bash git htop neofetch vim
        verify
    else
        echo "[!] Error! [install_main()]; 'pkgin' is not found on the system. Corrupted installation?"
        exit 1
    fi
}

verify()
{
    echo "[*] Installed packages locations:"
    whereis bash
    whereis git
    whereis htop
    whereis neofetch
    whereis vim
    echo "[*] The installation will proceed even if some of the required packages are not present on the system."
}

install_main

