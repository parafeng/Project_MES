# Kế hoạch Thực hiện Game Emulation System trên Tinker Board

## Tổng quan Dự án
Xây dựng hệ thống giả lập game retro trên Tinker Board sử dụng Lakka/RetroArch, cho phép chơi các game cổ điển từ nhiều nền tảng khác nhau.

---

## Giai đoạn 1: Chuẩn bị và Cài đặt Cơ bản

### 1.1 Yêu cầu Phần cứng
- **Tinker Board** (hoặc Tinker Board S/2)
- **Thẻ nhớ/eMMC**: Tối thiểu 16GB (khuyến nghị 32GB+)
- **Nguồn điện**: 5V/3A (quan trọng cho ổn định)
- **Controllers**: USB gamepad hoặc Bluetooth controller
- **Kết nối**: HDMI cable, Ethernet/WiFi
- **Thiết bị nhập**: Bàn phím USB (để setup ban đầu)

### 1.2 Cài đặt Lakka
```bash
# Các bước thực hiện:
# 1. Tải Lakka image cho Tinker Board
# 2. Sử dụng Etcher để ghi image lên thẻ nhớ
# 3. Boot lần đầu và cấu hình cơ bản
```

**Checklist:**
- [ ] Tải Lakka image phù hợp với Tinker Board
- [ ] Ghi image bằng Etcher
- [ ] Cấu hình network (WiFi/Ethernet)
- [ ] Update hệ thống qua Online Updater

---

## Giai đoạn 2: Cấu hình Hệ thống

### 2.1 Cấu hình Video
```
Settings > Video:
- Resolution: Phù hợp với TV/Monitor (1080p recommended)
- Threaded Video: ON (cải thiện performance)
- VSync: ON (giảm screen tearing)
- Hard GPU Sync: Tùy theo performance
```

### 2.2 Cấu hình Audio
```
Settings > Audio:
- Audio Driver: alsa/pulse (tùy theo hardware)
- Audio Latency: 64-128ms (balance giữa latency và stability)
- Enable Audio: ON
```

### 2.3 Cấu hình Input
```
Settings > Input:
- Hotkey Enable: Cấu hình nút kết hợp (thường là Select/L3/R3)
- Menu Toggle Controller Combo: Để truy cập menu nhanh
- Map từng controller (Player 1, 2, 3, 4)
```

### 2.4 Kích hoạt Services
```
Settings > Services:
- SSH: Enable (port 22)
- Samba: Enable (để transfer ROMs qua mạng)
```

---

## Giai đoạn 3: Cài đặt Emulator Cores

### 3.1 Các Cores Khuyến nghị

#### Consoles phổ biến:
| Platform | Core Khuyến nghị | Lý do |
|----------|-----------------|-------|
| NES | Nestopia UE / FCEUmm | Tương thích cao |
| SNES | Snes9x | Performance tốt |
| Genesis/Mega Drive | Genesis Plus GX | Chính xác |
| Game Boy / GBC | Gambatte | Accuracy cao |
| Game Boy Advance | mGBA | Hiện đại, nhanh |
| PlayStation 1 | Beetle PSX HW | Hardware accelerated |
| N64 | Mupen64Plus-Next | Tối ưu cho ARM |
| Arcade | FBNeo / MAME 2003+ | Tương thích rộng |

### 3.2 Cài đặt Cores
```
Main Menu > Online Updater > Core Downloader
- Chọn và tải các cores cần thiết
- Cores sẽ được lưu trong /tmp/cores
```

---

## Giai đoạn 4: Quản lý ROMs

### 4.1 Cấu trúc Thư mục
```
/storage/roms/
├── NES/
├── SNES/
├── Genesis/
├── GBA/
├── PSX/
├── N64/
├── Arcade/
└── downloads/
```

### 4.2 Phương pháp Transfer ROMs

