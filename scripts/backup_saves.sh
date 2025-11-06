#!/bin/bash
# Backup Save Files Script for Lakka
# Sao lưu tất cả save states, save files, và configs

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Lakka Backup Script ===${NC}"
echo ""

# Configuration
BACKUP_DIR="/storage/backups"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="lakka_backup_${DATE}"
BACKUP_PATH="${BACKUP_DIR}/${BACKUP_NAME}"

# Create backup directory if not exists
if [ ! -d "$BACKUP_DIR" ]; then
    echo -e "${YELLOW}Creating backup directory...${NC}"
    mkdir -p "$BACKUP_DIR"
fi

echo -e "${GREEN}Backup will be saved to: ${BACKUP_PATH}.tar.gz${NC}"
echo ""

# Remount /storage as read-write if needed
mount -o remount,rw /storage 2>/dev/null

# Create temporary directory for backup
mkdir -p "/tmp/${BACKUP_NAME}"

# Backup saves
echo -e "${YELLOW}Backing up save states...${NC}"
if [ -d "/storage/savefiles" ]; then
    cp -r /storage/savefiles "/tmp/${BACKUP_NAME}/" 2>/dev/null
    echo -e "${GREEN}✓ Save files backed up${NC}"
else
    echo -e "${RED}✗ No save files found${NC}"
fi

if [ -d "/storage/savestates" ]; then
    cp -r /storage/savestates "/tmp/${BACKUP_NAME}/" 2>/dev/null
    echo -e "${GREEN}✓ Save states backed up${NC}"
else
    echo -e "${RED}✗ No save states found${NC}"
fi

# Backup configs
echo -e "${YELLOW}Backing up configurations...${NC}"
if [ -d "/storage/.config/retroarch" ]; then
    cp -r /storage/.config/retroarch "/tmp/${BACKUP_NAME}/" 2>/dev/null
    echo -e "${GREEN}✓ RetroArch configs backed up${NC}"
else
    echo -e "${RED}✗ No configs found${NC}"
fi

# Backup playlists
echo -e "${YELLOW}Backing up playlists...${NC}"
if [ -d "/storage/playlists" ]; then
    cp -r /storage/playlists "/tmp/${BACKUP_NAME}/" 2>/dev/null
    echo -e "${GREEN}✓ Playlists backed up${NC}"
else
    echo -e "${RED}✗ No playlists found${NC}"
fi

# Create compressed archive
echo -e "${YELLOW}Creating compressed archive...${NC}"
cd /tmp
tar -czf "${BACKUP_PATH}.tar.gz" "${BACKUP_NAME}/" 2>/dev/null

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Archive created successfully${NC}"

    # Get file size
    SIZE=$(du -h "${BACKUP_PATH}.tar.gz" | cut -f1)
    echo -e "${GREEN}Backup size: ${SIZE}${NC}"

    # Cleanup temp directory
    rm -rf "/tmp/${BACKUP_NAME}"
    echo -e "${GREEN}✓ Cleanup completed${NC}"
else
    echo -e "${RED}✗ Failed to create archive${NC}"
    exit 1
fi

# Keep only last 5 backups
echo -e "${YELLOW}Cleaning old backups (keeping last 5)...${NC}"
cd "$BACKUP_DIR"
ls -t lakka_backup_*.tar.gz 2>/dev/null | tail -n +6 | xargs rm -f 2>/dev/null
echo -e "${GREEN}✓ Old backups cleaned${NC}"

echo ""
echo -e "${GREEN}=== Backup Complete ===${NC}"
echo -e "${GREEN}Backup saved to: ${BACKUP_PATH}.tar.gz${NC}"
echo ""
echo "To restore, extract this archive to /storage/"
echo "Example: tar -xzf ${BACKUP_PATH}.tar.gz -C /storage/"
