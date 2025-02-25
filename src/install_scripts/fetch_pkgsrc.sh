#!/bin/sh
#
# Copyright (C) 2025 Archetypum
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>

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

