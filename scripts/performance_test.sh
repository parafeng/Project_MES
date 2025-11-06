#!/bin/bash
# Performance Test Script
# Test performance của Tinker Board với các cores khác nhau

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${GREEN}=== Lakka Performance Test ===${NC}"
echo ""

# Test CPU
echo -e "${CYAN}=== CPU Test ===${NC}"
if command -v sysbench > /dev/null; then
    echo "Running CPU benchmark..."
    sysbench cpu --cpu-max-prime=20000 run
else
    echo -e "${YELLOW}sysbench not available, skipping CPU test${NC}"
fi
echo ""

# Test Memory
echo -e "${CYAN}=== Memory Test ===${NC}"
if [ -f /proc/meminfo ]; then
    echo "Memory Information:"
    grep -E "MemTotal|MemFree|MemAvailable" /proc/meminfo
fi
echo ""

# Test Storage Speed
echo -e "${CYAN}=== Storage Speed Test ===${NC}"
TEST_FILE="/storage/test_speed.tmp"
echo "Testing write speed..."
dd if=/dev/zero of=$TEST_FILE bs=1M count=100 2>&1 | grep -v records

echo "Testing read speed..."
dd if=$TEST_FILE of=/dev/null bs=1M 2>&1 | grep -v records

rm -f $TEST_FILE
echo ""

# Check CPU Governor
echo -e "${CYAN}=== CPU Governor ===${NC}"
if [ -f /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor ]; then
    GOVERNOR=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
    echo -e "${YELLOW}Current governor:${NC} $GOVERNOR"

    if [ "$GOVERNOR" != "performance" ]; then
        echo -e "${YELLOW}Tip: Set to 'performance' for better gaming:${NC}"
        echo "  echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"
    fi
fi
echo ""

# Check Temperature under load
echo -e "${CYAN}=== Temperature Monitor ===${NC}"
if [ -f /sys/class/thermal/thermal_zone0/temp ]; then
    echo "Monitoring temperature for 10 seconds..."
    for i in {1..10}; do
        TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
        TEMP_C=$((TEMP / 1000))

        if [ $TEMP_C -gt 80 ]; then
            COLOR=$RED
            STATUS="HOT!"
        elif [ $TEMP_C -gt 70 ]; then
            COLOR=$YELLOW
            STATUS="Warm"
        else
            COLOR=$GREEN
            STATUS="OK"
        fi

        echo -e "  ${COLOR}${TEMP_C}°C ($STATUS)${NC}"
        sleep 1
    done
fi
echo ""

echo -e "${GREEN}=== Test Complete ===${NC}"
echo ""
echo "Recommendations:"
echo "  • Keep temperature below 70°C for stable gaming"
echo "  • Use performance governor for best results"
echo "  • Ensure good ventilation or add heatsink/fan"
