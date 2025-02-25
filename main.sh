#!/bin/sh

AUTOINSTALL_CONF_FILE="src/etc/autoinstall.conf"
PROFILE_CONF_FILE="src/etc/profile.conf"

create_config_file()
{
    echo "$1" > "$AUTOINSTALL_CONF_FILE"
    echo "[*] Success! [create_config_file()]: Created autoinstall configuration file: $AUTHOINSTALL_CONF_FILE with value: $1."
}

introduction()
{
    clear
}

get_automatic_or_manual()
{
    while true; do
        read -r -p "[?] Enable automatic installation? (y/N): " ANSWER
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
        echo "[!] Warning! [automatic_or_manual()]: Autoinstall configuration file not found. Corrupted installation?"
        echo "$AUTOINSTALL_VALUE" > "$AUTOINSTALL_CONF_FILE"\
        echo "[*] Success! [create_config_file()]: Created autoinstall configuration file: $AUTHOINSTALL_CONF_FILE with value: $AUTOINSTALL_VALUE."
    else
        echo "$AUTOINSTALL_VALUE" > "$AUTOINSTALL_CONF_FILE"
        echo "[*] Success! [automatic_or_manual()]: Log configuration set to: $AUTOINSTALL_VALUE in $AUTOINSTALL_CONF_FILE."
    fi
}

get_installation_profile()
{
    echo "Available installation profiles:"
    echo " - x11;"
    echo " - desktop;"
    echo " - server-openssh [default];"
    echo " - server-ftp;"
    echo " - server-vpn;"
    echo " - server-dhcp;"
    echo " - server-webserver."

    while true; do
        read -r -p "[==>] Enter desired system profile: " ANSWER
        case "$ANSWER" in
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
                INSTALLLATION_PROFILE="server-webserver"
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
        echo "[*] Success! [create_config_file()]: Created autoinstall configuration file: $AUTHOINSTALL_CONF_FILE with value: $INSTALLATION_PROFILE."
    else
        echo "$INSTALLATION_PROFILE" > "$PROFILE_CONF_FILE"
        echo "[*] Success! [get_installation_profile()]: Log configuration set to: $INSTALLATION_PROFILE in $PROFILE_CONF_FILE."
    fi
}

main() {
    introduction
    get_installation_profile
    get_automatic_or_manual
}

main

