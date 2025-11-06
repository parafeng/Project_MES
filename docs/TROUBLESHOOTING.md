# Troubleshooting Guide - Lakka on Tinker Board

## Tổng quan
Document này giải quyết các vấn đề thường gặp khi chạy Lakka/RetroArch trên Tinker Board.

---

## Vấn đề 1: Game chạy chậm / Lag / FPS thấp

### Triệu chứng:
- Game stuttering
- FPS dưới 60
- Audio crackling do dropped frames

### Nguyên nhân & Giải pháp:

#### A. Core quá nặng
**Giải pháp:**
```
Quick Menu > Information > Core Information
# Check core name

# Nếu dùng accuracy cores, switch sang speed cores:
- bsnes → Snes9x
- Mesen → FCEUmm
- Beetle PSX → PCSX ReARMed
- MAME Current → MAME 2003-Plus
```

#### B. Rewind enabled (tốn CPU/RAM)
**Giải pháp:**
```
Settings > Frame Throttle > Rewind: OFF
```

#### C. Run-Ahead enabled (tốn CPU)
**Giải pháp:**
```
Settings > Latency > Run-Ahead: OFF
# Hoặc giảm frames: 2 → 1
# Disable "Second Instance"
```

#### D. Shaders quá nặng
**Giải pháp:**
```
Quick Menu > Shaders

# Disable shaders:
Shaders > Load > Remove

# Hoặc dùng lightweight shaders:
- crt-pi
- zfast-crt
- sharp-bilinear-simple

# Avoid heavy shaders:
- crt-royale
- crt-lottes
- xbr-lv3
```

#### E. Threaded Video disabled
**Giải pháp:**
```
Settings > Video > Threaded Video: ON
```

#### F. Overheating (Thermal throttling)
**Check nhiệt độ:**
```bash
# SSH vào Tinker Board
cat /sys/class/thermal/thermal_zone0/temp
# Chia cho 1000 = độ C

# Nếu > 80°C:
# - Add heatsink
# - Add fan
# - Improve airflow
```

**Tạm thời giảm overclock:**
```bash
mount -o remount,rw /flash
nano /flash/config.txt

# Giảm arm_freq và gpu_freq
# Reboot
```

#### G. Wrong CPU Governor
**Giải pháp:**
```bash
# SSH
echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo performance > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo performance > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo performance > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
```

---

## Vấn đề 2: Không có âm thanh

### Triệu chứng:
- Game chạy nhưng silent
- No audio output

### Giải pháp:

#### A. Audio disabled
```
Settings > Audio > Enable Audio: ON
```

#### B. Wrong audio driver
```
Settings > Audio > Audio Driver

# Thử các drivers:
- alsathread (khuyến nghị)
- alsa
- pulse
```

#### C. Audio Latency quá thấp
```
Settings > Audio > Audio Latency: 128
# Tăng dần đến khi có audio: 64 → 128 → 256
```

#### D. HDMI audio not working
```bash
# SSH
amixer set Master 100%
amixer set PCM 100%

# Check HDMI output
aplay -l
# Ensure HDMI device is available
```

#### E. Audio sync issues
```
Settings > Audio > Audio Sync: ON
Settings > Audio > Max Timing Skew: 0.05
```

---

## Vấn đề 3: Controller không hoạt động

### Triệu chứng:
- Controller connected nhưng không respond
- Buttons không map đúng

### Giải pháp:

#### A. Auto-config chưa cập nhật
```
Main Menu > Online Updater > Update Controller Profiles
# Reboot
```

#### B. Manual configuration
```
Settings > Input > Port 1 Controls
- Device Type: RetroPad
- Set All Controls
# Press each button as prompted
```

#### C. Bluetooth controller pairing issues
```
Settings > Bluetooth
- Enable Bluetooth: ON
- Scan for devices
- Pair

# If fails:
# - Reboot Tinker Board
# - Reset controller (hold pair button 10s)
# - Try again
```

