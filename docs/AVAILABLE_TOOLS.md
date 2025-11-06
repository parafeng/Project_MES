# Công cụ có sẵn trong Lakka/RetroArch

## Tổng quan
Document này liệt kê tất cả các công cụ, cores, và features có sẵn trong Lakka/RetroArch cho Tinker Board, giúp bạn tận dụng tối đa hệ thống mà không cần cài đặt thêm.

---

## 1. RetroArch Built-in Tools

### 1.1 Online Updater
**Truy cập:** Main Menu > Online Updater

Công cụ cập nhật và tải xuống mọi thứ cần thiết:
- ✅ **Update Core Info Files**: Cập nhật thông tin cores
- ✅ **Update Assets**: Cập nhật icons, fonts, themes
- ✅ **Update Controller Profiles**: Cập nhật database controllers
- ✅ **Update Databases**: Cập nhật game databases để scan ROMs
- ✅ **Update GLSL Shaders**: Cập nhật shaders
- ✅ **Update Cheats**: Cập nhật cheat codes
- ✅ **Core Downloader**: Tải xuống emulator cores
- ✅ **Content Downloader**: Tải homebrew games miễn phí

### 1.2 File Browser
**Truy cập:** Main Menu > Load Content

Công cụ duyệt và load ROMs:
- Browse files từ /storage/roms
- Support nhiều format archives (zip, 7z, rar)
- Quick access đến ROMs gần đây

### 1.3 Import Content Scanner
**Truy cập:** Main Menu > Import Content

Tự động scan và tạo playlists:
- **Scan Directory**: Scan thư mục chứa ROMs
- **Scan File**: Scan file riêng lẻ
- **Manual Scan**: Scan thủ công với options tùy chỉnh

### 1.4 Playlist Manager
**Truy cập:** Main Menu > Playlists

Quản lý game collections:
- Tạo/xóa/edit playlists
- Add/remove games từ playlists
- Favorites management
- Sort và filter

---

## 2. Emulator Cores có sẵn

### 2.1 Nintendo Platforms

#### NES (Nintendo Entertainment System)
| Core | Tốc độ | Độ chính xác | Khuyến nghị |
|------|--------|--------------|-------------|
| **FCEUmm** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ✅ Tốt nhất cho Tinker |
| **Nestopia UE** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ✅ Accuracy cao |
| **QuickNES** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | Nhanh nhưng kém accurate |
| **Mesen** | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | Nặng, accuracy tối đa |

**Features:**
- Save states
- Rewind
- Fast forward
- Cheat support
- Zapper (light gun) emulation

#### SNES (Super Nintendo)
| Core | Tốc độ | Độ chính xác | Khuyến nghị |
|------|--------|--------------|-------------|
| **Snes9x** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ✅ Best balance |
| **Snes9x 2010** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | Older, faster |
| **bsnes** | ⭐⭐ | ⭐⭐⭐⭐⭐ | Nặng, perfect accuracy |

**Features:**
- MSU-1 audio support
- SuperFX chip support
- SA-1 chip support
- Save states, rewind

#### Nintendo 64
| Core | Performance | Khuyến nghị |
|------|-------------|-------------|
| **Mupen64Plus-Next** | ⭐⭐⭐⭐ | ✅ Tốt nhất cho ARM |
| **ParaLLEl N64** | ⭐⭐⭐ | Cần GPU mạnh |

**Notes:**
- Không phải tất cả games đều chạy tốt
- Cần tweaking per-game
- Một số games lag

#### Game Boy / Game Boy Color
| Core | Tốc độ | Độ chính xác |
|------|--------|--------------|
| **Gambatte** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **SameBoy** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **TGB Dual** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |

**Features:**
- Link cable emulation (2 players)
- Game Boy Camera/Printer support
- Custom palettes

#### Game Boy Advance
| Core | Tốc độ | Độ chính xác | Khuyến nghị |
|------|--------|--------------|-------------|
| **mGBA** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ✅ Modern, accurate |
| **VBA-M** | ⭐⭐⭐⭐ | ⭐⭐⭐ | Older |
| **VBA Next** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | Fastest |

**Features:**
- RTC (Real-Time Clock) support
- Solar sensor emulation
- Link cable for multiplayer

---

### 2.2 Sega Platforms

#### Genesis / Mega Drive
| Core | Khuyến nghị |
|------|-------------|
| **Genesis Plus GX** | ✅ Tốt nhất - accurate & fast |
| **PicoDrive** | Fast, ít accurate hơn |

**Features:**
- Sega CD support
- 32X support
- Master System compatible

#### Game Gear / Master System
| Core | Khuyến nghị |
|------|-------------|
| **Genesis Plus GX** | ✅ Best |
| **Gearsystem** | Alternative |

#### Saturn
| Core | Performance |
|------|-------------|
| **Beetle Saturn** | ⭐⭐ (Nặng) |
| **Yabause** | ⭐⭐ (Nặng) |

**Note:** Saturn emulation rất nặng, nhiều games sẽ lag

---

### 2.3 Sony PlayStation

