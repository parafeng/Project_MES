# Project MES - Game Emulation System cho Tinker Board

## Tổng quan
Dự án xây dựng hệ thống giả lập game retro trên Tinker Board sử dụng Lakka (Linux distribution chuyên biệt cho retro gaming), RetroArch front-end và Libretro cores.

## Tính năng chính
- ✅ Giả lập nhiều nền tảng game console cổ điển (NES, SNES, Genesis, PSX, N64, v.v.)
- ✅ Giao diện thân thiện với RetroArch GUI
- ✅ Hỗ trợ controllers qua USB và Bluetooth
- ✅ Save states và auto-save
- ✅ Shaders (hiệu ứng CRT/Pixel)
- ✅ Netplay (chơi online)
- ✅ Scripts quản lý và backup tự động

## Bắt đầu nhanh
**Đọc ngay:** [QUICK_START.md](QUICK_START.md) - Hướng dẫn 30 phút để cài đặt và chơi game đầu tiên!

## Tài liệu chi tiết
- 📖 [IMPLEMENTATION_PLAN.md](IMPLEMENTATION_PLAN.md) - Kế hoạch thực hiện chi tiết từng giai đoạn
- 📖 [docs/AVAILABLE_TOOLS.md](docs/AVAILABLE_TOOLS.md) - Danh sách công cụ và cores có sẵn
- 📖 [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md) - Giải quyết các vấn đề thường gặp

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
└── docs/                 # Tài liệu bổ sung
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

## Development

### Tạo Homebrew Game (Optional)
Nếu muốn tự tạo game (ví dụ: game bắn gà), xem:
- [docs/HOMEBREW_DEVELOPMENT.md](docs/HOMEBREW_DEVELOPMENT.md)

### Công cụ phát triển
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