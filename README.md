# Project MES - Game Emulation System cho Tinker Board

## Tổng quan
Dự án xây dựng hệ thống giả lập game retro trên Tinker Board sử dụng Lakka (Linux distribution chuyên biệt cho retro gaming), RetroArch front-end và Libretro cores.

## Tính năng chính

### Emulation System
- ✅ Giả lập nhiều nền tảng game console cổ điển (NES, SNES, Genesis, PSX, N64, v.v.)
- ✅ Giao diện thân thiện với RetroArch GUI
- ✅ Hỗ trợ controllers qua USB và Bluetooth
- ✅ Save states và auto-save
- ✅ Shaders (hiệu ứng CRT/Pixel)
- ✅ Netplay (chơi online)
- ✅ Scripts quản lý và backup tự động

### Game Development (NEW! 🎮)
- ✅ Complete Game Boy Chicken Shooter game
- ✅ Full source code với comments
- ✅ One-command build system
- ✅ Auto-deploy to Tinker Board
- ✅ GBDK setup script

## Bắt đầu nhanh

### 📚 **NEW! Complete Setup Guide**
**👉 [SETUP_GUIDE.md](SETUP_GUIDE.md) - Hướng dẫn từ Zero đến Hero (2-3 giờ)**

Chi tiết từng bước:
- ✅ Setup môi trường development
- ✅ Clone repository và build game
- ✅ Setup Lakka trên Tinker Board
- ✅ Deploy game và chơi trên TV!

**Hoặc [QUICK_REFERENCE.md](QUICK_REFERENCE.md) - Cheat sheet cho người đã quen (5 phút)**

---

### 🎯 Chọn lộ trình của bạn:

1. **Chỉ Emulation System** (Setup Lakka, chơi retro games)
   - 📖 Đọc: [QUICK_START.md](QUICK_START.md) - 30 phút setup

2. **Chỉ Game Development** (Build Chicken Shooter game)
   - 📖 Đọc: [game_project/chicken_shooter_gb/README.md](game_project/chicken_shooter_gb/README.md)
   - 🚀 Run: `./game_project/setup_gbdk.sh`

3. **⭐ HYBRID (Recommended!)** - Làm cả hai!
   - 📖 Đọc: [HYBRID_ROADMAP.md](HYBRID_ROADMAP.md) - 6-8 tuần roadmap
   - Setup emulation system + Build game riêng

4. **🚀 Complete Step-by-Step** - Từ đầu đến cuối!
   - 📖 Đọc: [SETUP_GUIDE.md](SETUP_GUIDE.md) - Chi tiết mọi bước
   - Clone → Build → Deploy → Play!

## Tài liệu chi tiết

### 🎯 Getting Started (Bắt đầu)
- 📖 **[SETUP_GUIDE.md](SETUP_GUIDE.md)** - ⭐ Complete setup từ đầu đến cuối (2-3h)
- 📖 **[QUICK_REFERENCE.md](QUICK_REFERENCE.md)** - ⚡ Cheat sheet nhanh (5 min)
- 📖 [QUICK_START.md](QUICK_START.md) - Lakka quick start (30 min)
- 📖 [HYBRID_ROADMAP.md](HYBRID_ROADMAP.md) - Roadmap 6-8 tuần kết hợp cả hai

### Emulation System
- 📖 [IMPLEMENTATION_PLAN.md](IMPLEMENTATION_PLAN.md) - Kế hoạch thực hiện chi tiết 10 giai đoạn
- 📖 [docs/AVAILABLE_TOOLS.md](docs/AVAILABLE_TOOLS.md) - Danh sách công cụ và cores có sẵn
- 📖 [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) - Giải quyết các vấn đề thường gặp

### Game Development
- 📖 [docs/HOMEBREW_DEVELOPMENT.md](docs/HOMEBREW_DEVELOPMENT.md) - Hướng dẫn tạo homebrew games
- 📖 [game_project/chicken_shooter_gb/README.md](game_project/chicken_shooter_gb/README.md) - Chicken Shooter guide

## Cấu trúc dự án
```
Project_MES/
├── scripts/              # Scripts tiện ích
│   ├── backup_saves.sh      # Backup save files
│   ├── restore_backup.sh    # Restore từ backup
│   ├── rom_organizer.sh     # Sắp xếp ROMs tự động
│   ├── system_info.sh       # Hiển thị thông tin hệ thống
│   └── performance_test.sh  # Test hiệu năng
├── configs/              # File cấu hình mẫu
│   └── retroarch_optimal.cfg  # RetroArch config tối ưu
├── docs/                 # Tài liệu bổ sung
│   ├── AVAILABLE_TOOLS.md       # Danh sách công cụ built-in
│   ├── HOMEBREW_DEVELOPMENT.md  # Game development guide
│   └── TROUBLESHOOTING.md       # Giải quyết vấn đề
└── game_project/         # 🎮 Game development
    ├── setup_gbdk.sh         # GBDK auto-installer
    └── chicken_shooter_gb/   # Complete Game Boy game
        ├── main.c               # Game source code
        ├── Makefile             # Build system
        └── README.md            # Game documentation
```

## Scripts có sẵn

