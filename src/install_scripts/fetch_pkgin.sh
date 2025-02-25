#!/bin/sh

fetch_pkgin() 
{
    PKG_PATH=https://cdn.NetBSD.org/pub/pkgsrc/packages/NetBSD/"$(uname -p)"/"$(uname -r | cut -d_ -f1)"/All
    if command -v pkgin >/dev/null 2>&1; then
        echo "[*] Success! [fetch_pkgin()]: 'pkgin' is already installed on the system."
    else
        echo "[<==] Installing pkgin..."
        export PKG_PATH
        pkg_add pkgin 
        verify
    fi
}

verify()
{
    if [ ! -x /usr/pkg/bin/pkgin ]; then
        echo "[!] Error! [verify()]: 'pkgin' is not found after installation."
        return 1
    else
        echo "[!] Success! [verify()]: 'pkgin' is successfully found on the system after installation."
        return 0
    fi
}

fetch_pkgin

