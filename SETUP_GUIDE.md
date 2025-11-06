# 🚀 Complete Setup Guide - From Zero to Playing on Tinker Board

## Tổng quan
Hướng dẫn này sẽ giúp bạn từ **không có gì** đến **chơi Chicken Shooter game trên Tinker Board**.

**Timeline:** 2-3 giờ (bao gồm cả cài đặt và testing)

**Yêu cầu:**
- 💻 Máy tính (Linux/Mac/Windows)
- 🔧 Tinker Board + SD card (16GB+)
- 🌐 Internet connection
- ⌨️ Keyboard + HDMI cable + TV/Monitor

---

## 📋 Part 1: Setup Development Environment

### Step 1.1: Cài đặt Git (nếu chưa có)

#### Linux (Ubuntu/Debian):
```bash
# Check if git already installed
git --version

# If not installed:
sudo apt update
sudo apt install git -y
```

#### macOS:
```bash
# Check if git already installed
git --version

# If not installed:
# Install Homebrew first (if needed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Then install git
brew install git
```

#### Windows:
```powershell
# Download Git from: https://git-scm.com/download/win
# Install và chọn "Use Git from the Windows Command Prompt"
# Mở Git Bash sau khi cài xong
```

**Verify installation:**
```bash
git --version
# Output: git version 2.x.x
```

---

### Step 1.2: Clone Repository

```bash
# Tạo thư mục cho projects (optional, nhưng khuyến nghị)
mkdir -p ~/Projects
cd ~/Projects

# Clone repository
git clone https://github.com/parafeng/Project_MES.git

# Enter directory
cd Project_MES

# Switch to correct branch
git checkout claude/tinker-board-emulation-setup-011CUr7ZLtZbZASdm9oka2ot

# Verify files
ls -la
```

**Expected output:**
```
README.md
QUICK_START.md
IMPLEMENTATION_PLAN.md
HYBRID_ROADMAP.md
SETUP_GUIDE.md
scripts/
configs/
docs/
game_project/
LICENSE
```

✅ **Checkpoint 1:** Repository cloned successfully!

---

### Step 1.3: Install GBDK (Game Boy Development Kit)

**Automated installation (Linux/Mac):**

```bash
# Navigate to game project
cd ~/Projects/Project_MES/game_project

# Run automatic installer
chmod +x setup_gbdk.sh
./setup_gbdk.sh

# Follow prompts (type 'y' when asked)
```

**What the script does:**
- Detects your OS automatically
- Downloads GBDK-2020 v4.1.1
- Extracts to `~/gbdk`
- Adds to PATH in `.bashrc` or `.zshrc`
- Verifies installation

**After installation completes:**

```bash
# Restart terminal (để load PATH mới)
# Hoặc chạy:
source ~/.bashrc  # Linux
# hoặc
source ~/.zshrc   # macOS

# Verify GBDK installed
lcc -v
```

**Expected output:**
```
lcc $Id: lcc.c 1.21 2004/08/11 12:21:56 bernds Exp $
```

**Manual installation (nếu script fail):**

<details>
<summary>Click để xem manual installation steps</summary>

#### Linux:
```bash
cd ~
wget https://github.com/gbdk-2020/gbdk-2020/releases/download/4.1.1/gbdk-linux64.tar.gz
tar xzf gbdk-linux64.tar.gz
echo 'export PATH="$HOME/gbdk/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
rm gbdk-linux64.tar.gz
```

#### macOS:
```bash
cd ~
curl -L -o gbdk-macos.tar.gz https://github.com/gbdk-2020/gbdk-2020/releases/download/4.1.1/gbdk-macos.tar.gz
tar xzf gbdk-macos.tar.gz
echo 'export PATH="$HOME/gbdk/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
rm gbdk-macos.tar.gz
```

#### Windows:
```
1. Download: https://github.com/gbdk-2020/gbdk-2020/releases/download/4.1.1/gbdk-win.zip
2. Extract to C:\gbdk
3. Add to PATH:
   - Right click "This PC" > Properties
   - Advanced System Settings > Environment Variables
   - Edit "Path" variable
   - Add: C:\gbdk\bin
4. Restart terminal
```

</details>

✅ **Checkpoint 2:** GBDK installed successfully!

---

### Step 1.4: Install Game Boy Emulator

**Choose one (hoặc cài cả ba để thử):**

