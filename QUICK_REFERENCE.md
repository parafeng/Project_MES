# ⚡ Quick Reference Card

## 🚀 Setup trong 30 phút (TL;DR)

### Prerequisites
```bash
# Install Git
sudo apt install git  # Linux
brew install git      # macOS

# Clone repo
git clone https://github.com/parafeng/Project_MES.git
cd Project_MES
git checkout claude/tinker-board-emulation-setup-011CUr7ZLtZbZASdm9oka2ot
```

### Build Game
```bash
# Setup GBDK
cd game_project
./setup_gbdk.sh
source ~/.bashrc  # or ~/.zshrc on Mac

# Build
cd chicken_shooter_gb
make

# Test
make test  # On emulator

# Deploy
make deploy IP=192.168.1.100  # To Tinker Board
```

### Lakka Setup
```
1. Download: https://lakka.tv/get/ (chọn Tinker Board)
2. Flash với Etcher: https://etcher.balena.io/
3. Boot Tinker Board
4. Settings > WiFi/Ethernet
5. Settings > Services > SSH & Samba: ON
6. Online Updater > Core Downloader > Gambatte
7. Import Content > Scan Directory > /storage/roms/Game Boy/
8. Nintendo - Game Boy > Chicken Shooter > Play!
```

---

## 📋 Command Cheat Sheet

### Game Development
```bash
# Navigate
cd ~/Projects/Project_MES/game_project/chicken_shooter_gb

# Build
make                    # Compile ROM
make clean              # Clean builds
make test               # Test on emulator
make help               # Show all commands

# Deploy
make deploy IP=192.168.1.100
```

### Tinker Board Access
```bash
# SSH (password: root)
ssh root@192.168.1.100

# SCP deploy
scp chicken_shooter.gb root@192.168.1.100:"/storage/roms/Game Boy/"

# Samba
# Windows: \\192.168.1.100\roms
# Mac/Linux: smb://192.168.1.100/roms
```

### Lakka Scripts (via SSH)
```bash
cd /storage/scripts

./system_info.sh          # System information
./backup_saves.sh         # Backup saves
./restore_backup.sh FILE  # Restore backup
./rom_organizer.sh DIR    # Organize ROMs
./performance_test.sh     # Performance test
```

---

## 🎮 Keyboard Controls

### In Game
- **Arrow Keys** - Move ship
- **Z / X** - Fire bullet
- **Enter** - Start
- **ESC** - Exit to menu

### RetroArch Hotkeys
- **F1** - Open menu
- **F2** - Save state
- **F4** - Load state
- **F6/F7** - State slot -/+
- **F9** - Screenshot
- **Space** - Fast forward

---

## 🔧 Quick Fixes

### Build Error
```bash
make clean && make
lcc -v  # Check GBDK installed
source ~/.bashrc
```

### Can't SSH
```bash
# Check IP
ping 192.168.1.100

# Enable SSH on Lakka:
# Settings > Services > SSH: ON
```

### Game Not Appearing
```bash
# Check file exists
ssh root@192.168.1.100
ls /storage/roms/Game\ Boy/

# Rescan
# Lakka: Import Content > Scan Directory
```

---

## 📁 Directory Structure

```
Project_MES/
├── game_project/chicken_shooter_gb/
│   ├── main.c                    # Edit this
│   ├── Makefile                  # Build config
│   └── chicken_shooter.gb        # Output ROM
├── scripts/                      # Lakka utilities
├── docs/                         # Documentation
├── SETUP_GUIDE.md               # Full guide
└── QUICK_REFERENCE.md           # This file
```

---

## 🎯 File Locations

### On Development Machine
- **Game source**: `~/Projects/Project_MES/game_project/chicken_shooter_gb/main.c`
- **Built ROM**: `~/Projects/Project_MES/game_project/chicken_shooter_gb/chicken_shooter.gb`
- **GBDK**: `~/gbdk/`

### On Tinker Board
- **ROMs**: `/storage/roms/[Platform]/`
- **Saves**: `/storage/savefiles/`
- **Save states**: `/storage/savestates/`
- **Scripts**: `/storage/scripts/`
- **Config**: `/storage/.config/retroarch/`

---

## 🌐 Network

### Default Credentials
- **SSH Username**: `root`
- **SSH Password**: `root`
- **Samba Username**: `root` (or blank)
- **Samba Password**: `root` (or blank)

### Common IPs
- Check on Lakka: `Settings > Information > Network Information`
- Usually: `192.168.1.x` or `192.168.0.x`

---

## 🔄 Workflow

### Develop → Test → Deploy Loop

```bash
# 1. Edit code
nano main.c  # or code main.c

# 2. Build
make clean && make

# 3. Test locally (optional)
make test

# 4. Deploy to Tinker
make deploy IP=192.168.1.100

# 5. Play on Tinker Board
# Lakka: Nintendo - Game Boy > Chicken Shooter

# 6. Repeat
```

---

## 📖 Documentation Quick Links

### Guides
- **[SETUP_GUIDE.md](SETUP_GUIDE.md)** - Full setup (2-3 hours)
- **[QUICK_START.md](QUICK_START.md)** - Lakka quick start (30 min)
- **[HYBRID_ROADMAP.md](HYBRID_ROADMAP.md)** - 6-8 week roadmap