#### D. USB controller not detected
```bash
# SSH
lsusb
# Check if controller listed

# If not:
# - Try different USB port
# - Try powered USB hub
# - Check cable
```

#### E. Wrong controller driver
```
Settings > Input > Joypad Driver

# Try:
- udev (default)
- linuxraw
- sdl2
```

---

## Vấn đề 4: Network không kết nối

### Triệu chứng:
- WiFi/Ethernet không kết nối
- Không lấy được IP

### Giải pháp:

#### A. WiFi configuration
```
Settings > WiFi
- Enable WiFi: ON
- SSID: [Your network]
- Password: [Your password]
- Connect
```

#### B. SSH vào qua Ethernet để debug WiFi
```bash
# Kết nối Ethernet
ssh root@[IP_FROM_ROUTER]

# Check WiFi interface
ifconfig wlan0

# Manual WiFi config
connmanctl
> enable wifi
> scan wifi
> services
> connect [wifi_service_id]
```

#### C. Ethernet not working
```bash
# Check cable
# Check link status
cat /sys/class/net/eth0/carrier
# Should return 1

# Check IP
ifconfig eth0

# If no IP:
dhclient eth0
```

#### D. DNS issues
```bash
# Test DNS
ping 8.8.8.8  # IP works?
ping google.com  # DNS works?

# If IP works but DNS doesn't:
echo "nameserver 8.8.8.8" > /etc/resolv.conf
```

---

## Vấn đề 5: Samba không truy cập được

### Triệu chứng:
- Không mở được \\[IP]\roms
- Access denied

### Giải pháp:

#### A. Samba chưa enable
```
Settings > Services > Samba: ON
```

#### B. Firewall blocking (trên máy tính)
**Windows:**
```
Control Panel > Windows Defender Firewall
> Allow an app
> File and Printer Sharing: Enable
```

#### C. SMB 1.0 disabled (Windows 10/11)
```
Control Panel > Programs > Turn Windows features on or off
> SMB 1.0/CIFS File Sharing Support: Enable
> Reboot Windows
```

#### D. Wrong path
```
# Correct paths:
\\[IP]\roms
\\[IP]\savefiles
\\[IP]\savestates

# NOT:
\\[IP]\storage\roms  (wrong)
```

#### E. Credentials needed
```
Username: root
Password: root

# Hoặc try blank
```

---

## Vấn đề 6: SSH không kết nối được

### Triệu chứng:
- Connection refused
- Timeout

### Giải pháp:

#### A. SSH chưa enable
```
Settings > Services > SSH: Enable
```

#### B. Wrong IP address
```
Settings > Network > Network Information
# Ghi lại đúng IP
```

#### C. Firewall blocking
```
# Tắt firewall tạm thời để test
# Hoặc allow port 22
```

#### D. SSH client issues (Windows)
```
# Install OpenSSH client
Settings > Apps > Optional Features > OpenSSH Client

# Hoặc dùng PuTTY
```

---

## Vấn đề 7: ROMs không được scan/import

### Triệu chứng:
- Scan hoàn thành nhưng no games found
- ROMs không xuất hiện trong Collections

### Giải pháp:

#### A. Database chưa update
```
Main Menu > Online Updater > Update Databases
# Try scan again
```

#### B. Wrong ROM format
```
# Check supported formats for each core
# Example SNES:
- .sfc ✅
- .smc ✅
- .zip ✅
- .7z ❌ (một số cores không support)

# Extract from archives nếu cần
```

#### C. Bad ROM dump
```
# ROMs cần match database checksums
# Try different ROM dump
# Hoặc dùng No-Intro/Redump verified dumps
```

#### D. Manual Scan
```
Main Menu > Import Content > Manual Scan
- Content Directory: /storage/roms/[PLATFORM]
- System Name: [Select platform]
- Default Core: [Select core]
- Start Scan
```

#### E. Custom Playlist
```
# Nếu scan không work, tạo manual playlist
# Edit .lpl file trong /storage/playlists/
```