#### Phương pháp 1: Qua Samba (Network)
```bash
# Từ Windows:
\\[TINKER_BOARD_IP]\roms

# Từ Linux/Mac:
smb://[TINKER_BOARD_IP]/roms
```

#### Phương pháp 2: Qua SSH
```bash
# Từ máy tính:
scp game.zip root@[TINKER_BOARD_IP]:/storage/roms/

# Hoặc dùng SFTP client (FileZilla, WinSCP)
```

#### Phương pháp 3: USB Drive
```bash
# Cắm USB vào Tinker Board
# ROMs sẽ tự động mount tại /media/
# Copy vào /storage/roms/
```

### 4.3 Scan và Import ROMs
```
Main Menu > Import Content > Scan Directory
- Chọn thư mục chứa ROMs
- Lakka sẽ tự động nhận diện và tạo Collections
```

---

## Giai đoạn 5: Tối ưu Performance

### 5.1 Overclocking (Cẩn thận!)
```bash
# SSH vào Tinker Board
mount -o remount,rw /flash
nano /flash/config.txt

# Thêm (ví dụ - cần test):
arm_freq=1800
gpu_freq=600
over_voltage=6

# Lưu và reboot
reboot
```

### 5.2 Core Options Optimization
```
Quick Menu > Options (trong game):
- Frameskip: Auto nếu lag
- Rewind: Disable (tốn CPU/RAM)
- Run-Ahead: Enable (giảm input lag - tốn CPU)
```

### 5.3 Video Settings Optimization
```
Settings > Video:
- Bilinear Filtering: OFF (tăng FPS, giảm blur)
- Integer Scale: ON (pixel perfect, tốn ít GPU hơn)
```

---

## Giai đoạn 6: Tính năng Nâng cao

### 6.1 Save States & Auto-Save
```
Quick Menu > State Slot: Chọn slot (0-9)
- F2: Save State
- F4: Load State
- Enable Auto-Save on Exit (trong Core Options)
```

### 6.2 Shaders (Hiệu ứng CRT/Pixel)
```
Quick Menu > Shaders:
- Load Shader Preset
- Shaders/CRT/ (nhiều lựa chọn)
- Khuyến nghị: crt-pi hoặc zfast-crt (nhẹ)
```

### 6.3 Netplay (Chơi Online)
```
Settings > Network:
- Enable Netplay: ON
- Netplay Mode: Host hoặc Client
- Cần port forwarding (55435 TCP/UDP)
```

### 6.4 Playlist & Favorites
```
- Nhấn F1 trong game list > Add to Favorites
- Tạo Custom Playlists
```

---

## Giai đoạn 7: Scripting và Automation

### 7.1 Auto-start Game khi Boot
```bash
# SSH vào Tinker Board
mkdir -p /storage/.config/autostart
nano /storage/.config/autostart.sh

# Thêm:
#!/bin/bash
sleep 5
retroarch -L /tmp/cores/[core_name]_libretro.so /storage/roms/[game.rom]

# Chmod
chmod +x /storage/.config/autostart.sh
```

### 7.2 Backup Script
```bash
#!/bin/bash
# backup_saves.sh
DATE=$(date +%Y%m%d)
tar -czf /storage/backups/saves_$DATE.tar.gz /storage/saves/
```

### 7.3 ROM Organizer Script
```bash
#!/bin/bash
# organize_roms.sh
# Script tự động sắp xếp ROMs theo platform
```

---

## Giai đoạn 8: Troubleshooting

### 8.1 Vấn đề thường gặp

#### Audio cracking/popping:
```
Settings > Audio > Audio Latency: Tăng lên 128-256ms
```

#### Performance thấp:
```
- Disable Rewind
- Disable Run-Ahead
- Lower resolution
- Use lighter core variants
```

#### Controller không hoạt động:
```
Settings > Input > RetroPad Binds > User 1 > Set All Controls
```

#### Network không kết nối:
```bash
# SSH (nếu có Ethernet)
connmanctl services
connmanctl connect [service_id]
```

