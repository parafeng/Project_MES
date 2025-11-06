# Homebrew Game Development Guide

## Tổng quan
Guide này hướng dẫn cách tạo homebrew games (game tự phát triển) để chạy trên emulators trong Lakka/RetroArch. Đặc biệt hữu ích nếu bạn muốn tạo game riêng (ví dụ: game bắn gà) để test hoặc phát triển.

---

## Platform nào nên chọn?

### Đề xuất cho người mới bắt đầu:

| Platform | Độ khó | Tools | Khuyến nghị |
|----------|--------|-------|-------------|
| **NES** | ⭐⭐ | cc65, NESASM | ✅ Tốt để học |
| **Game Boy** | ⭐⭐ | GBDK, RGBDS | ✅ Đơn giản, nhiều tài liệu |
| **SNES** | ⭐⭐⭐ | WLA-DX, bass | Phức tạp hơn NES |
| **Genesis** | ⭐⭐ | SGDK | ✅ Có C framework tốt |
| **GBA** | ⭐⭐ | devkitARM | ✅ Modern, C/C++ |

**Đề xuất:** Bắt đầu với **NES** hoặc **Game Boy** để học concepts, sau đó chuyển sang **GBA** hoặc **Genesis** cho projects lớn hơn.

---

## Project 1: Game Bắn Gà cho NES

### Tổng quan
Tạo một game bắn gà kiểu "Chicken Invaders" hoặc "Galaga" trên NES.

### Yêu cầu

#### Tools cần thiết:
1. **cc65** - C compiler cho NES
2. **NESASM** - Assembler (optional)
3. **NES Screen Tool** - Sprite/background editor
4. **FCEUX** - Emulator với debugging (để test nhanh)
5. **Text editor** - VS Code, Sublime, etc.

### Setup môi trường (Linux/Lakka)

```bash
# Cài cc65
git clone https://github.com/cc65/cc65.git
cd cc65
make
sudo make install

# Hoặc từ package manager
sudo apt install cc65  # Ubuntu/Debian
```

### Cấu trúc project

```
chicken_shooter/
├── src/
│   ├── main.c              # Main game logic
│   ├── sprites.c           # Sprite management
│   ├── enemies.c           # Enemy logic
│   ├── player.c            # Player ship control
│   └── collision.c         # Collision detection
├── graphics/
│   ├── player.chr          # Player sprites
│   ├── enemies.chr         # Enemy sprites
│   ├── bullets.chr         # Bullets
│   └── background.chr      # Background tiles
├── audio/
│   └── music.ftm           # FamiTracker music
├── Makefile
└── README.md
```

### Code mẫu: NES Chicken Shooter

