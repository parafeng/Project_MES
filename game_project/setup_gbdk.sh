#!/bin/bash
# GBDK Setup Script
# Automatically download and install GBDK for Game Boy development

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   GBDK Setup for Game Boy Dev          ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""

# Detect OS
OS="unknown"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
else
    echo -e "${RED}Unsupported OS: $OSTYPE${NC}"
    echo "Please install GBDK manually from:"
    echo "https://github.com/gbdk-2020/gbdk-2020/releases"
    exit 1
fi

echo -e "${BLUE}Detected OS: $OS${NC}"
echo ""

# GBDK version
GBDK_VERSION="4.1.1"
INSTALL_DIR="$HOME/gbdk"

if [ "$OS" == "linux" ]; then
    GBDK_FILE="gbdk-linux64.tar.gz"
    DOWNLOAD_URL="https://github.com/gbdk-2020/gbdk-2020/releases/download/${GBDK_VERSION}/${GBDK_FILE}"
elif [ "$OS" == "macos" ]; then
    GBDK_FILE="gbdk-macos.tar.gz"
    DOWNLOAD_URL="https://github.com/gbdk-2020/gbdk-2020/releases/download/${GBDK_VERSION}/${GBDK_FILE}"
fi

echo -e "${YELLOW}Will install GBDK ${GBDK_VERSION} to: ${INSTALL_DIR}${NC}"
echo ""

# Check if already installed
if [ -f "$INSTALL_DIR/bin/lcc" ]; then
    echo -e "${YELLOW}GBDK already installed at $INSTALL_DIR${NC}"
    echo -n "Reinstall? (y/n): "
    read -r REINSTALL
    if [ "$REINSTALL" != "y" ] && [ "$REINSTALL" != "Y" ]; then
        echo -e "${GREEN}Keeping existing installation${NC}"
        exit 0
    fi
    echo -e "${YELLOW}Removing old installation...${NC}"
    rm -rf "$INSTALL_DIR"
fi

# Download GBDK
echo -e "${YELLOW}Downloading GBDK...${NC}"
cd "$HOME" || exit
if command -v wget > /dev/null; then
    wget -O "$GBDK_FILE" "$DOWNLOAD_URL"
elif command -v curl > /dev/null; then
    curl -L -o "$GBDK_FILE" "$DOWNLOAD_URL"
else
    echo -e "${RED}Error: Neither wget nor curl found!${NC}"
    echo "Please install wget or curl and try again"
    exit 1
fi

if [ ! -f "$GBDK_FILE" ]; then
    echo -e "${RED}Download failed!${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Downloaded${NC}"
echo ""

# Extract
echo -e "${YELLOW}Extracting GBDK...${NC}"
tar xzf "$GBDK_FILE"

if [ ! -d "$INSTALL_DIR" ]; then
    echo -e "${RED}Extraction failed!${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Extracted to $INSTALL_DIR${NC}"
echo ""

# Cleanup
rm -f "$GBDK_FILE"

# Add to PATH
echo -e "${YELLOW}Configuring PATH...${NC}"

SHELL_RC=""
if [ -f "$HOME/.bashrc" ]; then
    SHELL_RC="$HOME/.bashrc"
elif [ -f "$HOME/.zshrc" ]; then
    SHELL_RC="$HOME/.zshrc"
fi

if [ -n "$SHELL_RC" ]; then
    # Check if already in PATH
    if grep -q "gbdk/bin" "$SHELL_RC"; then
        echo -e "${YELLOW}PATH already configured in $SHELL_RC${NC}"
    else
        echo "" >> "$SHELL_RC"
        echo "# GBDK - Game Boy Development Kit" >> "$SHELL_RC"
        echo "export PATH=\"\$HOME/gbdk/bin:\$PATH\"" >> "$SHELL_RC"
        echo -e "${GREEN}✓ Added to $SHELL_RC${NC}"
    fi
fi

# Add to current session
export PATH="$HOME/gbdk/bin:$PATH"

# Verify installation
echo ""
echo -e "${YELLOW}Verifying installation...${NC}"

if command -v lcc > /dev/null; then
    LCC_VERSION=$(lcc -v 2>&1 | head -n 1)
    echo -e "${GREEN}✓ lcc found: $LCC_VERSION${NC}"
else
    echo -e "${RED}✗ lcc not found in PATH${NC}"
    echo "Please add manually to your PATH:"
    echo "export PATH=\"\$HOME/gbdk/bin:\$PATH\""
    exit 1
fi

# Optional tools
echo ""
echo -e "${BLUE}Checking optional tools...${NC}"

# Check for Game Boy emulator
if command -v bgb > /dev/null; then
    echo -e "${GREEN}✓ BGB emulator found${NC}"
elif command -v sameboy > /dev/null; then
    echo -e "${GREEN}✓ SameBoy emulator found${NC}"
elif command -v mgba > /dev/null; then
    echo -e "${GREEN}✓ mGBA found (supports GB)${NC}"
else
    echo -e "${YELLOW}⚠ No Game Boy emulator found${NC}"
    echo -e "${YELLOW}  Recommended:${NC}"
    if [ "$OS" == "linux" ]; then
        echo "    sudo apt install sameboy"
        echo "    sudo apt install mgba-qt"
    elif [ "$OS" == "macos" ]; then
        echo "    brew install sameboy"
        echo "    brew install mgba"
    fi
fi

echo ""
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   GBDK Installation Complete! 🎉       ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "1. Restart your terminal (or run: source $SHELL_RC)"
echo "2. Navigate to game project:"
echo "   cd game_project/chicken_shooter_gb"
echo "3. Build the game:"
echo "   make"
echo "4. Test on emulator:"
echo "   make test"
echo "5. Deploy to Tinker Board:"
echo "   make deploy IP=192.168.1.XXX"
echo ""
echo -e "${YELLOW}Documentation:${NC}"
echo "- GBDK Docs: https://gbdk-2020.github.io/gbdk-2020/docs/api/"
echo "- Game README: game_project/chicken_shooter_gb/README.md"
echo ""
