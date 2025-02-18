#!/bin/bash


RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # blank

clear_caches() {
    echo -e "${YELLOW}This will clear all system caches, logs, and temporary files.${NC}"
    read -p "Are you sure you want to continue? (y/n): " confirm
    if [[ $confirm == "y" || $confirm == "Y" ]]; then
        echo -e "${GREEN}Clearing caches...${NC}"
        sudo apt clean
        sudo apt autoclean
        sudo journalctl --rotate
        sudo journalctl --vacuum-time=1s
        sudo rm -rf /var/log/*
        sudo rm -rf /tmp/*
        sudo rm -rf /var/tmp/*
        echo -e "${GREEN}Caches cleared!${NC}"
    else
        echo -e "${RED}Cache clearing canceled.${NC}"
    fi
}

remove_user_files() {
    echo -e "${YELLOW}This will remove all user files and packages that weren’t part of the original system installation.${NC}"
    read -p "Are you sure you want to continue? (y/n): " confirm
    if [[ $confirm == "y" || $confirm == "Y" ]]; then
        echo -e "${GREEN}Removing all user files and extra packages...${NC}"
        sudo apt autoremove --purge -y
        sudo apt clean
        sudo rm -rf /home/*/.*
        sudo rm -rf /home/*/*
        echo -e "${GREEN}User files removed!${NC}"
    else
        echo -e "${RED}User file removal canceled.${NC}"
    fi
}

reset_system_configs() {
    echo -e "${YELLOW}This will reset system configurations, hostname, and SSH keys.${NC}"
    read -p "Are you sure you want to continue? (y/n): " confirm
    if [[ $confirm == "y" || $confirm == "Y" ]]; then
        echo -e "${GREEN}Resetting system configurations...${NC}"
        sudo apt install --reinstall raspberrypi-ui-mods raspberrypi-sys-mods -y
        echo "raspberrypi" | sudo tee /etc/hostname
        sudo rm /etc/ssh/ssh_host_*
        sudo dpkg-reconfigure openssh-server
        echo -e "${GREEN}System configurations reset!${NC}"
    else
        echo -e "${RED}System configuration reset canceled.${NC}"
    fi
}

full_factory_reset() {
    echo -e "${RED}WARNING: This will remove ALL data and configurations!${NC}"
    read -p "Are you ABSOLUTELY sure you want to proceed with a full factory reset? (y/n): " confirm
    if [[ $confirm == "y" || $confirm == "Y" ]]; then
        echo -e "${RED}This action cannot be undone! Final confirmation required.${NC}"
        read -p "Type 'RESET' to confirm: " final_confirm
        if [ "$final_confirm" == "RESET" ]; then
            remove_user_files
            reset_system_configs
            clear_caches
            echo -e "${GREEN}Full factory reset complete. Rebooting...${NC}"
            sudo reboot
        else
            echo -e "${RED}Factory reset aborted.${NC}"
        fi
    else
        echo -e "${RED}Factory reset canceled.${NC}"
    fi
}

while true; do
    clear
    echo -e "${GREEN}Raspberry Pi Reset Menu${NC}"
    echo "1) Clear caches"
    echo "2) Remove all files that didn’t come with the system"
    echo "3) Reset system configurations"
    echo "4) Full factory reset (without reflashing)"
    echo "5) Exit"
    read -p "Choose an option: " choice

    case $choice in
        1) clear_caches ;;
        2) remove_user_files ;;
        3) reset_system_configs ;;
        4) full_factory_reset ;;
        5) echo "Exiting..."; exit 0 ;;
        *) echo -e "${RED}Invalid option! Please select a valid number.${NC}" ;;
    esac
    read -p "Press Enter to continue..."
done
