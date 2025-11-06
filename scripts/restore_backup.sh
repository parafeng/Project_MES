#!/bin/bash
# Restore Backup Script for Lakka
# Khôi phục save files và configs từ backup

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Lakka Restore Script ===${NC}"
echo ""

# Check if backup file is provided
if [ -z "$1" ]; then
    echo -e "${RED}Usage: $0 <backup_file.tar.gz>${NC}"
    echo ""
    echo "Available backups:"
    ls -lh /storage/backups/*.tar.gz 2>/dev/null | awk '{print "  " $9 " (" $5 ")"}'
    exit 1
fi

BACKUP_FILE="$1"

# Check if file exists
if [ ! -f "$BACKUP_FILE" ]; then
    echo -e "${RED}Error: Backup file not found: $BACKUP_FILE${NC}"
    exit 1
fi

echo -e "${YELLOW}Backup file: $BACKUP_FILE${NC}"
echo -e "${YELLOW}This will overwrite existing saves and configs!${NC}"
echo -n "Continue? (y/n): "
read -r CONFIRM

if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
    echo -e "${RED}Restore cancelled${NC}"
    exit 0
fi

echo ""
echo -e "${GREEN}Starting restore...${NC}"

# Remount as read-write
mount -o remount,rw /storage 2>/dev/null

# Extract to temp directory
TEMP_DIR="/tmp/restore_temp"
mkdir -p "$TEMP_DIR"

echo -e "${YELLOW}Extracting backup...${NC}"
tar -xzf "$BACKUP_FILE" -C "$TEMP_DIR" 2>/dev/null

if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to extract backup${NC}"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Find the extracted directory
BACKUP_DIR=$(find "$TEMP_DIR" -maxdepth 1 -type d -name "lakka_backup_*" | head -n 1)

if [ -z "$BACKUP_DIR" ]; then
    echo -e "${RED}Invalid backup format${NC}"
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Restore files
echo -e "${YELLOW}Restoring save files...${NC}"
if [ -d "$BACKUP_DIR/savefiles" ]; then
    cp -r "$BACKUP_DIR/savefiles" /storage/ 2>/dev/null
    echo -e "${GREEN}✓ Save files restored${NC}"
fi

echo -e "${YELLOW}Restoring save states...${NC}"
if [ -d "$BACKUP_DIR/savestates" ]; then
    cp -r "$BACKUP_DIR/savestates" /storage/ 2>/dev/null
    echo -e "${GREEN}✓ Save states restored${NC}"
fi

echo -e "${YELLOW}Restoring configurations...${NC}"
if [ -d "$BACKUP_DIR/retroarch" ]; then
    cp -r "$BACKUP_DIR/retroarch" /storage/.config/ 2>/dev/null
    echo -e "${GREEN}✓ Configs restored${NC}"
fi

echo -e "${YELLOW}Restoring playlists...${NC}"
if [ -d "$BACKUP_DIR/playlists" ]; then
    cp -r "$BACKUP_DIR/playlists" /storage/ 2>/dev/null
    echo -e "${GREEN}✓ Playlists restored${NC}"
fi

# Cleanup
rm -rf "$TEMP_DIR"

echo ""
echo -e "${GREEN}=== Restore Complete ===${NC}"
echo -e "${YELLOW}Please reboot for changes to take full effect${NC}"
echo -e "${YELLOW}Command: reboot${NC}"
