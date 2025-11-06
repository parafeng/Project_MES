# 🐔 Chicken Shooter - Game Boy Game

Simple vertical shoot-em-up game cho Game Boy. Bắn những con gà rơi xuống!

## Game Features
- ✈️ Di chuyển tàu trái/phải
- 🔫 Bắn đạn lên
- 🐔 Gà rơi xuống ngẫu nhiên
- 💥 Collision detection
- 💯 Score tracking
- 🎮 Game Over khi bị gà đâm

## Controls
- **D-PAD LEFT/RIGHT**: Di chuyển tàu
- **A Button**: Bắn đạn
- **START**: Bắt đầu game / Restart

## Screenshots
```
┌─────────────────┐
│  SCORE: 120     │
│                 │
│     🐔          │
│           🐔    │
│                 │
│   •             │  (bullets)
│                 │
│       ▲         │  (player)
└─────────────────┘
```

## Build Instructions

### 1. Cài đặt GBDK (Game Boy Development Kit)

#### Linux:
```bash
# Download GBDK
cd ~
wget https://github.com/gbdk-2020/gbdk-2020/releases/download/4.1.1/gbdk-linux64.tar.gz
tar xzf gbdk-linux64.tar.gz

# Add to PATH
echo 'export PATH="$HOME/gbdk/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Verify
lcc -v
```

#### macOS:
```bash
# Download GBDK
cd ~
wget https://github.com/gbdk-2020/gbdk-2020/releases/download/4.1.1/gbdk-macos.tar.gz
tar xzf gbdk-macos.tar.gz

# Add to PATH
echo 'export PATH="$HOME/gbdk/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Verify
lcc -v
```

#### Windows:
```powershell
# Download from: https://github.com/gbdk-2020/gbdk-2020/releases
# Extract to C:\gbdk
# Add C:\gbdk\bin to System PATH
```

### 2. Build Game

```bash
# Navigate to game directory
cd game_project/chicken_shooter_gb

# Build
make

# Output: chicken_shooter.gb
```

### 3. Test trên Emulator

#### Install emulator (chọn một):

**BGB (Windows - Best for development):**
- Download: https://bgb.bircd.org/

**SameBoy (Cross-platform):**
```bash
# Ubuntu/Debian
sudo apt install sameboy

# macOS
brew install sameboy
```

**mGBA (Cross-platform - cũng chạy GB games):**
```bash
# Ubuntu/Debian
sudo apt install mgba-qt

# macOS
brew install mgba
```

#### Run game:
```bash
# Auto-detect emulator and run
make test

# Or manually
bgb chicken_shooter.gb
# or
sameboy chicken_shooter.gb
# or
mgba chicken_shooter.gb
```

### 4. Deploy lên Tinker Board

```bash
# Build và deploy trong một lệnh
make deploy IP=192.168.1.100

# (Thay 192.168.1.100 bằng IP thật của Tinker Board)
```

#### Hoặc manual deploy:
```bash
# Copy ROM qua Samba (Windows/Mac/Linux)
# Mở \\192.168.1.100\roms\Game Boy\
# Copy chicken_shooter.gb vào đó

# Hoặc qua SCP
scp chicken_shooter.gb root@192.168.1.100:"/storage/roms/Game Boy/"
```

#### Chạy trên Lakka:
1. Main Menu > Import Content > Scan Directory
2. Select `/storage/roms/Game Boy/`
3. Wait for scan
4. Main Menu > Game Boy > Chicken Shooter
5. Press Enter/A to play!

## Development

### Project Structure
```
chicken_shooter_gb/
├── main.c           # Game source code
├── Makefile         # Build system
├── README.md        # This file
└── chicken_shooter.gb  # Output ROM (after build)
```

### Modify Game

#### Change player speed:
```c
// In update_player() function
player.x -= 2;  // Change 2 to 3 for faster
player.x += 2;  // Change 2 to 3 for faster
```

#### Change bullet speed:
```c
// In update_bullets() function
bullets[i].y -= 3;  // Change 3 to higher for faster
```

#### Change enemy speed:
```c
// In update_enemies() function
enemies[i].y += 1;  // Change 1 to 2 for faster/harder
```

#### Change spawn rate:
```c
// In main() loop
if (spawn_timer > 60) {  // Change 60 to 30 for faster spawns
```

#### Add more enemies:
```c
// At top of file
#define MAX_ENEMIES 5  // Change to 8 for more enemies
```

### Rebuild after changes:
```bash
make clean
make
make test
```

## Troubleshooting

### "lcc: command not found"
```bash
# GBDK chưa được cài hoặc không trong PATH
# Follow installation instructions above
```

### Build errors
```bash
# Clean và rebuild
make clean
make
```

### ROM không chạy trên emulator
- Ensure ROM size < 32KB (Game Boy limit)
- Try different emulator
- Check build output for errors

### Không deploy được lên Tinker Board
```bash
# Check SSH connection
ssh root@192.168.1.100

# Check Samba is enabled
# Settings > Services > Samba: ON

# Ensure /storage/roms/Game Boy/ exists
```

## Extending the Game

### Ideas for improvements:
1. **Multiple lives**: Add lives counter
2. **Power-ups**: Add special weapons
3. **Boss fights**: Add boss chickens
4. **Sound effects**: Use GB sound channels
5. **Music**: Add background music
6. **High score**: Save high score to SRAM
7. **Levels**: Add difficulty progression
8. **Different enemies**: Add egg bombs, roosters, etc.

### Learning Resources:
- **GBDK Documentation**: https://gbdk-2020.github.io/gbdk-2020/docs/api/
- **GB Dev Wiki**: https://gbdev.io/
- **Awesome GB Dev**: https://github.com/gbdev/awesome-gbdev

## Credits
- **Engine**: GBDK-2020
- **Platform**: Game Boy / Game Boy Color
- **License**: MIT

## License
Free to use, modify, and distribute. Have fun! 🎮

---

**Enjoy shooting chickens! 🐔💥**