#### main.c
```c
/*
 * Simple NES Chicken Shooter
 * A vertical scrolling shoot-em-up
 */

#include <nes.h>
#include <string.h>

// NES Hardware defines
#define PPU_CTRL   *((unsigned char*)0x2000)
#define PPU_MASK   *((unsigned char*)0x2001)
#define PPU_STATUS *((unsigned char*)0x2002)
#define PPU_SCROLL *((unsigned char*)0x2005)
#define OAM_ADDR   *((unsigned char*)0x2003)
#define OAM_DATA   *((unsigned char*)0x2004)
#define OAM_DMA    *((unsigned char*)0x4014)

// Game constants
#define MAX_ENEMIES 8
#define MAX_BULLETS 4
#define SCREEN_WIDTH 256
#define SCREEN_HEIGHT 240

// Player struct
typedef struct {
    unsigned char x;
    unsigned char y;
    unsigned char alive;
    unsigned char cooldown;
} Player;

// Enemy struct (Chicken)
typedef struct {
    unsigned char x;
    unsigned char y;
    unsigned char alive;
    signed char vx;  // Velocity X
    signed char vy;  // Velocity Y
} Enemy;

// Bullet struct
typedef struct {
    unsigned char x;
    unsigned char y;
    unsigned char active;
} Bullet;

// Global variables
Player player;
Enemy enemies[MAX_ENEMIES];
Bullet bullets[MAX_BULLETS];
unsigned int score;
unsigned char level;

// Sprite buffer (256 bytes for 64 sprites)
unsigned char sprites[256];

// Initialize game
void init_game(void) {
    unsigned char i;

    // Init player
    player.x = 128 - 8;  // Center
    player.y = 200;      // Bottom
    player.alive = 1;
    player.cooldown = 0;

    // Init enemies
    for (i = 0; i < MAX_ENEMIES; i++) {
        enemies[i].alive = 0;
    }

    // Init bullets
    for (i = 0; i < MAX_BULLETS; i++) {
        bullets[i].active = 0;
    }

    score = 0;
    level = 1;
}

// Spawn enemy (chicken)
void spawn_enemy(void) {
    unsigned char i;
    for (i = 0; i < MAX_ENEMIES; i++) {
        if (!enemies[i].alive) {
            enemies[i].x = (rand() % 224) + 16;
            enemies[i].y = 16;
            enemies[i].vx = (rand() % 3) - 1;  // -1, 0, or 1
            enemies[i].vy = 1;
            enemies[i].alive = 1;
            break;
        }
    }
}

// Fire bullet
void fire_bullet(void) {
    unsigned char i;
    if (player.cooldown > 0) return;

    for (i = 0; i < MAX_BULLETS; i++) {
        if (!bullets[i].active) {
            bullets[i].x = player.x + 4;  // Center of player
            bullets[i].y = player.y - 8;
            bullets[i].active = 1;
            player.cooldown = 10;  // 10 frame cooldown
            break;
        }
    }
}

// Update player
void update_player(void) {
    unsigned char pad = pad_poll(0);

    // Movement
    if (pad & PAD_LEFT && player.x > 8) {
        player.x -= 2;
    }
    if (pad & PAD_RIGHT && player.x < 240) {
        player.x += 2;
    }
    if (pad & PAD_UP && player.y > 16) {
        player.y -= 2;
    }
    if (pad & PAD_DOWN && player.y < 220) {
        player.y += 2;
    }

    // Fire
    if (pad & PAD_A) {
        fire_bullet();
    }

    // Update cooldown
    if (player.cooldown > 0) {
        player.cooldown--;
    }
}

// Update enemies
void update_enemies(void) {
    unsigned char i;

    for (i = 0; i < MAX_ENEMIES; i++) {
        if (enemies[i].alive) {
            // Move enemy
            enemies[i].x += enemies[i].vx;
            enemies[i].y += enemies[i].vy;

            // Bounce off walls
            if (enemies[i].x < 8 || enemies[i].x > 240) {
                enemies[i].vx = -enemies[i].vx;
            }

            // Remove if off screen
            if (enemies[i].y > 240) {
                enemies[i].alive = 0;
            }
        }
    }
}

// Update bullets
void update_bullets(void) {
    unsigned char i;

    for (i = 0; i < MAX_BULLETS; i++) {
        if (bullets[i].active) {
            bullets[i].y -= 4;  // Move up

            // Remove if off screen
            if (bullets[i].y < 8) {
                bullets[i].active = 0;
            }
        }
    }
}

// Check collisions
void check_collisions(void) {
    unsigned char i, j;

    // Bullet vs Enemy
    for (i = 0; i < MAX_BULLETS; i++) {
        if (bullets[i].active) {
            for (j = 0; j < MAX_ENEMIES; j++) {
                if (enemies[j].alive) {
                    // Simple bounding box collision
                    if (abs(bullets[i].x - enemies[j].x) < 8 &&
                        abs(bullets[i].y - enemies[j].y) < 8) {
                        // Hit!
                        bullets[i].active = 0;
                        enemies[j].alive = 0;
                        score += 10;
                    }
                }
            }
        }
    }

    // Player vs Enemy
    for (j = 0; j < MAX_ENEMIES; j++) {
        if (enemies[j].alive) {
            if (abs(player.x - enemies[j].x) < 12 &&
                abs(player.y - enemies[j].y) < 12) {
                // Player hit!
                player.alive = 0;
            }
        }
    }
}

// Render sprites to sprite buffer
void render_sprites(void) {
    unsigned char i;
    unsigned char sprite_index = 0;

    // Clear sprite buffer
    memset(sprites, 0xFF, 256);

    // Render player
    if (player.alive) {
        sprites[sprite_index++] = player.y;     // Y
        sprites[sprite_index++] = 0x00;         // Tile (player ship)
        sprites[sprite_index++] = 0x00;         // Attributes
        sprites[sprite_index++] = player.x;     // X
    }

    // Render bullets
    for (i = 0; i < MAX_BULLETS; i++) {
        if (bullets[i].active) {
            sprites[sprite_index++] = bullets[i].y;
            sprites[sprite_index++] = 0x02;     // Tile (bullet)
            sprites[sprite_index++] = 0x01;     // Palette 1
            sprites[sprite_index++] = bullets[i].x;
        }
    }

    // Render enemies
    for (i = 0; i < MAX_ENEMIES; i++) {
        if (enemies[i].alive) {
            sprites[sprite_index++] = enemies[i].y;
            sprites[sprite_index++] = 0x01;     // Tile (chicken)
            sprites[sprite_index++] = 0x02;     // Palette 2
            sprites[sprite_index++] = enemies[i].x;
        }
    }
}

// Upload sprites to OAM
void upload_sprites(void) {
    OAM_ADDR = 0x00;
    OAM_DMA = ((unsigned int)sprites) >> 8;  // DMA transfer
}

// Main game loop
void game_loop(void) {
    unsigned char frame_count = 0;

    while (player.alive) {
        // Wait for VBlank
        ppu_wait_nmi();

        // Update game logic
        update_player();
        update_enemies();
        update_bullets();
        check_collisions();

        // Spawn enemies periodically
        frame_count++;
        if (frame_count % 60 == 0) {  // Every 60 frames (~1 second)
            spawn_enemy();
        }

        // Render
        render_sprites();
        upload_sprites();
    }
}

// Main function
void main(void) {
    // Enable PPU
    PPU_CTRL = 0x90;   // Enable NMI, sprites from Pattern Table 0
    PPU_MASK = 0x1E;   // Enable sprites and background

    // Init game
    init_game();

    // Main game loop
    game_loop();

    // Game over
    while(1);  // Infinite loop
}
```