#### Option A: SameBoy (Recommended, cross-platform)

**Linux:**
```bash
# Ubuntu/Debian
sudo apt install sameboy

# Verify
sameboy --version
```

**macOS:**
```bash
brew install sameboy

# Verify
sameboy --version
```

**Windows:**
- Download: https://sameboy.github.io/downloads/
- Extract và chạy `sameboy.exe`

#### Option B: mGBA (Also supports GBA)

**Linux:**
```bash
sudo apt install mgba-qt

# Verify
mgba-qt --version
```

**macOS:**
```bash
brew install mgba

# Verify
mgba-qt --version
```

**Windows:**
- Download: https://mgba.io/downloads.html
- Install và chạy

#### Option C: BGB (Windows only, best debugger)

**Windows:**
- Download: https://bgb.bircd.org/
- Extract và chạy `bgb.exe`

**No emulator? No problem!**
- Có thể test trực tiếp trên Tinker Board sau

✅ **Checkpoint 3:** Emulator installed (hoặc skip để test trên Tinker Board)

---

## 🎮 Part 2: Build Chicken Shooter Game

### Step 2.1: Navigate to Game Directory

```bash
cd ~/Projects/Project_MES/game_project/chicken_shooter_gb

# Verify files
ls -la
```

**Expected files:**
```
main.c       # Game source code
Makefile     # Build system
README.md    # Documentation
```

---

### Step 2.2: Build the Game

```bash
# Clean any previous builds (if any)
make clean

# Build ROM
make
```

**Expected output:**
```
lcc -Wa-l -Wl-m -Wl-j -o chicken_shooter.gb main.c

✓ Build complete!
✓ ROM created: chicken_shooter.gb

To test on emulator:
  make test

To deploy to Tinker Board:
  make deploy IP=192.168.1.XXX
```

**If build fails:**

<details>
<summary>Common errors và fixes</summary>

#### Error: "lcc: command not found"
```bash
# GBDK not in PATH
# Run:
source ~/.bashrc  # or ~/.zshrc
# Or reinstall GBDK
```

#### Error: "make: command not found"
```bash
# Install make
sudo apt install build-essential  # Linux
xcode-select --install            # macOS
```

#### Error: Permission denied
```bash
chmod +x Makefile
```

</details>

**Verify ROM created:**
```bash
ls -lh chicken_shooter.gb
```

**Expected:**
```
-rw-r--r-- 1 user user 32K Nov 6 12:34 chicken_shooter.gb
```

✅ **Checkpoint 4:** Game ROM built successfully!

---

### Step 2.3: Test on Emulator (Optional)

```bash
# Auto-detect emulator and run
make test
```

**Or manually:**
```bash
# SameBoy
sameboy chicken_shooter.gb

# mGBA
mgba-qt chicken_shooter.gb

# BGB (Windows)
bgb.exe chicken_shooter.gb
```

**Test the game:**
- ⬅️➡️ **Arrow keys**: Move ship left/right
- **Z or X key**: Fire bullet
- **Enter**: Start game
- **ESC**: Quit

**Expected behavior:**
- Title screen appears
- Press Start (Enter)
- Player ship at bottom
- Chickens spawn and fall
- Bullets fire when pressing Z/X
- Score increases when hitting chickens
- Game Over when chicken hits player

**Working? Perfect! 🎉**

✅ **Checkpoint 5:** Game tested và chạy được!

---

## 🔧 Part 3: Setup Tinker Board with Lakka

### Step 3.1: Prepare Hardware

**Checklist:**
```
□ Tinker Board (original, S, or 2)
□ MicroSD card (16GB+ recommended: 32GB)
□ SD card reader (để ghi image)
□ 5V/3A power supply
□ HDMI cable
□ TV or Monitor
□ USB Keyboard (for initial setup)
□ Ethernet cable or WiFi
```

---

### Step 3.2: Download Lakka

**From your computer:**

1. Visit: https://lakka.tv/get/

2. Select board:
   - **Tinker Board** (RK3288)
   - **Tinker Board S** (RK3288)
   - **Tinker Board 2** (RK3399) - Different image!

3. Download image (`.img.gz` file)
   - File size: ~400-500MB compressed

**Example:**
```
Lakka-RK3288.arm-4.3.img.gz  (for Tinker Board/S)
```

---

### Step 3.3: Flash Lakka to SD Card

