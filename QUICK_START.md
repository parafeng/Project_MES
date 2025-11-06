# Quick Start Guide - Tinker Board Game Emulation

## 🚀 Bắt đầu Nhanh (30 phút)

### Bước 1: Chuẩn bị (5 phút)
**Cần có:**
- ✅ Tinker Board + nguồn 5V/3A
- ✅ Thẻ nhớ 16GB+
- ✅ HDMI cable + TV/Monitor
- ✅ USB Keyboard
- ✅ USB Controller (optional nhưng khuyến nghị)
- ✅ Kết nối Internet (Ethernet hoặc WiFi)

### Bước 2: Cài đặt Lakka (10 phút)
```bash
1. Tải Lakka image cho Tinker Board từ: https://lakka.tv/get/
   - Chọn "Tinker Board" từ danh sách
   - Download file .img.gz

2. Ghi image lên thẻ nhớ:
   - Tải Etcher: https://etcher.balena.io/
   - Chọn Lakka image
   - Chọn thẻ nhớ
   - Flash!

3. Cắm thẻ nhớ vào Tinker Board và boot
```

### Bước 3: Cấu hình Cơ bản (10 phút)

#### 3.1 Kết nối Network
```
Main Menu > Settings > WiFi
- Enable WiFi: ON
- SSID: [Tên WiFi của bạn]
- Password: [Mật khẩu]
- Connect
```

#### 3.2 Update Hệ thống
```
Main Menu > Online Updater
- Update Core Info Files
- Update Assets
- Update Controller Profiles
```

#### 3.3 Bật SSH và Samba
```
Settings > Services
- SSH: Enable
- Samba: Enable

Settings > Network
- Ghi lại IP Address (ví dụ: 192.168.1.100)
```

### Bước 4: Cài Emulator Cores (5 phút)
```
Main Menu > Online Updater > Core Downloader

Cài các cores sau để test:
- NES: "Nintendo - NES / Famicom (FCEUmm)"
- SNES: "Nintendo - SNES / SFC (Snes9x)"
- Genesis: "Sega - MS/MD/CD/32X (Genesis Plus GX)"
- Game Boy Advance: "Nintendo - Game Boy Advance (mGBA)"
```

### Bước 5: Thêm ROMs (5+ phút)

#### Từ Windows:
```
1. Mở File Explorer
2. Gõ vào address bar: \\[IP_ADDRESS]\roms
   Ví dụ: \\192.168.1.100\roms
3. Copy ROMs vào thư mục tương ứng (NES/, SNES/, etc.)
```

#### Từ Mac/Linux:
```
1. Finder/File Manager > Go > Connect to Server
2. Gõ: smb://[IP_ADDRESS]/roms
   Ví dụ: smb://192.168.1.100/roms
3. Copy ROMs vào thư mục tương ứng
```

#### Scan ROMs:
```
Main Menu > Import Content > Scan Directory
- Chọn /storage/roms/
- Wait for scan to complete
- ROMs sẽ xuất hiện trong Collections
```

### Bước 6: Chơi Game! 🎮
```
1. Main Menu > [Platform Collection] (ví dụ: Nintendo - NES)
2. Chọn game
3. Press Enter/A để chạy
4. Enjoy!
```

---

## ⌨️ Phím tắt quan trọng

### Trong Game:
| Phím | Chức năng |
|------|-----------|
| F1 | RetroArch Menu |
| F2 | Save State |
| F4 | Load State |
| F7 | Increase State Slot |
| F6 | Decrease State Slot |
| Esc hoặc F1 | Exit game |
| F9 | Screenshot |
| Space | Fast Forward |

### Nếu dùng Controller:
```
Hotkey + Start = Exit game
Hotkey + Right Shoulder = Save State
Hotkey + Left Shoulder = Load State
Hotkey + Right = Next State Slot
Hotkey + Left = Previous State Slot

(Hotkey thường là Select hoặc L3/R3, tùy cấu hình)
```

