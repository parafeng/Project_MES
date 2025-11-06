#!/bin/bash
# ROM Organizer Script
# Tự động sắp xếp ROMs vào các thư mục platform phù hợp

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${GREEN}=== ROM Organizer Script ===${NC}"
echo ""

# Configuration
ROM_BASE="/storage/roms"
SOURCE_DIR="${1:-$ROM_BASE/unsorted}"

if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}Source directory not found: $SOURCE_DIR${NC}"
    echo "Usage: $0 [source_directory]"
    exit 1
fi

echo -e "${BLUE}Source directory: $SOURCE_DIR${NC}"
echo -e "${BLUE}Target directory: $ROM_BASE${NC}"
echo ""

# Create platform directories if not exist
declare -A PLATFORMS
PLATFORMS=(
    ["nes"]="NES"
    ["snes"]="SNES"
    ["smc"]="SNES"
    ["sfc"]="SNES"
    ["md"]="Genesis"
    ["gen"]="Genesis"
    ["smd"]="Genesis"
    ["gb"]="Game Boy"
    ["gbc"]="Game Boy Color"
    ["gba"]="Game Boy Advance"
    ["n64"]="Nintendo 64"
    ["z64"]="Nintendo 64"
    ["v64"]="Nintendo 64"
    ["psx"]="PlayStation"
    ["cue"]="PlayStation"
    ["bin"]="PlayStation"
    ["iso"]="PlayStation"
    ["zip"]="Arcade"
    ["32x"]="Sega 32X"
    ["gg"]="Game Gear"
    ["sms"]="Master System"
    ["pce"]="PC Engine"
    ["ws"]="WonderSwan"
    ["wsc"]="WonderSwan Color"
    ["ngp"]="Neo Geo Pocket"
    ["ngc"]="Neo Geo Pocket Color"
    ["lnx"]="Atari Lynx"
)

# Create directories
for platform in "${PLATFORMS[@]}"; do
    mkdir -p "$ROM_BASE/$platform" 2>/dev/null
done
mkdir -p "$ROM_BASE/Unknown" 2>/dev/null

# Counters
TOTAL=0
MOVED=0
UNKNOWN=0

echo -e "${YELLOW}Scanning ROMs...${NC}"
echo ""

# Process files
find "$SOURCE_DIR" -type f | while read -r file; do
    TOTAL=$((TOTAL + 1))

    # Get file extension (lowercase)
    EXT="${file##*.}"
    EXT=$(echo "$EXT" | tr '[:upper:]' '[:lower:]')

    # Get filename
    FILENAME=$(basename "$file")

    # Check if extension is known
    if [ -n "${PLATFORMS[$EXT]}" ]; then
        PLATFORM="${PLATFORMS[$EXT]}"
        TARGET="$ROM_BASE/$PLATFORM/$FILENAME"

        # Check if file already exists
        if [ -f "$TARGET" ]; then
            echo -e "${YELLOW}⊘ Skipping (exists): $FILENAME → $PLATFORM${NC}"
        else
            mv "$file" "$TARGET" 2>/dev/null
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✓ Moved: $FILENAME → $PLATFORM${NC}"
                MOVED=$((MOVED + 1))
            else
                echo -e "${RED}✗ Failed: $FILENAME${NC}"
            fi
        fi
    else
        # Unknown extension
        TARGET="$ROM_BASE/Unknown/$FILENAME"
        mv "$file" "$TARGET" 2>/dev/null
        echo -e "${RED}? Unknown: $FILENAME (.$EXT) → Unknown/${NC}"
        UNKNOWN=$((UNKNOWN + 1))
    fi
done

echo ""
echo -e "${GREEN}=== Organization Complete ===${NC}"
echo -e "${GREEN}Files processed: $TOTAL${NC}"
echo -e "${GREEN}Files moved: $MOVED${NC}"
echo -e "${YELLOW}Unknown files: $UNKNOWN${NC}"
echo ""

if [ $UNKNOWN -gt 0 ]; then
    echo -e "${YELLOW}Check $ROM_BASE/Unknown/ for unrecognized files${NC}"
    echo ""
fi

echo -e "${BLUE}Next step: Import Content > Scan Directory in Lakka${NC}"