### Game Development
- **[game_project/chicken_shooter_gb/README.md](game_project/chicken_shooter_gb/README.md)** - Game docs
- **[docs/HOMEBREW_DEVELOPMENT.md](docs/HOMEBREW_DEVELOPMENT.md)** - Full tutorial

### Reference
- **[docs/AVAILABLE_TOOLS.md](docs/AVAILABLE_TOOLS.md)** - Lakka tools
- **[docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md)** - Common issues
- **[IMPLEMENTATION_PLAN.md](IMPLEMENTATION_PLAN.md)** - Detailed plan

---

## 🎨 Customize Game

### Change Speed
```c
// main.c line ~150
player.x -= 3;  // Faster (was 2)

// line ~245
bullets[i].y -= 5;  // Faster bullets (was 3)

// line ~270
enemies[i].y += 2;  // Faster enemies (was 1)
```

### Change Spawn Rate
```c
// main.c line ~370
if (spawn_timer > 40) {  // More frequent (was 60)
```

### More Enemies/Bullets
```c
// main.c line 65-66
#define MAX_ENEMIES 8  // More enemies (was 5)
#define MAX_BULLETS 5  // More bullets (was 3)
```

**After changes:**
```bash
make clean && make && make deploy IP=192.168.1.100
```

---

## 🆘 Emergency Recovery

### Reset Lakka
```bash
# Re-flash SD card with Etcher
# All settings lost, but starts fresh
```

### Factory Reset (Keep ROMs)
```bash
# SSH
ssh root@192.168.1.100
rm -rf /storage/.config/*
reboot
```

### Backup Everything
```bash
# SSH
ssh root@192.168.1.100
cd /storage/scripts
./backup_saves.sh

# Download backup
scp root@192.168.1.100:/storage/backups/*.tar.gz ~/
```

---

## 💡 Pro Tips

### 1. Aliases
```bash
# Add to ~/.bashrc or ~/.zshrc
alias cdgame='cd ~/Projects/Project_MES/game_project/chicken_shooter_gb'
alias build='make clean && make'
alias deploy='make deploy IP=192.168.1.100'
alias tinker='ssh root@192.168.1.100'

# Usage:
cdgame && build && deploy
```

### 2. Watch Mode (Auto-rebuild on change)
```bash
# Install entr
sudo apt install entr  # Linux
brew install entr      # Mac

# Watch and rebuild
ls main.c | entr make clean && make
```

### 3. Quick Deploy Script
```bash
# Create ~/deploy.sh
#!/bin/bash
cd ~/Projects/Project_MES/game_project/chicken_shooter_gb
make clean && make && make deploy IP=192.168.1.100

# Make executable
chmod +x ~/deploy.sh

# Usage:
~/deploy.sh
```

---

## 📊 Checklist

### First Time Setup
- [ ] Git installed
- [ ] Repo cloned
- [ ] GBDK installed
- [ ] Emulator installed (optional)
- [ ] Game built successfully
- [ ] Lakka flashed to SD
- [ ] Tinker Board booted
- [ ] Network configured
- [ ] SSH/Samba enabled
- [ ] Gambatte core installed
- [ ] Game deployed
- [ ] Game imported in Lakka
- [ ] Playing on TV! 🎉

### Daily Development
- [ ] Edit main.c
- [ ] `make clean && make`
- [ ] Test on emulator
- [ ] Deploy to Tinker
- [ ] Test on hardware
- [ ] Commit changes to git

---

## 🔗 External Resources

### Download Links
- **Lakka**: https://lakka.tv/get/
- **Etcher**: https://etcher.balena.io/
- **GBDK**: https://github.com/gbdk-2020/gbdk-2020/releases
- **SameBoy**: https://sameboy.github.io/
- **mGBA**: https://mgba.io/

### Learning
- **GBDev**: https://gbdev.io/
- **GBDK Docs**: https://gbdk-2020.github.io/gbdk-2020/docs/api/
- **Lakka Docs**: https://lakka.tv/doc/
- **RetroArch Docs**: https://docs.libretro.com/

### Community
- **Discord**: GBDev, RetroArch
- **Reddit**: r/Gameboy, r/RetroArch, r/emulation
- **Forums**: Lakka Forums, NESdev

---

## ⏱️ Time Estimates

| Task | Time |
|------|------|
| Clone repo | 2 min |
| Install GBDK | 5 min |
| Build game | 1 min |
| Flash Lakka | 10 min |
| Setup network | 5 min |
| Install core | 3 min |
| Deploy game | 2 min |
| **Total** | **~30 min** |

*Plus ~1 hour for Lakka download if slow internet*

---

## 🎯 Success Criteria

### You're done when:
✅ `make` produces `chicken_shooter.gb`
✅ Game runs on emulator
✅ Lakka boots on Tinker Board
✅ SSH works: `ssh root@192.168.1.100`
✅ Game appears in "Nintendo - Game Boy"
✅ Game plays on TV with no lag
✅ Controls responsive

---

**Print this page for quick reference while working! 📄**

**Version:** 1.0 | **Updated:** 2025-11-06
