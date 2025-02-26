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

install_de()
{
    echo "[*] Available deskop enviroments"
    echo "1. xfce (default)."
    echo "2. lxde."
    echo "3. lxqt."
    echo "4. mate."
    echo "[==>] Enter DE name:"
    
    while true; do
        read DE

        case "$DE" in
            "xfce")
                pkgin -y install xfce4 xfce4-extras
                break
                ;;
            "lxde")
                pkgin -y install lxde
                break
                ;;
            "lxqt")
                pkgin -y install lxqt
                break
                ;;
            "mate")
                pkgin -y install mate
                break
                ;;
            "")
                pkgin -y install xfce4 xfce4-extras
                break
                ;;
            *)
                echo "[!] Please enter a valid DE."
                break
                ;;
        esac
    done
}

verify()
{
    
}

install_de

