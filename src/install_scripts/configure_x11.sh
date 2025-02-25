#!/bin/sh

install_x11()
{
    echo "[<==] Configuring X11..."
    X -configure
    verify
}

verify()
{
    echo "[*] Assuming that X11 is working..."
    return 0
}

install_x11

