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

NETBSD_WEBSITE="www.netbsd.org"
AUTOINSTALL_CONF_FILE="etc/autoinstall.conf"
PROFILE_CONF_FILE="etc/profile.conf"

check_internet_connection()
{
    echo "[*] Checking internet connection by pinging $NETBSD_WEBSITE..."
    ping -c 1 "$NETBSD_WEBSITE" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "[*] [check_internet_connection()] Internet connection is available."
        return 0
    else
        echo "[!] [check_internet_connection()] No internet connection detected. Installation cannot proceed."
        return 1
    fi
}

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
    echo "                               |___/|_| $(cat etc/prototype_version) for NetBSD $(cat etc/last_netbsd_version)"
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
        echo "$AUTOINSTALL_VALUE" > "$AUTOINSTALL_CONF_FILE"
        echo "[*] Success! [get_automatic_or_manual()]: Created autoinstall configuration file: $AUTOINSTALL_CONF_FILE with value: $AUTOINSTALL_VALUE."
    else
        echo "$AUTOINSTALL_VALUE" > "$AUTOINSTALL_CONF_FILE"
        echo "[*] Success! [get_automatic_or_manual()]: Log configuration set to: $AUTOINSTALL_VALUE in $AUTOINSTALL_CONF_FILE."
    fi
}

get_installation_profile()
{
    echo "Available installation profiles:"
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
    AUTOINSTALL_MODE=$(cat etc/autoinstall.conf)
    INSTALLATION_PROFILE=$(cat etc/profile.conf)

    confirm_script_execution()
    {
        if [ "$AUTOINSTALL_MODE" = "false" ]; then
            echo "[?] Execute $1? (y/N)"
            while true; do
                read ANSWER
                case "$ANSWER" in
                    [yY]*)
                        return 0
                        ;;
                    [nN]*)
                        echo "[!] Skipping $1."
                        return 1
                        ;;
                    "")
                        echo "[!] Skipping $1 (default)."
                        return 1
                        ;;
                    *)
                        echo "[!] Please answer 'y' or 'n'."
                        ;;
                esac
            done
        else
            return 0
        fi
    }

    execute_script_with_confirmation()
    {
        SCRIPT_PATH="$1"
        SCRIPT_NAME=$(basename "$SCRIPT_PATH")

        if confirm_script_execution "$SCRIPT_NAME"; then
            sh "$SCRIPT_PATH"
        fi
    }

    if [ "$INSTALLATION_PROFILE" = "minimal" ]; then
        execute_script_with_confirmation "src/install_scripts/fetch_pkgin.sh"
        execute_script_with_confirmation "src/install_scripts/install_main.sh"
    fi

    if [ "$INSTALLATION_PROFILE" = "x11" ]; then
        execute_script_with_confirmation "src/install_scripts/fetch_pkgin.sh"
        execute_script_with_confirmation "src/install_scripts/install_main.sh"
        execute_script_with_confirmation "src/install_scripts/install_x11.sh"
    fi

    if [ "$INSTALLATION_PROFILE" = "desktop" ]; then
        execute_script_with_confirmation "src/install_scripts/fetch_pkgin.sh"
        execute_script_with_confirmation "src/install_scripts/fetch_pkgsrc.sh"
        execute_script_with_confirmation "src/install_scripts/install_main.sh"
        execute_script_with_confirmation "src/install_scripts/install_x11.sh"
        execute_script_with_confirmation "src/install_scripts/install_dm.sh"
        execute_script_with_confirmation "src/install_scripts/install_de.sh"
        execute_script_with_confirmation "src/install_scripts/install_misc.sh"
    fi

    if [ "$INSTALLATION_PROFILE" = "server-openssh" ]; then
        execute_script_with_confirmation "src/install_scripts/fetch_pkgin.sh"
        execute_script_with_confirmation "src/install_scripts/install_main.sh"
        execute_script_with_confirmation "src/install_scripts/install_openssh.sh"
        execute_script_with_confirmation "src/install_scripts/install_sshield.sh"
        execute_script_with_confirmation "src/install_scripts/install_thesuffocater.sh"
        execute_script_with_confirmation "src/install_scripts/install_theunixmanager_bash.sh"
    fi

    if [ "$INSTALLATION_PROFILE" = "server-ftp" ]; then
        execute_script_with_confirmation "src/install_scripts/fetch_pkgin.sh"
        execute_script_with_confirmation "src/install_scripts/install_main.sh"
        execute_script_with_confirmation "src/install_scripts/install_ftp.sh"
        execute_script_with_confirmation "src/install_scripts/install_openssh.sh"
        execute_script_with_confirmation "src/install_scripts/install_sshield.sh"
    fi

    if [ "$INSTALLATION_PROFILE" = "server-vpn" ]; then
        execute_script_with_confirmation "src/install_scripts/fetch_pkgin.sh"
        execute_script_with_confirmation "src/install_scripts/install_main.sh"
        execute_script_with_confirmation "src/install_scripts/setup_openvpn.sh"
        execute_script_with_confirmation "src/install_scripts/setup_wireguard.sh"
        execute_script_with_confirmation "src/install_scripts/install_openssh.sh"
        execute_script_with_confirmation "src/install_scripts/install_sshield.sh"
    fi

    if [ "$INSTALLATION_PROFILE" = "server-dhcp" ]; then
        execute_script_with_confirmation "src/install_scripts/fetch_pkgin.sh"
        execute_script_with_confirmation "src/install_scripts/install_main.sh"
        execute_script_with_confirmation "src/install_scripts/setup_dhcp.sh"
        execute_script_with_confirmation "src/install_scripts/install_openssh.sh"
        execute_script_with_confirmation "src/install_scripts/install_sshield.sh"
    fi

    if [ "$INSTALLATION_PROFILE" = "server-webserver" ]; then
        execute_script_with_confirmation "src/install_scripts/fetch_pkgin.sh"
        execute_script_with_confirmation "src/install_scripts/install_main.sh"
        echo "debug" # TODO: Implement webserver installation
    fi

    if [ "$INSTALLATION_PROFILE" = "server-samba" ]; then
        execute_script_with_confirmation "src/install_scripts/fetch_pkgin.sh"
        execute_script_with_confirmation "src/install_scripts/fetch_pkgsrc.sh"
        execute_script_with_confirmation "src/install_scripts/install_main.sh"
        echo "debug" # TODO: Implement samba installation
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

    echo "[*] The installation is now finished. Press any key to exit installer"
    read CONTINUE
    exit 0
}

main()
{
    if ! check_internet_connection; then
        echo "[!] Installation aborted due to missing internet connection."
        exit 1
    fi
    introduction
    get_installation_profile
    get_automatic_or_manual
    begin_installation
    finish_installation
}

main