#### PlayStation 1
| Core | GPU | Khuyến nghị |
|------|-----|-------------|
| **Beetle PSX HW** | Hardware | ✅ Tốt cho Tinker Board |
| **Beetle PSX** | Software | Backup option |
| **PCSX ReARMed** | Software | Optimized cho ARM |

**Features:**
- Internal resolution upscaling (HW)
- Memory card support
- Multi-disc games
- Analog controller support

**Format support:**
- .cue/.bin
- .iso
- .pbp (PSX2PSP)

---

### 2.4 Arcade

#### MAME (Multiple Arcade Machine Emulator)
| Core | Romset | Performance | Khuyến nghị |
|------|--------|-------------|-------------|
| **MAME 2003-Plus** | 0.78 | ⭐⭐⭐⭐ | ✅ Best balance |
| **MAME 2010** | 0.139 | ⭐⭐⭐ | More games |
| **FBNeo** | Latest | ⭐⭐⭐⭐ | ✅ Good alternative |
| **MAME (Current)** | Latest | ⭐⭐ | Nặng |

**Features:**
- Thousands of arcade games
- Save states (most games)
- Service menu access
- Dipswitch configuration

**Important:** Cần đúng romset version!

---

### 2.5 Other Platforms

#### Atari 2600
- **Stella**: Accurate Atari 2600 emulator

#### NES/Famicom Disk System
- **FCEUmm**: Support FDS bios

#### PC Engine / TurboGrafx-16
- **Beetle PCE Fast**: Fast & accurate

#### WonderSwan / WonderSwan Color
- **Beetle Cygne**: Good emulation

#### Neo Geo
- **FBNeo**: Excellent Neo Geo support

#### Doom
- **PrBoom**: Doom engine (support WADs)

---

## 3. Video Features & Tools

### 3.1 Shaders
**Truy cập:** Quick Menu > Shaders

Hiệu ứng đồ họa post-processing:

#### CRT Shaders (Giả lập màn hình CRT cổ)
- **crt-pi**: Lightweight CRT effect
- **zfast-crt**: Very fast CRT
- **crt-royale**: High-quality (nặng)
- **crt-easymode**: Balanced

#### Pixel Perfect Shaders
- **sharp-bilinear-simple**: Sharp pixels
- **nearest**: No filtering

#### Upscaling Shaders
- **xbr**: Pixel art upscaling
- **scalefx**: Smooth upscaling
- **hqx**: High-quality upscaling

### 3.2 Video Filters
- Bilinear filtering
- Integer scaling
- Aspect ratio correction
- Overscan cropping

---

## 4. Audio Tools

### 4.1 Audio Drivers có sẵn
- **alsa**: Standard Linux audio
- **alsathread**: Threaded ALSA (better latency)
- **pulse**: PulseAudio
- **rsound**: Network audio streaming

### 4.2 Audio Features
- Volume control
- Audio sync
- Dynamic rate control
- Latency adjustment
- DSP filters

---

## 5. Input Tools

### 5.1 Controller Support
**Auto-detect:**
- Xbox 360/One controllers
- PlayStation 3/4 controllers
- Generic USB gamepads
- Bluetooth controllers
- Keyboards

### 5.2 Input Configuration
**Settings > Input:**
- RetroPad configuration (universal)
- Per-controller mapping
- Hotkey configuration
- Analog deadzone settings
- Turbo button support

### 5.3 Special Input Devices
- **Mouse emulation**: Cho SNES mouse games
- **Light gun**: Zapper, Justifier emulation
- **Paddle**: Atari paddle emulation

---

## 6. Network Features

### 6.1 File Transfer
- **Samba**: Windows file sharing
- **SSH**: Secure Shell access
- **SFTP**: File transfer over SSH

### 6.2 Netplay (Online Multiplayer)
**Features:**
- Host or join games
- Spectator mode
- Client/server architecture
- NAT traversal (MITM mode)

**Requirements:**
- Same core version
- Same ROM (matching checksums)
- Port forwarding (hosting)

### 6.3 RetroAchievements
**Truy cập:** Settings > Achievements

Achievement system cho retro games:
- Track achievements trong games
- Leaderboards
- Rich presence (show game status)

Website: https://retroachievements.org

---

## 7. Cheat Support

### 7.1 Cheat Databases
**Update via:** Online Updater > Update Cheats

Formats hỗ trợ:
- **Game Genie**: NES, Genesis
- **Pro Action Replay**: Genesis, SNES
- **GameShark**: PSX, N64

### 7.2 Cheat Manager
**Quick Menu > Cheats:**
- Load cheat file
- Enable/disable cheats
- Create custom cheats
- Save cheat configurations

---

## 8. Save Management

### 8.1 Save Types
- **SRAM**: Battery saves (thường .srm)
- **Save States**: Snapshot (.state)
- **Auto-save**: Tự động lưu khi thoát

### 8.2 Save Tools
- State slot management (0-9)
- Screenshot on save
- Auto-load on start
- Cloud sync (với scripts)

---

## 9. Metadata & Scraping

### 9.1 Game Information
**Online Updater > Update Databases**

Databases cho:
- Game names
- Release dates
- Developers/Publishers
- Genre information

### 9.2 Thumbnails
**Online Updater > Thumbnail Updater**

