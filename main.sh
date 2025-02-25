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

AUTOINSTALL_CONF_FILE="src/etc/autoinstall.conf"
PROFILE_CONF_FILE="src/etc/profile.conf"

introduction()
{
    clear
    echo "-----------------------------------------------------------------------------------"
    echo "  _____           _        _                    _   _      _   ____   _____ _____  "
    echo " |  __ \         | |      | |                  | \ | |    | | |  _ \ / ____|  __ \ "
    echo " | |__) | __ ___ | |_ ___ | |_ _   _ _ __   ___|  \| | ___| |_| |_) | (___ | |  | |"
    echo " |  ___/ '__/ _ \| __/ _ \| __| | | | '_ \ / _ \ .   |/ _ \ __|  _< \___ \ | |  | |"
    echo " | |   | | | (_) | || (_) | |_| |_| | |_) |  __/ |\  |  __/ |_| |_) |____) | |__| |"
    echo " |_|   |_|  \___/ \__\___/ \__|\__, | .__/ \___|_| \_|\___|\__|____/|_____/|_____/ "
    echo "                                __/ | |                                            "
    echo "                               |___/|_| $(cat src/etc/prototype_version) for NetBSD $(cat src/etc/last_netbsd_version)"
    echo "-----------------------------------------------------------------------------------"
    echo "Made by Archetypum, licensed under GNU GPL v3."
    echo "Source code available at https://github.com/Archetypum/PrototypeNetBSD"
    echo "-----------------------------------------------------------------------------------"
}

get_automatic_or_manual()
{
    echo "[?] Enable automatic installation? (y/N)"
    while true; do
        read ANSWER
        case "$ANSWER" in
            [yY]*)
                AUTOINSTALL_VALUE="true"
                break
                ;;
            [nN]*)
                AUTOINSTALL_VALUE="false"
                break
                ;;
            "")
                AUTOINSTALL_VALUE="false"
                break
                ;;
            *)
                echo "[!] Please answer 'y' or 'n'."
                ;;
        esac
    done

    if [ ! -f "$AUTOINSTALL_CONF_FILE" ]; then
        echo "[!] Warning! [get_automatic_or_manual()]: Autoinstall configuration file not found. Corrupted installation?"
        echo "$AUTOINSTALL_VALUE" > "$AUTOINSTALL_CONF_FILE"\
        echo "[*] Success! [get_automatic_or_manual()]: Created autoinstall configuration file: $AUTOINSTALL_CONF_FILE with value: $AUTOINSTALL_VALUE."
    else
        echo "$AUTOINSTALL_VALUE" > "$AUTOINSTALL_CONF_FILE"
        echo "[*] Success! [get_automatic_or_manual()]: Log configuration set to: $AUTOINSTALL_VALUE in $AUTOINSTALL_CONF_FILE."
    fi
}

get_installation_profile()
{
    echo "\nAvailable installation profiles:"
    echo " - minimal."
    echo " - x11."
    echo " - desktop."
    echo " - server-openssh."
    echo " - server-ftp."
    echo " - server-vpn."
    echo " - server-dhcp."
    echo " - server-webserver."
    echo " - server-samba."
    
    echo "[==> Enter desired system profile: "
    while true; do
        read ANSWER
        case "$ANSWER" in
            "minimal")
                INSTALLATION_PROFILE="minimal"
                break
                ;;
            "x11")
                INSTALLATION_PROFILE="x11"
                break
                ;;
            "desktop")
                INSTALLATION_PROFILE="desktop"
                break
                ;;
            "server-openssh")
                INSTALLATION_PROFILE="server-openssh"
                break
                ;;
            "server-ftp")
                INSTALLATION_PROFILE="server-ftp"
                break
                ;;
            "server-vpn")
                INSTALLATION_PROFILE="server-vpn"
                break
                ;;
            "server-dhcp")
                INSTALLATION_PROFILE="server-dhcp"
                break
                ;;
            "server-webserver")
                INSTALLATION_PROFILE="server-webserver"
                break
                ;;
            "server-samba")
                INSTALLATION_PROFILE="server-samba"
                break
                ;;
            "")
                INSTALLATION_PROFILE="server-openssh"
                break
                ;;
            *)
                echo "[!] Please enter a valid installation profile."
                ;;
        esac
    done

    if [ ! -f "$PROFILE_CONF_FILE" ]; then
        echo "[!] Warning! [get_installation_profile()]: Installation profile configuration file not found. Corrupted installation?"
        echo "$INSTALLATION_PROFILE" > "$PROFILE_CONF_FILE"
        echo "[*] Success! [create_config_file()]: Created autoinstall configuration file: $AUTOINSTALL_CONF_FILE with value: $INSTALLATION_PROFILE."
    else
        echo "$INSTALLATION_PROFILE" > "$PROFILE_CONF_FILE"
        echo "[*] Success! [get_installation_profile()]: Log configuration set to: $INSTALLATION_PROFILE in $PROFILE_CONF_FILE."
    fi
}