#### Download Etcher:
- Website: https://etcher.balena.io/
- Có cho Linux, macOS, Windows

#### Flash steps:

1. **Insert SD card** vào máy tính

2. **Open Etcher**

3. **Select image:**
   - Click "Flash from file"
   - Choose downloaded `.img.gz` file

4. **Select target:**
   - Choose SD card
   - ⚠️ **CAREFUL:** Ensure chọn đúng drive!

5. **Flash:**
   - Click "Flash!"
   - Wait 5-10 minutes
   - Etcher sẽ verify sau khi flash

6. **Eject SD card**

✅ **Checkpoint 6:** Lakka flashed to SD card!

---

### Step 3.4: First Boot Lakka

1. **Insert SD card** vào Tinker Board

2. **Connect:**
   - HDMI → TV/Monitor
   - Keyboard → USB port
   - Power → 5V/3A adapter

3. **Power on:**
   - LED sẽ blink
   - Wait 30-60 seconds for first boot
   - RetroArch XMB menu xuất hiện

**First boot screen:**
```
┌──────────────────────────┐
│   LAKKA                  │
│   Main Menu              │
│   > Load Core            │
│     Load Content         │
│     Online Updater       │
│     Settings             │
│     Information          │
└──────────────────────────┘
```

**Navigation:**
- **Arrow keys**: Di chuyển
- **Enter/A**: Select
- **Backspace/B**: Back
- **F1**: Open menu in-game

✅ **Checkpoint 7:** Lakka booted successfully!

---

### Step 3.5: Configure Network

#### Option A: WiFi

```
1. Main Menu > Settings > WiFi
2. Enable WiFi: ON
3. SSID: [Your WiFi name]
4. Password: [Your WiFi password]
5. Connect
6. Wait 10-20 seconds
```

#### Option B: Ethernet (Easier)

```
1. Plug Ethernet cable
2. Wait 10 seconds
3. Auto DHCP
```

**Verify network:**
```
Main Menu > Information > Network Information
```

**Note the IP address!** Example: `192.168.1.100`

✅ **Checkpoint 8:** Network configured!

---

### Step 3.6: Enable SSH and Samba

```
Main Menu > Settings > Services

1. SSH:
   - Enable: ON
   - Port: 22

2. Samba:
   - Enable: ON

Press ESC to save
```

**Verify from your computer:**

```bash
# SSH test (password: root)
ssh root@192.168.1.100

# If successful, you'll see:
# Lakka (official) Version: 4.3
# Welcome to Lakka!

# Exit SSH:
exit
```

✅ **Checkpoint 9:** SSH and Samba enabled!

---

### Step 3.7: Install Game Boy Core

**On Tinker Board (using keyboard):**

```
1. Main Menu > Online Updater
2. Core Downloader
3. Scroll to find: "Nintendo - Game Boy / Color (Gambatte)"
4. Press Enter to download
5. Wait for "Core installed"
6. Press B to go back
```

**Also recommended (optional):**
- "Nintendo - Game Boy / Color (SameBoy)"
- "Nintendo - Game Boy Advance (mGBA)"

**Verify cores installed:**
```
Main Menu > Load Core
# You should see:
- Gambatte
- (SameBoy if installed)
```

✅ **Checkpoint 10:** Game Boy core installed!

---

## 📦 Part 4: Deploy Game to Tinker Board

### Step 4.1: Deploy via Make Command (Easiest)

**From your computer:**

```bash
# Navigate to game directory
cd ~/Projects/Project_MES/game_project/chicken_shooter_gb

# Deploy (replace IP with your Tinker Board IP)
make deploy IP=192.168.1.100

# Enter password when prompted: root
```

**Expected output:**
```
Deploying to Tinker Board at 192.168.1.100...
chicken_shooter.gb            100%   32KB   1.2MB/s   00:00
✓ Deployed successfully!

On Lakka:
1. Main Menu > Import Content > Scan Directory
2. Select /storage/roms/Game Boy/
3. Find 'Chicken Shooter' in Game Boy collection
4. Play!
```

✅ **Checkpoint 11:** Game deployed to Tinker Board!

---

### Step 4.2: Alternative Deploy Methods

<details>
<summary>Method 2: Manual SCP (if make deploy fails)</summary>

```bash
# From your computer
scp chicken_shooter.gb root@192.168.1.100:"/storage/roms/Game Boy/"

# Password: root
```

