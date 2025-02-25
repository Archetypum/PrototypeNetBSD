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