---

## Giai đoạn 9: Legal ROMs & Content

### 9.1 Nguồn ROMs Hợp pháp
- **Freeware/Homebrew**: Các game mã nguồn mở
- **Libretro Content Downloader**:
  ```
  Main Menu > Online Updater > Content Downloader
  ```
- **Dump từ cartridge/disc của bạn**: Sử dụng hardware dumpers

### 9.2 Homebrew Games Khuyến nghị
- NES: Micro Mages, Lan Master
- SNES: Super Boss Gaiden
- Genesis: Tanglewood (mua bản retail)
- GBA: Lots of homebrew games

---

## Giai đoạn 10: Documentation & Testing

### 10.1 Testing Checklist
- [ ] Test từng emulator core với ít nhất 3 games
- [ ] Kiểm tra audio/video sync
- [ ] Test controller mapping (2-4 players)
- [ ] Test save/load states
- [ ] Test network/Netplay
- [ ] Stress test (chơi 2+ giờ liên tục)
- [ ] Test sau reboot (persistence)

### 10.2 Documentation
- Viết README hướng dẫn sử dụng
- Document các settings đã tối ưu
- Ghi lại troubleshooting tips
- Tạo quick reference guide

---

## Tính năng Mở rộng (Optional)

### 1. Custom Theme
```
Settings > User Interface > Menu > Icon Theme
Settings > User Interface > Menu > Menu Color Theme
```

### 2. Kiosk Mode (Arcade Cabinet)
```
Settings > User Interface > Kiosk Mode
- Ẩn settings, chỉ hiện games
```

### 3. Achievement Support (RetroAchievements)
```
Settings > Achievements:
- Enable: ON
- Đăng ký tài khoản RetroAchievements.org
- Nhập username/password
```

### 4. Bluetooth Controller
```
Settings > Bluetooth:
- Enable Bluetooth: ON
- Scan và pair controller
```

### 5. Scrapers (Metadata & Artwork)
```
Main Menu > Online Updater > Content Downloader
- Tải thumbnails, boxart, screenshots
```

---

## Timeline Đề xuất

| Tuần | Công việc |
|------|-----------|
| 1 | Chuẩn bị hardware, cài đặt Lakka, cấu hình cơ bản |
| 2 | Cài đặt cores, import ROMs, test emulation |
| 3 | Tối ưu performance, cấu hình controllers, testing |
| 4 | Tính năng nâng cao, scripting, documentation |

---

## Resources

### Official Documentation
- Lakka: https://lakka.tv/doc/
- RetroArch: https://docs.libretro.com/
- Libretro Cores: https://docs.libretro.com/library/

### Community
- Lakka Forums
- RetroArch Discord
- Reddit: r/RetroArch, r/emulation

### Tools
- Etcher: https://etcher.balena.io/
- PuTTY (SSH Windows): https://putty.org/
- FileZilla (SFTP): https://filezilla-project.org/

---

## Ghi chú Bảo mật
- Đổi password SSH mặc định: `passwd root`
- Disable SSH nếu không sử dụng
- Sử dụng firewall nếu expose ra Internet
- Backup định kỳ saves và configs

---

## Kết luận
Dự án Game Emulation System trên Tinker Board là một project thú vị kết hợp embedded Linux, emulation, và gaming. Với roadmap trên, bạn có thể xây dựng một hệ thống retro gaming hoàn chỉnh và có thể mở rộng.

**Điểm mạnh của Tinker Board:**
- CPU/GPU mạnh hơn Raspberry Pi 3
- HDMI 2.0 (4K support)
- RAM 2GB
- Phù hợp cho PSX, N64, Dreamcast emulation

**Next Steps:**
1. Bắt đầu với Giai đoạn 1 (Setup cơ bản)
2. Test với 1-2 platforms trước
3. Mở rộng dần theo nhu cầu
4. Document lại trải nghiệm của bạn