---

## Vấn đề 8: Save States không hoạt động

### Triệu chứng:
- F2 không save
- F4 không load
- "Failed to save state" message

### Giải pháp:

#### A. Storage full
```bash
# SSH
df -h /storage
# Nếu full, delete old backups/ROMs
```

#### B. Write permission issues
```bash
# SSH
chmod -R 777 /storage/savestates
```

#### C. Core không support save states
```
# Một số cores không support:
- MAME (current)
- Beetle Saturn (unstable)

# Dùng in-game saves thay thế
```

#### D. State slot conflict
```
Quick Menu > State Slot: 0
# Try different slots: 1, 2, 3...
```

---

## Vấn đề 9: Video artifacts / Screen tearing

### Triệu chứng:
- Screen tearing
- Flickering
- Wrong colors

### Giải pháp:

#### A. VSync
```
Settings > Video > VSync: ON
```

#### B. Hard GPU Sync
```
Settings > Video > Hard GPU Sync: ON
# Nếu gây lag:
Hard GPU Sync: OFF
```

#### C. Wrong video driver
```
Settings > Video > Video Driver

# Try:
- gl (default)
- vulkan (if supported)
```

#### D. HDMI cable issues
```
# Try different HDMI cable
# Try different HDMI port on TV
```

#### E. Resolution mismatch
```
Settings > Video > Video
- Fullscreen Mode: Auto
- Windowed Width/Height: Match TV resolution
```

---

## Vấn đề 10: Lakka không boot

### Triệu chứng:
- Black screen
- Rainbow screen (Tinker Board)
- Kernel panic

### Giải pháp:

#### A. Bad image write
```
# Re-write Lakka image với Etcher
# Verify checksum của downloaded image
```

#### B. Corrupted SD card
```
# Test SD card với H2testw (Windows) hoặc F3 (Linux)
# Replace nếu corrupted
```

#### C. Incompatible SD card
```
# Dùng high-quality SD card:
- SanDisk Ultra/Extreme
- Samsung EVO
- Class 10 hoặc UHS-I
```

#### D. Power supply insufficient
```
# Ensure 5V/3A power supply
# Weak power = boot issues
```

#### E. Wrong image for board
```
# Ensure download đúng image:
- Tinker Board (original)
- Tinker Board S
- Tinker Board 2
# Mỗi board khác image!
```

---

## Vấn đề 11: Netplay không hoạt động

### Triệu chứng:
- Cannot connect to host
- Desync during gameplay

### Giải pháp:

#### A. Port forwarding (Host)
```
Router settings:
- Forward port 55435 TCP/UDP
- To Tinker Board IP
```

#### B. Same core version
```
# Host và client phải dùng:
- Cùng core (ví dụ: Snes9x)
- Cùng version (update qua Online Updater)
```

#### C. Same ROM
```
# ROM phải identical (same checksum)
# Dùng No-Intro hoặc Redump verified
```

#### D. Network latency
```
Settings > Network > Netplay
- Netplay Delay Frames: 2-6 (tùy ping)
```

#### E. NAT Traversal (MITM)
```
Settings > Network > Netplay
- Use Relay Server: ON
# Không cần port forwarding
```

---

## Vấn đề 12: RetroAchievements không hoạt động

### Triệu chứng:
- No achievements unlocking
- Cannot login

### Giải pháp:

#### A. Not logged in
```
Settings > Achievements
- Enable: ON
- Username: [Your username]
- Password: [Your password]
```

#### B. Internet connection
```
# Ensure Lakka có internet
ping retroachievements.org
```

#### C. Core không support
```
# Một số cores không support achievements
# Dùng recommended cores từ RA docs
```

#### D. Hardcore mode
```
Settings > Achievements
- Hardcore Mode: ON (để unlock most achievements)
# Note: Disables save states & cheats
```

---

## Vấn đề 13: High input lag

