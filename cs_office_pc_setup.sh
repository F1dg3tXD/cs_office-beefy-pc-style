#!/bin/bash
# CS_OFFICE_PC Setup Script for Debian 12 LXDE
# Author: ChatGPT + You
# Version: 1.0

# Config folder
CONFIG_DIR="$HOME/.config/cs_office_pc"
mkdir -p "$CONFIG_DIR"
SOUND_DIR="$CONFIG_DIR/sounds"

# Dependencies check/install
function install_dependencies() {
    echo "Installing required packages..."
    sudo apt update
    sudo apt install -y git lxappearance pcmanfm xscreensaver xscreensaver-gl-extra gnome-icon-theme fonts-croscore
}

# Apply Chicago95 theme
function install_theme() {
    echo "Installing Chicago95 theme..."
    if [ ! -d "$HOME/.themes/Chicago95" ]; then
        git clone https://github.com/grassmunk/Chicago95.git "$HOME/.themes/Chicago95"
    fi
    mkdir -p "$HOME/.icons"
    cp -r "$HOME/.themes/Chicago95/icons/*" "$HOME/.icons/"
    echo "Theme installed. Set it via lxappearance."
}

# Set wallpaper (sample 4:3 image)
function set_wallpaper() {
    echo "Setting retro wallpaper..."
    mkdir -p "$HOME/Pictures"
    wget -qO "$HOME/Pictures/cs_office_wall.jpg" https://i.imgur.com/YOUR_CUSTOM_WALLPAPER.jpg
    pcmanfm --set-wallpaper "$HOME/Pictures/cs_office_wall.jpg"
}

# Enable retro screensavers
function enable_screensavers() {
    echo "Enabling vintage screensavers..."
    xscreensaver-command -exit
    echo "Run xscreensaver-demo to configure."
}

# Install MS fonts
function install_fonts() {
    echo "Installing Microsoft fonts..."
    sudo apt install -y ttf-mscorefonts-installer
}

# Add Windows 2000 sounds (user must supply files)
function install_sounds() {
    echo "== Add Windows 2000 Sound Pack =="
    mkdir -p "$SOUND_DIR"

    # Manifest of expected files
    MANIFEST="$SOUND_DIR/expected_sounds.txt"
    cat <<EOF > "$MANIFEST"
Windows XP Startup.wav
Windows XP Shutdown.wav
Windows XP Logoff Sound.wav
Windows XP Logon Sound.wav
Windows XP Error.wav
Windows XP Exclamation.wav
Windows XP Notify.wav
Windows XP Critical Stop.wav
EOF

    echo
    echo "Expected sound files list written to:"
    echo "  $MANIFEST"
    echo "Place the corresponding .wav files in:"
    echo "  $SOUND_DIR"
    echo

    # Show progress on what's found
    echo "Checking for available sounds:"
    found_any=0
    while read -r sound_file; do
        if [ -f "$SOUND_DIR/$sound_file" ]; then
            echo "✔ Found: $sound_file"
            found_any=1
        else
            echo "✘ Missing: $sound_file"
        fi
    done < "$MANIFEST"

    echo

    # Optionally enable startup sound if present
    if [ -f "$SOUND_DIR/Windows XP Startup.wav" ]; then
        echo "Enabling startup sound..."
        mkdir -p "$HOME/.config/autostart"
        cat <<EOF > "$HOME/.config/autostart/startup-sound.desktop"
[Desktop Entry]
Name=Startup Sound
Exec=paplay "$SOUND_DIR/Windows XP Startup.wav"
Type=Application
X-GNOME-Autostart-enabled=true
EOF
        echo "Startup sound configured."
    else
        echo "Startup sound not configured (missing Startup.wav)."
    fi

    echo
    echo "You can re-run this option anytime to add more sounds later."
}

# Menu system
function show_menu() {
    echo
    echo "========= CS_OFFICE_PC Setup ========="
    echo "1. Install dependencies"
    echo "2. Apply retro theme (Chicago95)"
    echo "3. Set retro wallpaper"
    echo "4. Enable screensavers"
    echo "5. Install MS fonts"
    echo "6. Add Windows 2000 sound pack"
    echo "7. Run all steps"
    echo "0. Exit"
    echo "======================================"
    read -p "Choose an option: " choice
    echo

    case "$choice" in
        1) install_dependencies ;;
        2) install_theme ;;
        3) set_wallpaper ;;
        4) enable_screensavers ;;
        5) install_fonts ;;
        6) install_sounds ;;
        7)
            install_dependencies
            install_theme
            set_wallpaper
            enable_screensavers
            install_fonts
            install_sounds
            ;;
        0) exit 0 ;;
        *) echo "Invalid choice." ;;
    esac
}

# Run menu loop
while true; do
    show_menu
done