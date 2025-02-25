#!/bin/sh

fetch_pkgsrc() 
{
    if command -v pkgsrc >/dev/null 2>&1; then
        echo "[*] Success! [fetch_pkgsrc]: 'pkgsrc' is already installed on the system."
        exit 0
    else
        echo "[<==] Installing pkgsrc..."
        ftp https://cdn.NetBSD.org/pub/pkgsrc/current/pkgsrc.tar.xz
        xzcat pkgsrc.tar.xz | tar xvf -
        mv pkgsrc ~
        verify
    fi
}

verify()
{
    if [ -d /root/pkgsrc ]; then
        echo "[!] Error! [verify()]: 'pkgsrc' is not found after installation."
        return 1
    else
        echo "[!] Success! [verify()]: 'pkgsrc' is successfully found on the system after installation."
        return 0
    fi
}

fetch_pkgsrc