### Triệu chứng:
- Delay giữa button press và action
- Game feels sluggish

### Giải pháp:

#### A. Run-Ahead
```
Settings > Latency
- Run-Ahead to Reduce Latency: ON
- Number of Frames: 1 hoặc 2
```

#### B. Frame Delay
```
Settings > Latency
- Frame Delay: 2-8
# Tăng dần đến khi comfortable
```

#### C. Disable VSync (trade-off with tearing)
```
Settings > Video > VSync: OFF
# Hoặc:
Hard GPU Sync: ON
Hard GPU Sync Frames: 0
```

#### D. Polling behavior
```
Settings > Input
- Polling Behavior: Late (giảm lag)
```

#### E. TV Game Mode
```
# Bật Game Mode trên TV để giảm processing lag
# Usually in TV Picture settings
```

---

## Vấn đề 14: Overheating warnings

### Triệu chứng:
- Red thermometer icon
- System throttling
- Crashes during intensive games

### Giải pháp:

#### A. Add heatsink
```
# Passive cooling:
- Aluminum heatsink on RK3288 SoC
- Thermal pad/paste
```

#### B. Add fan
```
# Active cooling:
- 5V fan on GPIO pins
- Or USB fan pointing at board
```

#### C. Reduce overclock
```bash
# SSH
mount -o remount,rw /flash
nano /flash/config.txt

# Giảm frequencies:
arm_freq=1600  # Was 1800
gpu_freq=500   # Was 600

# Reboot
```

#### D. Better ventilation
```
# Ensure:
- Board không enclosed
- Good airflow
- Không đặt trong case chật
```

---

## Tools for Debugging

### Built-in Tools

#### 1. System Information
```
Main Menu > Information > System Information
- Check CPU, RAM, OpenGL version
```

#### 2. Core Information
```
Quick Menu > Information > Core Information
- Check core version, author, support
```

#### 3. FPS Counter
```
Settings > On-Screen Display > On-Screen Notifications
- FPS Show: ON
- Frame Time Show: ON
```

#### 4. Verbose Logging
```
Settings > Logging
- Logging Verbosity: ON
- Log to File: ON

# Check logs:
# SSH
cat /tmp/retroarch.log
```

### External Tools (SSH)

#### Monitor CPU
```bash
top
htop  # If available
```

#### Monitor Temperature
```bash
watch -n 1 "cat /sys/class/thermal/thermal_zone0/temp | awk '{print \$1/1000}'"
```

#### Monitor Network
```bash
ifconfig
ping google.com
```

#### Check Processes
```bash
ps aux | grep retroarch
```

---

## Getting Help

### If vẫn không giải quyết được:

1. **Check Lakka Forums**
   - https://forums.lakka.tv/

2. **RetroArch Documentation**
   - https://docs.libretro.com/

3. **Discord Communities**
   - Lakka Discord
   - RetroArch Discord

4. **Reddit**
   - r/RetroArch
   - r/emulation

5. **GitHub Issues**
   - https://github.com/libretro/Lakka-LibreELEC/issues

### Information to provide khi ask for help:
- Tinker Board model
- Lakka version
- Core và version
- ROM format
- Steps to reproduce
- Logs (/tmp/retroarch.log)

---

## Preventive Maintenance

### Best Practices:

1. **Regular Updates**
   ```
   Online Updater > Update Core Info Files
   Online Updater > Update Assets
   ```

2. **Regular Backups**
   ```bash
   # Run backup script weekly
   /storage/scripts/backup_saves.sh
   ```

3. **Clean Storage**
   ```bash
   # Delete unused ROMs/cores
   # Keep storage < 80% full
   ```

4. **Monitor Temperature**
   ```bash
   # Check regularly
   /storage/scripts/system_info.sh
   ```

5. **Use Quality Hardware**
   - Good SD card
   - Proper power supply
   - Heatsink/fan if needed

---

**Tip:** Bookmark page này để quick reference khi gặp issues!