### Makefile

```makefile
# NES Chicken Shooter Makefile

CC = cc65
AS = ca65
LD = ld65

CFLAGS = -t nes -O
ASFLAGS = -t nes
LDFLAGS = -t nes

TARGET = chicken_shooter.nes
OBJS = main.o sprites.o

all: $(TARGET)

$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^

%.o: src/%.c
	$(CC) $(CFLAGS) -o $(@:.o=.s) $<
	$(AS) $(ASFLAGS) -o $@ $(@:.o=.s)

clean:
	rm -f *.o *.s $(TARGET)

run: $(TARGET)
	fceux $(TARGET)
```

### Build và Test

```bash
# Build game
make

# Test trên emulator
fceux chicken_shooter.nes

# Copy vào Lakka để test trên Tinker Board
scp chicken_shooter.nes root@[TINKER_IP]:/storage/roms/NES/
```

---

## Project 2: Game Boy Chicken Shooter (Alternative)

### Tại sao Game Boy?
- Dễ hơn NES
- GBDK có C compiler tốt
- Nhiều tutorials

### Setup GBDK

```bash
# Tải GBDK
wget https://github.com/gbdk-2020/gbdk-2020/releases/download/4.1.1/gbdk-linux64.tar.gz
tar xzf gbdk-linux64.tar.gz
export PATH=$PATH:~/gbdk/bin
```

### Code mẫu: Game Boy version

