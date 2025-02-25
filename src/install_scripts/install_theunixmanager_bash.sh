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

