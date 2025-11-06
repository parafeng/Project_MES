# Makefile for Chicken Shooter Game Boy Game

# Compiler
CC = lcc

# Compiler flags
CFLAGS = -Wa-l -Wl-m -Wl-j

# Target ROM name
TARGET = chicken_shooter.gb

# Source files
SOURCES = main.c

# Object files
OBJECTS = $(SOURCES:.c=.o)

# Default target
all: $(TARGET)

# Build ROM
$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $(OBJECTS)
	@echo ""
	@echo "✓ Build complete!"
	@echo "✓ ROM created: $(TARGET)"
	@echo ""
	@echo "To test on emulator:"
	@echo "  make test"
	@echo ""
	@echo "To deploy to Tinker Board:"
	@echo "  make deploy IP=192.168.1.XXX"
	@echo ""

# Compile source files
%.o: %.c
	$(CC) -c -o $@ $<

# Test on emulator (if available)
test: $(TARGET)
	@if command -v bgb > /dev/null 2>&1; then \
		echo "Running on BGB emulator..."; \
		bgb $(TARGET); \
	elif command -v sameboy > /dev/null 2>&1; then \
		echo "Running on SameBoy emulator..."; \
		sameboy $(TARGET); \
	elif command -v mgba > /dev/null 2>&1; then \
		echo "Running on mGBA (with GB support)..."; \
		mgba $(TARGET); \
	else \
		echo "No Game Boy emulator found!"; \
		echo "Install one of: BGB, SameBoy, mGBA"; \
		echo "Or open $(TARGET) manually in your emulator"; \
	fi

# Deploy to Tinker Board
deploy: $(TARGET)
	@if [ -z "$(IP)" ]; then \
		echo "Error: Please specify Tinker Board IP"; \
		echo "Usage: make deploy IP=192.168.1.XXX"; \
		exit 1; \
	fi
	@echo "Deploying to Tinker Board at $(IP)..."
	scp $(TARGET) root@$(IP):/storage/roms/Game\ Boy/
	@echo "✓ Deployed successfully!"
	@echo ""
	@echo "On Lakka:"
	@echo "1. Main Menu > Import Content > Scan Directory"
	@echo "2. Select /storage/roms/Game Boy/"
	@echo "3. Find 'Chicken Shooter' in Game Boy collection"
	@echo "4. Play!"

# Clean build files
clean:
	rm -f $(OBJECTS) $(TARGET) *.map *.sym *.lst
	@echo "✓ Cleaned build files"

# Help
help:
	@echo "Chicken Shooter - Makefile Commands"
	@echo ""
	@echo "  make          - Build the ROM"
	@echo "  make test     - Build and run on emulator"
	@echo "  make deploy   - Deploy to Tinker Board (requires IP=xxx.xxx.xxx.xxx)"
	@echo "  make clean    - Remove build files"
	@echo "  make help     - Show this help"
	@echo ""

.PHONY: all test deploy clean help