```c
/*
 * Game Boy Chicken Shooter
 */

#include <gb/gb.h>
#include <stdio.h>

// Sprite tiles
const unsigned char player_tile[] = {
    0x3C,0x3C,0x42,0x7E,0x81,0xFF,0x81,0xFF,
    0x81,0xFF,0x42,0x7E,0x24,0x3C,0x18,0x18
};

const unsigned char enemy_tile[] = {
    0x18,0x18,0x24,0x3C,0x42,0x7E,0x99,0xFF,
    0x99,0xFF,0x42,0x7E,0x24,0x3C,0x18,0x18
};

const unsigned char bullet_tile[] = {
    0x00,0x00,0x00,0x00,0x18,0x18,0x18,0x18,
    0x18,0x18,0x18,0x18,0x00,0x00,0x00,0x00
};

// Player position
UINT8 player_x = 80;
UINT8 player_y = 120;

void main(void) {
    // Load tiles
    set_sprite_data(0, 1, player_tile);
    set_sprite_data(1, 1, enemy_tile);
    set_sprite_data(2, 1, bullet_tile);

    // Set player sprite
    set_sprite_tile(0, 0);
    move_sprite(0, player_x, player_y);

    // Enable sprites
    SHOW_SPRITES;
    DISPLAY_ON;

    // Main loop
    while(1) {
        // Input
        if (joypad() & J_LEFT) {
            player_x -= 2;
            move_sprite(0, player_x, player_y);
        }
        if (joypad() & J_RIGHT) {
            player_x += 2;
            move_sprite(0, player_x, player_y);
        }

        // Wait for VBlank
        wait_vbl_done();
    }
}
```

### Build

```bash
lcc -o chicken.gb main.c
```

---

## Tools & Resources

### Graphics Tools
- **YY-CHR**: Sprite editor (NES)
- **NES Screen Tool**: Full tileset/nametable editor
- **Aseprite**: Pixel art editor (paid, worth it)
- **GBTD/GBMB**: Game Boy tile designer

### Music Tools
- **FamiTracker**: NES music (.nsf export)
- **FamiStudio**: Modern alternative
- **BeepBox**: Simple online music maker

### Emulators for Development
- **FCEUX**: NES with debugger
- **Mesen**: NES with advanced debugging
- **BGB**: Game Boy with excellent debugger
- **NO$GBA**: GBA debugger

### Learning Resources
- **NESdev Wiki**: https://wiki.nesdev.com/
- **GBdev**: https://gbdev.io/
- **NESDev Forums**: https://forums.nesdev.com/
- **GBADev**: https://gbadev.net/

---

## Tips cho Homebrew Development

### 1. Start Small
- Đừng làm RPG lớn ngay từ đầu
- Bắt đầu với Pong, Breakout, hoặc shoot-em-up đơn giản

### 2. Use Existing Code
- Học từ open-source homebrew games
- Modify và improve thay vì viết từ đầu

### 3. Test Often
- Build và test thường xuyên
- Dùng emulator với debugger

### 4. Optimize Later
- Làm cho nó chạy trước
- Optimize sau khi đã hoàn thành

### 5. Participate in Game Jams
- **GBJam**: Game Boy themed jam
- **NESdev Compo**: Annual NES competition
- **Ludum Dare**: General game jam

---

## Deploying to Lakka

### 1. Transfer ROM
```bash
scp your_game.nes root@[TINKER_IP]:/storage/roms/NES/
# or
scp your_game.gb root@[TINKER_IP]:/storage/roms/Game\ Boy/
```

### 2. Scan
```
Main Menu > Import Content > Scan Directory
```

### 3. Play!
```
Main Menu > [Platform Collection] > Your Game > Run
```

---

## Example Projects to Learn From

### Open Source Homebrew Games:
1. **Micro Mages** (NES) - Commercial but great example
2. **Blade Buster** (NES) - Open source shoot-em-up
3. **Tobu Tobu Girl** (Game Boy) - Open source platformer
4. **Goodboy Galaxy** (GBA) - Modern GBA game

### GitHub Repos:
```bash
# NES examples
git clone https://github.com/pinobatch/nrom-template

# Game Boy examples
git clone https://github.com/gbdev/gb-starter-kit

# GBA examples
git clone https://github.com/gbadev/template
```

---

## Kết luận

Developing homebrew games cho retro consoles:
- ✅ Rất thú vị và educational
- ✅ Chạy trực tiếp trên Lakka/RetroArch
- ✅ Active community và nhiều resources
- ✅ Có thể deploy lên hardware thật (với flashcart)

**Đề xuất project đầu tiên:**
1. Game Boy Pong (simplest)
2. NES Breakout
3. **NES Chicken Shooter** (như guide trên)
4. Genesis platformer (nếu comfortable với C)

**Next steps:**
- Setup development environment
- Follow tutorials từ NESdev/GBdev
- Join communities
- Start coding!

---

**Happy Homebrew Development! 🎮**