</details>

<details>
<summary>Method 3: Via Samba (Windows/Mac GUI)</summary>

**Windows:**
```
1. Open File Explorer
2. Address bar: \\192.168.1.100\roms
3. Navigate to: Game Boy\
4. Copy chicken_shooter.gb here
```

**macOS:**
```
1. Finder > Go > Connect to Server (⌘K)
2. Server: smb://192.168.1.100/roms
3. Navigate to: Game Boy/
4. Copy chicken_shooter.gb here
```

**Linux:**
```bash
# Mount Samba share
mkdir -p ~/tinker_roms
sudo mount -t cifs //192.168.1.100/roms ~/tinker_roms -o username=root,password=root

# Copy ROM
cp chicken_shooter.gb ~/tinker_roms/Game\ Boy/

# Unmount
sudo umount ~/tinker_roms
```

</details>

---

### Step 4.3: Import Game in Lakka

**On Tinker Board:**

```
1. Main Menu > Import Content
2. Scan Directory
3. Navigate to: /storage/roms/Game Boy/
4. Select and press Enter
5. Wait for scan (10-20 seconds)
6. "Scan complete" message
```

**Verify import:**
```
1. Main Menu
2. Scroll down to see: "Nintendo - Game Boy"
3. Enter
4. You should see: "Chicken Shooter"
```

✅ **Checkpoint 12:** Game imported into Lakka!

---

## 🎮 Part 5: Play Game on Tinker Board!

### Step 5.1: Launch Game

**On Tinker Board:**

```
1. Main Menu
2. Nintendo - Game Boy
3. Chicken Shooter
4. Press Enter/A to launch
5. Game starts!
```

**First launch:**
- Core will load (~2 seconds)
- Game title screen appears
- Press Start (or Enter on keyboard)

---

### Step 5.2: Controls

#### Keyboard:
- **Arrow Keys**: Move ship left/right
- **Z**: Fire bullet (Button A)
- **Enter**: Start game
- **F1**: Open RetroArch menu
- **F2**: Save state
- **F4**: Load state
- **ESC**: Exit game

#### USB Controller (if connected):
- **D-Pad**: Move
- **A button**: Fire
- **Start**: Start game
- **Select + Start**: Exit

---

### Step 5.3: Gameplay

**Objective:**
- 🎯 Bắn những con gà rơi xuống
- 🔫 Di chuyển tàu tránh gà
- 💯 Đạt điểm cao nhất

**Tips:**
- Có cooldown giữa các shot (0.25 giây)
- Gà spawn ngẫu nhiên
- Game over khi gà đâm vào tàu
- Restart bằng cách press Start

---

### Step 5.4: Save State (Optional)

**During gameplay:**

```
1. Press F1 (open menu)
2. Quick Menu > Save State
3. Or press F2 directly
4. Continue playing

To load:
- Press F4
- Or F1 > Quick Menu > Load State
```

---

## 🎉 Success! You're Playing!

**Congratulations! 🎊 Bạn đã:**

✅ Setup development environment
✅ Cloned repository
✅ Built Game Boy game
✅ Setup Lakka on Tinker Board
✅ Deployed game
✅ Playing on TV/Monitor!

---

## 📊 Quick Troubleshooting

### Game không build:
```bash
# Check GBDK
lcc -v

# If not found:
source ~/.bashrc
# or reinstall GBDK

# Clean and rebuild
make clean && make
```

### Không SSH được vào Tinker Board:
```bash
# Check IP correct:
# On Lakka: Main Menu > Information > Network Information

# Check SSH enabled:
# On Lakka: Settings > Services > SSH: ON

# Test connection:
ping 192.168.1.100
```

### Game không xuất hiện trong Lakka:
```bash
# SSH vào Tinker Board
ssh root@192.168.1.100

# Check file tồn tại:
ls -lh /storage/roms/Game\ Boy/

# If file not there, deploy lại:
exit
make deploy IP=192.168.1.100
```

### Game lag hoặc chậm:
```
# Very unlikely với Game Boy games
# Nhưng nếu có:
1. F1 > Quick Menu > Options
2. Check settings
3. Or try different core (SameBoy thay vì Gambatte)
```

---

## 🚀 Next Steps

### 1. Customize the Game