### 1. System Info - Thông tin hệ thống
```bash
ssh root@[IP_ADDRESS]
cd /storage/scripts
./system_info.sh
```
Hiển thị: CPU, nhiệt độ, RAM, storage, cores đã cài, ROMs summary

### 2. Backup Saves - Sao lưu
```bash
./backup_saves.sh
```
Backup save states, save files, configs, playlists

### 3. Restore Backup - Khôi phục
```bash
./restore_backup.sh /storage/backups/lakka_backup_YYYYMMDD.tar.gz
```

### 4. ROM Organizer - Tự động sắp xếp ROMs
```bash
./rom_organizer.sh /storage/roms/unsorted
```
Tự động phân loại ROMs vào thư mục platform phù hợp

### 5. Performance Test
```bash
./performance_test.sh
```
Test CPU, storage speed, nhiệt độ

## Yêu cầu phần cứng
- **Board**: Tinker Board / Tinker Board S / Tinker Board 2
- **Storage**: Thẻ nhớ/eMMC tối thiểu 16GB (khuyến nghị 32GB+)
- **Nguồn**: 5V/3A
- **Controllers**: USB gamepad hoặc Bluetooth controller
- **Display**: HDMI (hỗ trợ 1080p/4K)

## Platforms được hỗ trợ tốt
| Platform | Performance | Cores khuyến nghị |
|----------|-------------|-------------------|
| NES | ⭐⭐⭐⭐⭐ | FCEUmm, Nestopia |
| SNES | ⭐⭐⭐⭐⭐ | Snes9x |
| Genesis | ⭐⭐⭐⭐⭐ | Genesis Plus GX |
| Game Boy/GBC/GBA | ⭐⭐⭐⭐⭐ | Gambatte, mGBA |
| PlayStation 1 | ⭐⭐⭐⭐ | Beetle PSX HW |
| N64 | ⭐⭐⭐ | Mupen64Plus-Next |
| Arcade | ⭐⭐⭐⭐ | FBNeo, MAME 2003+ |

## Workflow cơ bản

### 1. Cài đặt Lakka
```bash
# Download Lakka image cho Tinker Board
# Ghi lên thẻ nhớ bằng Etcher
# Boot và cấu hình network
```

### 2. Cài đặt Cores
```
Main Menu > Online Updater > Core Downloader
# Chọn cores cần thiết
```

### 3. Thêm ROMs
```
# Qua Samba: \\[IP_ADDRESS]\roms
# Hoặc qua SSH/SFTP
# Sau đó: Import Content > Scan Directory
```

### 4. Chơi!
```
Main Menu > [Platform Collection] > [Game] > Run
```

## 🎮 Game Development - Chicken Shooter

### Quick Start
```bash
# 1. Setup GBDK
cd game_project
./setup_gbdk.sh

# 2. Build game
cd chicken_shooter_gb
make

# 3. Test on emulator
make test

# 4. Deploy to Tinker Board
make deploy IP=192.168.1.XXX
```

### Game Features
- 🐔 **Simple shoot-em-up**: Bắn những con gà rơi xuống!
- 🎮 **Game Boy native**: Chạy trên hardware thật hoặc emulator
- 💯 **Score tracking**: Theo dõi điểm số
- 🔫 **Bullet system**: Bắn đạn với cooldown
- 💥 **Collision detection**: Đạn vs gà, gà vs player
- 🎯 **Game over**: Khi bị gà đâm

### Technologies
- **Platform**: Game Boy / Game Boy Color
- **Language**: C
- **Compiler**: GBDK-2020 (Game Boy Development Kit)
- **Build**: Make
- **Test**: SameBoy, BGB, mGBA emulators

### Development Guide
Xem chi tiết:
- [game_project/chicken_shooter_gb/README.md](game_project/chicken_shooter_gb/README.md) - Build & deploy guide
- [docs/HOMEBREW_DEVELOPMENT.md](docs/HOMEBREW_DEVELOPMENT.md) - Full tutorial với code samples

### Công cụ phát triển cho platforms khác
- **NES**: cc65 (C compiler), NESASM (assembler)
- **SNES**: WLA-DX, bass
- **Genesis**: SGDK (Sega Genesis Development Kit)
- **GBA**: devkitARM, grit

## Troubleshooting
Xem [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) cho các vấn đề:
- Game chạy chậm
- Không có âm thanh
- Controller không hoạt động
- Network issues

## License
MIT License - Xem file [LICENSE](LICENSE)

## Tài nguyên hữu ích
- **Lakka Documentation**: https://lakka.tv/doc/
- **RetroArch Docs**: https://docs.libretro.com/
- **Libretro Cores**: https://docs.libretro.com/library/
- **Homebrew ROMs**: https://pdroms.de/

## Đóng góp
Pull requests are welcome! Để đóng góp:
1. Fork repository
2. Tạo feature branch
3. Commit changes
4. Push và tạo Pull Request

## Liên hệ & Support
- Issues: Sử dụng GitHub Issues
- Discussions: GitHub Discussions
- Wiki: Đang phát triển

---

**Status**: 🚧 Work in Progress - Đang phát triển

**Last Updated**: 2025-11-06