---

## 🔧 Troubleshooting Nhanh

### Game chạy chậm/lag:
```
Quick Menu (F1) > Options
- Frameskip: Auto
- Rewind: Disable

Settings > Video
- Threaded Video: ON
- Hard GPU Sync: OFF
```

### Không có âm thanh:
```
Settings > Audio
- Enable Audio: ON
- Audio Driver: Thử alsa/alsathread/pulse
- Audio Latency: 128
```

### Controller không hoạt động:
```
Settings > Input > Port 1 Controls
- Device Type: RetroPad
- Set All Controls (Nhấn Enter và map từng nút)
```

### Không kết nối được Samba:
```
1. Check IP address: Settings > Network > Network Information
2. Ensure Samba is enabled: Settings > Services > Samba: ON
3. Try thêm credentials nếu cần: root / root
4. Windows: có thể cần enable SMB 1.0 trong Windows Features
```

---

## 📦 ROMs Miễn phí & Hợp pháp

### Homebrew Games (Free & Legal):
```
Main Menu > Online Updater > Content Downloader

Platforms có sẵn:
- Atari - 2600
- NES Homebrew Games
- SNES Homebrew Games
- The Company - Doom
- Mr. Boom (Bomberman clone)
```

### Websites cho Homebrew:
- https://pdroms.de/
- https://www.romhacking.net/homebrew/
- https://itch.io/ (search "homebrew nes/snes")

---

## 🎯 Test Games Đề xuất

### Để test mỗi platform:
| Platform | Test Game | Lý do |
|----------|-----------|-------|
| NES | Super Mario Bros | Classic, test controls |
| SNES | Super Mario World | Test video/audio sync |
| Genesis | Sonic the Hedgehog | Test fast scrolling |
| GBA | Pokemon FireRed | Test saves |
| PSX | Crash Bandicoot | Test 3D performance |

*(Lưu ý: Chỉ dùng ROMs từ game bạn sở hữu hoặc homebrew)*

---

## 📊 Performance Guide

### Tinker Board có thể chạy tốt:
✅ NES, SNES, Genesis - Hoàn hảo (60fps)
✅ Game Boy / GBC / GBA - Hoàn hảo
✅ PlayStation 1 - Rất tốt (hầu hết games)
✅ N64 - Tốt (nhiều games, một số cần tweak)
✅ Arcade (MAME 2003+, FBNeo) - Tốt với hầu hết games
⚠️ Dreamcast - Một số games, cần tối ưu
⚠️ PSP - Chậm, chỉ một số games 2D
❌ PS2, GameCube, Wii - Không đủ mạnh

---

## 🔐 Bảo mật Cơ bản

### SSH vào Tinker Board:
```bash
# Windows: Dùng PuTTY
Host: [IP_ADDRESS]
Port: 22
Username: root
Password: root

# Mac/Linux:
ssh root@[IP_ADDRESS]
Password: root
```

### Đổi password root (Khuyến nghị!):
```bash
passwd root
# Nhập password mới 2 lần
```

---

## 📚 Next Steps

Sau khi hoàn thành Quick Start, bạn có thể:

1. **Tối ưu Performance**: Xem IMPLEMENTATION_PLAN.md > Giai đoạn 5
2. **Setup Shaders (CRT effects)**: Xem IMPLEMENTATION_PLAN.md > Giai đoạn 6.2
3. **Netplay (Online multiplayer)**: Xem IMPLEMENTATION_PLAN.md > Giai đoạn 6.3
4. **Scripting & Automation**: Xem scripts/ directory

---

## 🆘 Cần trợ giúp?

- **Documentation đầy đủ**: Xem IMPLEMENTATION_PLAN.md
- **Scripts hữu ích**: Xem thư mục scripts/
- **Lakka Docs**: https://lakka.tv/doc/
- **RetroArch Docs**: https://docs.libretro.com/

---

**Chúc bạn vui vẻ với retro gaming! 🎮**
