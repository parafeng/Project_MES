#!/bin/bash
# System Information Script for Lakka/Tinker Board
# Hiển thị thông tin hệ thống, nhiệt độ, cores đã cài, và storage

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

clear
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   Lakka System Information             ║${NC}"
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo ""

# System Info
echo -e "${CYAN}=== System Information ===${NC}"
echo -e "${YELLOW}Hostname:${NC} $(hostname)"
echo -e "${YELLOW}Kernel:${NC} $(uname -r)"
echo -e "${YELLOW}Architecture:${NC} $(uname -m)"
echo -e "${YELLOW}Uptime:${NC} $(uptime -p 2>/dev/null || uptime)"
echo ""

# CPU Info
echo -e "${CYAN}=== CPU Information ===${NC}"
if [ -f /proc/cpuinfo ]; then
    CPU_MODEL=$(grep "model name" /proc/cpuinfo | head -n1 | cut -d':' -f2 | xargs)
    CPU_CORES=$(grep -c "processor" /proc/cpuinfo)
    echo -e "${YELLOW}CPU Model:${NC} ${CPU_MODEL:-Unknown}"
    echo -e "${YELLOW}CPU Cores:${NC} $CPU_CORES"

    # CPU Frequency
    if [ -f /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq ]; then
        FREQ=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq)
        FREQ_MHZ=$((FREQ / 1000))
        echo -e "${YELLOW}Current Freq:${NC} ${FREQ_MHZ} MHz"
    fi

    # CPU Temperature
    if [ -f /sys/class/thermal/thermal_zone0/temp ]; then
        TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
        TEMP_C=$((TEMP / 1000))

        if [ $TEMP_C -gt 80 ]; then
            COLOR=$RED
        elif [ $TEMP_C -gt 70 ]; then
            COLOR=$YELLOW
        else
            COLOR=$GREEN
        fi
        echo -e "${YELLOW}Temperature:${NC} ${COLOR}${TEMP_C}°C${NC}"
    fi
fi
echo ""

# Memory Info
echo -e "${CYAN}=== Memory Information ===${NC}"
if command -v free > /dev/null; then
    MEM_INFO=$(free -h | grep Mem)
    MEM_TOTAL=$(echo $MEM_INFO | awk '{print $2}')
    MEM_USED=$(echo $MEM_INFO | awk '{print $3}')
    MEM_FREE=$(echo $MEM_INFO | awk '{print $4}')
    echo -e "${YELLOW}Total:${NC} $MEM_TOTAL"
    echo -e "${YELLOW}Used:${NC} $MEM_USED"
    echo -e "${YELLOW}Free:${NC} $MEM_FREE"
fi
echo ""

# Storage Info
echo -e "${CYAN}=== Storage Information ===${NC}"
if command -v df > /dev/null; then
    echo -e "${YELLOW}System Storage:${NC}"
    df -h /storage | tail -n 1 | awk '{printf "  Total: %s | Used: %s (%s) | Free: %s\n", $2, $3, $5, $4}'

    echo -e "${YELLOW}ROMs Storage:${NC}"
    if [ -d /storage/roms ]; then
        ROM_SIZE=$(du -sh /storage/roms 2>/dev/null | cut -f1)
        echo -e "  ROMs folder size: $ROM_SIZE"
    else
        echo -e "  ${RED}ROMs folder not found${NC}"
    fi
fi
echo ""

# Network Info
echo -e "${CYAN}=== Network Information ===${NC}"
if command -v ip > /dev/null; then
    # Get IP address
    IP_ADDR=$(ip -4 addr show | grep inet | grep -v 127.0.0.1 | awk '{print $2}' | cut -d'/' -f1 | head -n1)
    echo -e "${YELLOW}IP Address:${NC} ${IP_ADDR:-Not connected}"

    # Get MAC address
    MAC_ADDR=$(ip link show | grep "link/ether" | head -n1 | awk '{print $2}')
    echo -e "${YELLOW}MAC Address:${NC} ${MAC_ADDR:-Unknown}"
fi
echo ""

# Installed Cores
echo -e "${CYAN}=== Installed Emulator Cores ===${NC}"
CORE_DIR="/tmp/cores"
if [ -d "$CORE_DIR" ]; then
    CORE_COUNT=$(find "$CORE_DIR" -name "*_libretro.so" 2>/dev/null | wc -l)
    echo -e "${YELLOW}Total cores installed:${NC} $CORE_COUNT"
    echo ""
    echo -e "${YELLOW}Installed cores:${NC}"
    find "$CORE_DIR" -name "*_libretro.so" 2>/dev/null | while read -r core; do
        CORE_NAME=$(basename "$core" | sed 's/_libretro.so//')
        echo "  • $CORE_NAME"
    done | sort
else
    echo -e "${RED}Core directory not found${NC}"
fi
echo ""

# ROMs Summary
echo -e "${CYAN}=== ROMs Summary ===${NC}"
ROM_BASE="/storage/roms"
if [ -d "$ROM_BASE" ]; then
    echo -e "${YELLOW}ROMs by platform:${NC}"
    for dir in "$ROM_BASE"/*; do
        if [ -d "$dir" ]; then
            PLATFORM=$(basename "$dir")
            COUNT=$(find "$dir" -type f 2>/dev/null | wc -l)
            if [ $COUNT -gt 0 ]; then
                echo "  • $PLATFORM: $COUNT files"
            fi
        fi
    done
else
    echo -e "${RED}ROMs directory not found${NC}"
fi
echo ""

# Services Status
echo -e "${CYAN}=== Services Status ===${NC}"
# Check SSH
if pgrep sshd > /dev/null 2>&1; then
    echo -e "${GREEN}✓ SSH: Running${NC}"
else
    echo -e "${RED}✗ SSH: Not running${NC}"
fi

# Check Samba
if pgrep smbd > /dev/null 2>&1; then
    echo -e "${GREEN}✓ Samba: Running${NC}"
else
    echo -e "${RED}✗ Samba: Not running${NC}"
fi

# Check Bluetooth
if [ -d /sys/class/bluetooth ]; then
    if pgrep bluetoothd > /dev/null 2>&1; then
        echo -e "${GREEN}✓ Bluetooth: Running${NC}"
    else
        echo -e "${YELLOW}⊙ Bluetooth: Available but not running${NC}"
    fi
else
    echo -e "${YELLOW}⊙ Bluetooth: Not available${NC}"
fi
echo ""

echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
