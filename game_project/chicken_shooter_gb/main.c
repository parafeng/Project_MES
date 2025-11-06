/*
 * CHICKEN SHOOTER - Simple Game Boy Game
 * Shoot the falling chickens!
 *
 * Controls:
 * - LEFT/RIGHT: Move ship
 * - A Button: Fire bullet
 * - START: Pause
 */

#include <gb/gb.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Sprite definitions (8x8 tiles)
// Player ship sprite (simple triangle)
const unsigned char player_sprite[] = {
    0x18, 0x18,  // Row 1: ..XX....
    0x3C, 0x3C,  // Row 2: .XXXX...
    0x7E, 0x7E,  // Row 3: XXXXXX..
    0xFF, 0xFF,  // Row 4: XXXXXXXX
    0xFF, 0xFF,  // Row 5: XXXXXXXX
    0xDB, 0xDB,  // Row 6: XX.XX.XX
    0x18, 0x18,  // Row 7: ..XX....
    0x00, 0x00   // Row 8: ........
};

// Chicken enemy sprite
const unsigned char chicken_sprite[] = {
    0x66, 0x66,  // Row 1: .XX..XX.
    0xFF, 0xFF,  // Row 2: XXXXXXXX
    0xFF, 0xFF,  // Row 3: XXXXXXXX
    0x7E, 0x7E,  // Row 4: .XXXXXX.
    0x3C, 0x3C,  // Row 5: ..XXXX..
    0x66, 0x66,  // Row 6: .XX..XX.
    0xC3, 0xC3,  // Row 7: XX....XX
    0x00, 0x00   // Row 8: ........
};

// Bullet sprite
const unsigned char bullet_sprite[] = {
    0x00, 0x00,
    0x18, 0x18,  // ..XX....
    0x18, 0x18,  // ..XX....
    0x18, 0x18,  // ..XX....
    0x18, 0x18,  // ..XX....
    0x18, 0x18,  // ..XX....
    0x00, 0x00,
    0x00, 0x00
};

// Game constants
#define MAX_ENEMIES 5
#define MAX_BULLETS 3
#define SCREEN_WIDTH 160
#define SCREEN_HEIGHT 144

// Sprite IDs
#define PLAYER_SPRITE 0
#define BULLET_START_SPRITE 1
#define ENEMY_START_SPRITE 4

// Structures
typedef struct {
    UINT8 x;
    UINT8 y;
    UINT8 active;
} GameObject;

// Global variables
GameObject player;
GameObject bullets[MAX_BULLETS];
GameObject enemies[MAX_ENEMIES];
UINT16 score;
UINT8 game_running;
UINT8 cooldown;
UINT8 spawn_timer;

// Random number seed
UINT16 rand_seed;

// Simple random number generator
UINT8 simple_rand(void) {
    rand_seed = (rand_seed * 1103515245 + 12345) & 0x7FFF;
    return (UINT8)(rand_seed >> 8);
}

// Initialize game
void init_game(void) {
    UINT8 i;

    // Load sprite tiles
    set_sprite_data(0, 1, player_sprite);   // Tile 0: Player
    set_sprite_data(1, 1, bullet_sprite);   // Tile 1: Bullet
    set_sprite_data(2, 1, chicken_sprite);  // Tile 2: Chicken

    // Initialize player
    player.x = 80;   // Center
    player.y = 120;  // Near bottom
    player.active = 1;

    // Setup player sprite
    set_sprite_tile(PLAYER_SPRITE, 0);
    move_sprite(PLAYER_SPRITE, player.x, player.y);

    // Initialize bullets
    for (i = 0; i < MAX_BULLETS; i++) {
        bullets[i].active = 0;
        set_sprite_tile(BULLET_START_SPRITE + i, 1);
        move_sprite(BULLET_START_SPRITE + i, 0, 0);  // Off screen
    }

    // Initialize enemies
    for (i = 0; i < MAX_ENEMIES; i++) {
        enemies[i].active = 0;
        set_sprite_tile(ENEMY_START_SPRITE + i, 2);
        move_sprite(ENEMY_START_SPRITE + i, 0, 0);  // Off screen
    }

    // Init game state
    score = 0;
    game_running = 1;
    cooldown = 0;
    spawn_timer = 0;
    rand_seed = 12345;

    // Show sprites
    SHOW_SPRITES;
    DISPLAY_ON;
}

// Spawn enemy
void spawn_enemy(void) {
    UINT8 i;
    for (i = 0; i < MAX_ENEMIES; i++) {
        if (!enemies[i].active) {
            enemies[i].x = 20 + (simple_rand() % 120);  // Random X position
            enemies[i].y = 16;  // Top of screen
            enemies[i].active = 1;
            move_sprite(ENEMY_START_SPRITE + i, enemies[i].x, enemies[i].y);
            break;
        }
    }
}