begin_installation()
{
    INSTALLATION_PROFILE=$(cat src/etc/profile.conf)

    if [ "$INSTALLATION_PROFILE" = "minimal" ]; then
        sh src/install_scripts/fetch_pkgin.sh
        sh src/install_scripts/install_main.sh
    fi

    if [ "$INSTALLATION_PROFILE" = "x11" ]; then
        sh src/install_scripts/fetch_pkgin.sh
        sh src/install_scripts/install_main.sh
        sh src/install_scripts/install_x11.sh
    fi

    if [ "$INSTALLATION_PROFILE" = "desktop" ]; then
        sh src/install_scripts/fetch_pkgin.sh
        sh src/install_scripts/fetch_pkgsrc.sh
        sh src/install_scripts/install_main.sh
        sh src/install_scripts/install_x11.sh
        sh src/install_scripts/install_dm.sh
        sh src/install_scripts/install_de.sh
    fi

    if [ "$INSTALLATION_PROFILE" = "server-openssh" ]; then 
        sh src/install_scripts/fetch_pkgin.sh
        sh src/install_scripts/install_main.sh
        sh src/install_scripts/install_openssh.sh
        sh src/install_scripts/install_sshield.sh
        sh src/install_scripts/install_thesuffocater.sh
        sh src/install_scripts/install_theunixmanager_bash.sh
    fi

    if [ "$INSTALLATION_PROFILE" = "server-ftp" ]; then
        sh src/install_scripts/fetch_pkgin.sh
        sh src/install_scripts/install_main.sh
        sh src/install_scripts/intsall_ftp.sh
        sh src/install_scripts/install_openssh.sh
        sh src/install_scripts/install_sshield.sh
    fi

    if [ "$INSTALLATION_PROFILE" = "server-vpn" ]; then
        sh src/install_scripts/fetch_pkgin.sh
        sh src/install_scripts/install_main.sh
        sh src/install_scripts/install_openvpn_setup.sh
        sh src/intsall_scripts/install_wireguard_setup.sh
        sh src/install_scripts/install_openssh.sh
        sh src/install_scripts/install_sshield.sh
    fi

    if [ "$INSTALLATION_PROFILE" = "server-dhcp" ]; then
        sh src/install_scripts/fetch_pkgin.sh
        sh src/install_scripts/install_main.sh
        sh src/install_scripts/setup_dhcp.sh
        sh src/install_scripts/install_openssh.sh
        sh src/install_scripts/install_sshield.sh
    fi

    if [ "$INSTALLATION_PROFILE" = "server-webserver" ]; then
        echo "debug"
    fi

    if [ "$INSTALLATION_PROFILE" = "server-samba" ]; then
        echo "debug"
    fi
}

finish_installation()
{
    clear

    echo "NetBSD related resources:"
    echo " - Official NetBSD website: https://www.netbsd.org/"
    echo " - Official pkgsrc website: https://www.pkgsrc.org/"
    echo " - NetBSD manual pages: https://man.netbsd.org/"
    echo " - NetBSD mailing lists: https://www.netbsd.org/mailinglists/"
    echo " - Wikipedia: https://en.wikipedia.org/wiki/NetBSD"
    echo " - The guide: https://www.netbsd.org/docs/guide/en/"
    
    echo "\n[*] The installation is now finished. Press any key to exit installer"
    read CONTINUE
    exit 0
}

main()
{
    introduction
    get_installation_profile
    get_automatic_or_manual
    begin_installation
    finish_installation
}

main

