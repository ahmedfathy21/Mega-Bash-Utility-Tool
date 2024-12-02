#!/bin/bash

COLOR_RESET="\033[0m"
COLOR_GREEN="\033[1;32m"
COLOR_BLUE="\033[1;34m"
COLOR_YELLOW="\033[1;33m"
COLOR_RED="\033[1;31m"
COLOR_CYAN="\033[1;36m"
COLOR_MAGENTA="\033[1;35m"
text="Enjoy Man"
# Function: Display Banner
show_banner() {
    echo -e "${COLOR_GREEN}"
    local message="Welcome to the Mega Bash Utility!"
    echo
    for ((i = 0; i < ${#message}; i++)); do
        echo -n "${message:i:1}"
        sleep 0.05
    done
    echo -e "${COLOR_RESET}"
    echo -e "${COLOR_BLUE}-------------------------------------------------------"
    echo " Explore tools for monitoring, managing, and optimizing!"
    echo "-------------------------------------------------------${text}"
}

# Function: Display Menu
show_menu() {
    echo -e "${COLOR_YELLOW}Choose an option:${COLOR_RESET}"
    echo "1. System Information"
    echo "2. Disk Usage"
    echo "3. Network Statistics"
    echo "4. CPU Usage Monitor"
    echo "5. Real-Time Process Viewer"
    echo "6. Disk Cleanup"
    echo "7. System Health Check"
    echo "8. File Explorer"
    echo "9. User Management"
    echo "10. Generate Logs"
    echo "11. Fun ASCII Art"
    echo "12. Exit"
}

# Function: Show System Information
system_info() {
    echo -e "${COLOR_CYAN}Fetching System Information...${COLOR_RESET}"
    sleep 1
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "OS: $(grep '^PRETTY_NAME' /etc/os-release | cut -d= -f2 | tr -d '\"')"
    echo "Kernel Version: $(uname -r)"
    echo "CPU Load: $(top -bn1 | grep 'load average' | awk '{print $10 $11 $12}')"
    echo "RAM Usage: $(free -h | grep Mem | awk '{print $3 " / " $2}')"
    echo -e "${COLOR_GREEN}System Information Loaded Successfully!${COLOR_RESET}"
}

# Function: Show Disk Usage
disk_usage() {
    echo -e "${COLOR_CYAN}Analyzing Disk Usage...${COLOR_RESET}"
    sleep 2
    df -h --output=source,size,used,avail,pcent | column -t
    echo -e "${COLOR_GREEN}Disk Usage Analysis Complete!${COLOR_RESET}"
}

# Function: Show Network Statistics
network_stats() {
    echo -e "${COLOR_CYAN}Fetching Network Statistics...${COLOR_RESET}"
    sleep 1
    echo "Active Connections: $(netstat -ant | grep ESTABLISHED | wc -l)"
    echo "Top Bandwidth Consumers:"
    if command -v iftop &>/dev/null; then
        echo "(Launching iftop... Press Q to quit)"
        sudo iftop
    else
        echo -e "${COLOR_RED}iftop is not installed. Use 'sudo apt install iftop' for real-time data.${COLOR_RESET}"
    fi
    echo -e "${COLOR_GREEN}Network Stats Loaded Successfully!${COLOR_RESET}"
}

# Function: CPU Usage Monitor
cpu_usage_monitor() {
    echo -e "${COLOR_CYAN}Starting CPU Usage Monitor... Press Ctrl+C to exit.${COLOR_RESET}"
    while true; do
        echo -ne "CPU Usage: $(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')\r"
        sleep 1
    done
}

# Function: Real-Time Process Viewer
real_time_process_viewer() {
    echo -e "${COLOR_CYAN}Launching Real-Time Process Viewer...${COLOR_RESET}"
    sleep 1
    top
}

# Function: Disk Cleanup
disk_cleanup() {
    echo -e "${COLOR_CYAN}Running Disk Cleanup...${COLOR_RESET}"
    sleep 2
    echo "Clearing apt cache..."
    sudo apt-get clean
    echo "Clearing temporary files..."
    sudo rm -rf /tmp/*
    echo -e "${COLOR_GREEN}Disk Cleanup Completed!${COLOR_RESET}"
}

# Function: System Health Check
system_health_check() {
    echo -e "${COLOR_CYAN}Performing System Health Check...${COLOR_RESET}"
    sleep 2
    echo "Checking CPU Temperature..."
    if command -v sensors &>/dev/null; then
        sensors
    else
        echo -e "${COLOR_RED}Install 'lm-sensors' to monitor CPU temperature.${COLOR_RESET}"
    fi
    echo "Checking Disk Health..."
    if command -v smartctl &>/dev/null; then
        sudo smartctl --all /dev/sda | grep -i health
    else
        echo -e "${COLOR_RED}Install 'smartmontools' to check disk health.${COLOR_RESET}"
    fi
    echo -e "${COLOR_GREEN}System Health Check Complete!${COLOR_RESET}"
}

# Function: File Explorer
file_explorer() {
    echo -e "${COLOR_CYAN}Launching File Explorer...${COLOR_RESET}"
    echo "Enter directory path (default: current directory):"
    read -r directory
    directory=${directory:-$(pwd)}
    echo "Contents of $directory:"
    ls -lh "$directory"
    echo -e "${COLOR_GREEN}File Explorer Finished!${COLOR_RESET}"
}

# Function: User Management
user_management() {
    echo -e "${COLOR_CYAN}User Management:${COLOR_RESET}"
    echo "1. List all users"
    echo "2. Add a new user"
    echo "3. Delete a user"
    read -rp "Choose an option [1-3]: " user_choice
    case $user_choice in
        1)
            echo "Listing all users..."
            cut -d: -f1 /etc/passwd
            ;;
        2)
            read -rp "Enter the username to add: " new_user
            sudo adduser "$new_user"
            ;;
        3)
            read -rp "Enter the username to delete: " del_user
            sudo deluser "$del_user"
            ;;
        *)
            echo -e "${COLOR_RED}Invalid option. Returning to main menu.${COLOR_RESET}"
            ;;
    esac
}

# Function: Generate Logs
generate_logs() {
    echo -e "${COLOR_CYAN}Generating Logs...${COLOR_RESET}"
    sleep 1
    echo "System Logs:"
    dmesg | tail -n 10
    echo "Auth Logs:"
    sudo tail -n 10 /var/log/auth.log
    echo -e "${COLOR_GREEN}Logs Generated Successfully!${COLOR_RESET}"
}

# Function: Fun ASCII Art
ascii_art() {
    echo -e "${COLOR_MAGENTA}Enjoy some ASCII Art:${COLOR_RESET}"
    cat << "EOF"
       /\_/\  
      ( o.o ) 
       > ^ <  
EOF
    echo -e "${COLOR_MAGENTA}Bash Creativity Unleashed!${COLOR_RESET}"
}

# Main Script Logic
clear
show_banner

while true; do
    echo
    show_menu
    read -rp "Enter your choice [1-12]: " choice
    echo
    case $choice in
        1) system_info ;;
        2) disk_usage ;;
        3) network_stats ;;
        4) cpu_usage_monitor ;;
        5) real_time_process_viewer ;;
        6) disk_cleanup ;;
        7) system_health_check ;;
        8) file_explorer ;;
        9) user_management ;;
        10) generate_logs ;;
        11) ascii_art ;;
        12) 
            echo -e "${COLOR_RED}Exiting... Goodbye!${COLOR_RESET}"
            exit 0
            ;;
        *) echo -e "${COLOR_RED}Invalid option. Please try again.${COLOR_RESET}" ;;
    esac
    echo
done