```bash
# Edit source code
cd ~/Projects/Project_MES/game_project/chicken_shooter_gb
nano main.c  # or code main.c

# Make changes (see README.md for examples)

# Rebuild
make clean && make

# Test locally
make test

# Redeploy
make deploy IP=192.168.1.100
```

### 2. Add More ROMs

```bash
# Copy ROMs via Samba
# Windows: \\192.168.1.100\roms
# macOS: smb://192.168.1.100/roms

# Or SCP:
scp game.nes root@192.168.1.100:/storage/roms/NES/
scp game.sfc root@192.168.1.100:/storage/roms/SNES/

# Scan in Lakka:
# Main Menu > Import Content > Scan Directory
```

### 3. Explore Advanced Features

**Read documentation:**
- `HYBRID_ROADMAP.md` - 6-8 week development plan
- `IMPLEMENTATION_PLAN.md` - Advanced Lakka features
- `docs/AVAILABLE_TOOLS.md` - All built-in tools
- `docs/TROUBLESHOOTING.md` - Common issues

### 4. Join Communities

- **Lakka Forums**: https://forums.lakka.tv/
- **GBDev Discord**: https://discord.gg/gbdev
- **RetroArch Discord**: https://discord.gg/retroarch
- **Reddit**: r/retrogaming, r/Gameboy

---

## 📚 Command Reference

### Quick Commands Summary:

```bash
# DEVELOPMENT
cd ~/Projects/Project_MES/game_project/chicken_shooter_gb
make              # Build
make test         # Test on emulator
make clean        # Clean builds
make deploy IP=X  # Deploy to Tinker Board

# TINKER BOARD ACCESS
ssh root@192.168.1.100      # SSH (password: root)
# Samba: \\192.168.1.100\roms

# LAKKA SCRIPTS (via SSH)
cd /storage/scripts
./system_info.sh       # System info
./backup_saves.sh      # Backup
./rom_organizer.sh     # Organize ROMs
```

---

## 🔖 Checklist: Full Setup

Print and check off as you complete:

### Development Environment
- [ ] Git installed
- [ ] Repository cloned
- [ ] GBDK installed (`lcc -v` works)
- [ ] Emulator installed (optional)

### Build Game
- [ ] Navigated to `chicken_shooter_gb/`
- [ ] `make` successful
- [ ] `chicken_shooter.gb` created
- [ ] Tested on emulator (optional)

### Tinker Board Setup
- [ ] SD card flashed with Lakka
- [ ] Tinker Board boots to Lakka
- [ ] Network configured
- [ ] IP address noted: `___.___.___.___`
- [ ] SSH enabled and tested
- [ ] Samba enabled
- [ ] Gambatte core installed

### Deploy Game
- [ ] Game deployed via `make deploy`
- [ ] File exists in `/storage/roms/Game Boy/`
- [ ] Content scanned in Lakka
- [ ] Game appears in "Nintendo - Game Boy" collection

### Play
- [ ] Game launches
- [ ] Controls work
- [ ] Gameplay smooth
- [ ] Save states work

### Done!
- [ ] 🎉 **Playing Chicken Shooter on Tinker Board!**

---

## 💾 Backup Your Work

```bash
# Backup game project
cd ~/Projects/Project_MES
git status
git add .
git commit -m "My custom changes"

# Backup Lakka saves (via SSH)
ssh root@192.168.1.100
cd /storage/scripts
./backup_saves.sh
```

---

## ⚡ Pro Tips

1. **Use SSH keys** (không cần gõ password mỗi lần):
```bash
ssh-keygen -t rsa
ssh-copy-id root@192.168.1.100
```

2. **Alias for quick access**:
```bash
# Add to ~/.bashrc or ~/.zshrc
alias tinker='ssh root@192.168.1.100'
alias deploy-game='cd ~/Projects/Project_MES/game_project/chicken_shooter_gb && make deploy IP=192.168.1.100'

# Usage:
tinker          # SSH instantly
deploy-game     # Deploy from anywhere
```

3. **Controller configuration**:
```
# On Lakka:
Settings > Input > Port 1 Controls > Set All Controls
# Map mỗi button một lần, works cho mọi games
```

---

**🎮 Happy Gaming! Have fun với Chicken Shooter và retro gaming! 🐔**

---

**Document version:** 1.0
**Last updated:** 2025-11-06
**Tested on:** Ubuntu 22.04, macOS Monterey, Tinker Board S
**Lakka version:** 4.3