Image types:
- **Boxart**: Game covers
- **Screenshots**: In-game images
- **Title screens**: Game titles

---

## 10. Advanced Tools

### 10.1 Run-Ahead
**Quick Menu > Latency:**
Giảm input lag bằng cách "chạy trước" emulation

**Settings:**
- Enable Run-Ahead
- Number of frames (1-2)
- Use Second Instance

**Cost:** Tốn CPU (2x cho second instance)

### 10.2 Rewind
**Quick Menu > Rewind:**
Tua lại gameplay

**Settings:**
- Rewind enable
- Rewind granularity
- Rewind buffer size

**Cost:** Tốn RAM

### 10.3 Frame Delay
**Settings > Latency:**
Giảm latency bởi delay frame rendering

**Range:** 0-15ms
**Cost:** Giảm performance headroom

---

## 11. System Services (Lakka)

### 11.1 SSH Server
**Settings > Services > SSH**

Access:
```bash
ssh root@[IP_ADDRESS]
Password: root (default)
```

**Usage:**
- File management
- Script execution
- System monitoring
- Debugging

### 11.2 Samba Server
**Settings > Services > Samba**

Access:
```
\\[IP_ADDRESS]\roms
\\[IP_ADDRESS]\savefiles
\\[IP_ADDRESS]\savestates
```

**Usage:**
- Transfer ROMs
- Backup saves
- Access configs

### 11.3 Bluetooth
**Settings > Bluetooth**

Support:
- Bluetooth controllers
- Bluetooth audio (experimental)

---

## 12. Content Downloader (Free Games)

### 12.1 Available Content
**Main Menu > Online Updater > Content Downloader**

Free homebrew games:
- **Mr. Boom**: Bomberman-like
- **Dinothawr**: Puzzle game
- **2048**: Puzzle game
- **Cave Story**: Platform adventure (needs data files)
- **Doom/Doom II**: Needs WAD files

Collections:
- Atari 2600 Homebrew
- NES Homebrew
- SNES Homebrew
- Genesis Homebrew

---

## 13. Configuration Tools

### 13.1 Configuration Files
Locations:
```
/storage/.config/retroarch/retroarch.cfg  # Main config
/storage/.config/retroarch/config/        # Per-core configs
```

### 13.2 Override System
Hierarchy:
1. Global config (retroarch.cfg)
2. Per-Core config ([core].cfg)
3. Per-Game config ([game].cfg)
4. Runtime overrides

---

## 14. Diagnostic Tools

### 14.1 Built-in Info
**Main Menu > Information:**
- System Information
- Network Information
- Core Information
- Database Manager

### 14.2 On-Screen Display
**Settings > On-Screen Display:**
- FPS counter
- Frame time graph
- Statistics (CPU, GPU usage)
- Notifications

### 14.3 Logging
**Settings > Logging:**
- Verbose logging
- Log to file
- Log verbosity level

---

## 15. Theme & UI Customization

### 15.1 Menu Drivers
**Settings > User Interface > Menu:**
- **XMB**: PlayStation-like (default)
- **Ozone**: Modern, clean
- **RGUI**: Retro, lightweight

### 15.2 Icon Themes
**Settings > User Interface > Appearance:**
- Monochrome
- Retrosystem
- Systematic
- Custom

### 15.3 Color Themes
Premade color schemes cho XMB/Ozone

---

## 16. Kiosk Mode

**Settings > User Interface > Kiosk Mode**

Features:
- Ẩn settings menu
- Chỉ show games
- Password protection
- Perfect cho arcade cabinets

---

## Tóm tắt: Công cụ Khuyến nghị

### Essential Tools (Luôn dùng)
1. ✅ **Online Updater** - Update mọi thứ
2. ✅ **Core Downloader** - Cài emulators
3. ✅ **Import Content** - Scan ROMs
4. ✅ **Samba** - Transfer files
5. ✅ **SSH** - Remote access

### Performance Tools
1. ✅ **Run-Ahead** - Giảm lag (nếu CPU đủ mạnh)
2. ✅ **Frame Delay** - Giảm latency nhẹ
3. ❌ **Rewind** - Disable để tăng performance

### Quality of Life
1. ✅ **RetroAchievements** - Achievements
2. ✅ **Shaders** - CRT effects
3. ✅ **Save States** - Quick save/load
4. ✅ **Playlists** - Organize games

---

## Kết luận

Lakka/RetroArch cung cấp đầy đủ tools cần thiết để:
- ✅ Emulate hầu hết retro consoles
- ✅ Manage ROMs và saves
- ✅ Customize experience
- ✅ Online multiplayer
- ✅ Advanced features (shaders, achievements, etc.)

**Không cần cài thêm tools bên ngoài** cho hầu hết use cases. Chỉ cần biết sử dụng những gì đã có!

---

**Next Steps:**
- Đọc [IMPLEMENTATION_PLAN.md](/IMPLEMENTATION_PLAN.md) để setup
- Check [TROUBLESHOOTING.md](/docs/TROUBLESHOOTING.md) nếu có vấn đề
- Explore cores và features trong RetroArch UI