// Fire bullet
void fire_bullet(void) {
    UINT8 i;

    if (cooldown > 0) return;

    for (i = 0; i < MAX_BULLETS; i++) {
        if (!bullets[i].active) {
            bullets[i].x = player.x;
            bullets[i].y = player.y - 8;  // Above player
            bullets[i].active = 1;
            move_sprite(BULLET_START_SPRITE + i, bullets[i].x, bullets[i].y);
            cooldown = 15;  // Cooldown frames
            break;
        }
    }
}

// Update player
void update_player(void) {
    UINT8 joy = joypad();

    // Movement
    if (joy & J_LEFT && player.x > 16) {
        player.x -= 2;
    }
    if (joy & J_RIGHT && player.x < 152) {
        player.x += 2;
    }

    // Fire
    if (joy & J_A) {
        fire_bullet();
    }

    // Update sprite position
    move_sprite(PLAYER_SPRITE, player.x, player.y);

    // Update cooldown
    if (cooldown > 0) cooldown--;
}

// Update bullets
void update_bullets(void) {
    UINT8 i;

    for (i = 0; i < MAX_BULLETS; i++) {
        if (bullets[i].active) {
            bullets[i].y -= 3;  // Move up

            // Remove if off screen
            if (bullets[i].y < 16) {
                bullets[i].active = 0;
                move_sprite(BULLET_START_SPRITE + i, 0, 0);  // Hide
            } else {
                move_sprite(BULLET_START_SPRITE + i, bullets[i].x, bullets[i].y);
            }
        }
    }
}

// Update enemies
void update_enemies(void) {
    UINT8 i;

    for (i = 0; i < MAX_ENEMIES; i++) {
        if (enemies[i].active) {
            enemies[i].y += 1;  // Move down

            // Remove if off screen (missed)
            if (enemies[i].y > 144) {
                enemies[i].active = 0;
                move_sprite(ENEMY_START_SPRITE + i, 0, 0);  // Hide
            } else {
                move_sprite(ENEMY_START_SPRITE + i, enemies[i].x, enemies[i].y);
            }
        }
    }
}

// Check collisions
void check_collisions(void) {
    UINT8 i, j;

    // Bullet vs Enemy
    for (i = 0; i < MAX_BULLETS; i++) {
        if (bullets[i].active) {
            for (j = 0; j < MAX_ENEMIES; j++) {
                if (enemies[j].active) {
                    // Simple distance check (within 8 pixels)
                    if ((bullets[i].x > enemies[j].x - 8) &&
                        (bullets[i].x < enemies[j].x + 8) &&
                        (bullets[i].y > enemies[j].y - 8) &&
                        (bullets[i].y < enemies[j].y + 8)) {

                        // Hit!
                        bullets[i].active = 0;
                        enemies[j].active = 0;
                        move_sprite(BULLET_START_SPRITE + i, 0, 0);
                        move_sprite(ENEMY_START_SPRITE + j, 0, 0);
                        score += 10;
                    }
                }
            }
        }
    }

    // Enemy vs Player (Game Over)
    for (j = 0; j < MAX_ENEMIES; j++) {
        if (enemies[j].active) {
            if ((enemies[j].x > player.x - 8) &&
                (enemies[j].x < player.x + 8) &&
                (enemies[j].y > player.y - 8) &&
                (enemies[j].y < player.y + 8)) {

                // Game Over!
                game_running = 0;
            }
        }
    }
}

// Display score on screen
void display_score(void) {
    printf("\n\n  SCORE: %u", score);
}

// Main function
void main(void) {
    // Title screen
    printf("\n\n\n");
    printf("  CHICKEN SHOOTER\n\n");
    printf("  Press START\n\n");
    printf("  Controls:\n");
    printf("  D-PAD: Move\n");
    printf("  A: Fire\n");

    waitpad(J_START);
    waitpadup();

    // Clear screen
    cls();

    // Initialize game
    init_game();

    // Display initial score
    display_score();

    // Main game loop
    while (game_running) {
        // Spawn enemies periodically
        spawn_timer++;
        if (spawn_timer > 60) {  // Every ~60 frames
            spawn_enemy();
            spawn_timer = 0;
        }

        // Update game objects
        update_player();
        update_bullets();
        update_enemies();
        check_collisions();

        // Update score display every 30 frames
        if (spawn_timer % 30 == 0) {
            display_score();
        }

        // Wait for VBlank (60 FPS)
        wait_vbl_done();
    }

    // Game Over screen
    cls();
    printf("\n\n\n");
    printf("   GAME OVER!\n\n");
    printf("  Final Score: %u\n\n", score);
    printf("  Press START\n");
    printf("  to restart\n");

    // Wait for restart
    waitpad(J_START);

    // Reset and restart
    main();
}
