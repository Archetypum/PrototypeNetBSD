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

