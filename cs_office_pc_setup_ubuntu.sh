#!/bin/bash
# CS_OFFICE_PC Setup Script for Ubuntu LXDE
# Author: F1dg3t
# Version: 1.0

CONFIG_DIR="$HOME/.config/cs_office_pc"
SOUND_DIR="$CONFIG_DIR/sounds"
mkdir -p "$SOUND_DIR"

# Install LXDE and dependencies
function install_dependencies() {
    echo "Installing LXDE and required packages..."
    sudo apt update
    sudo apt install -y lxde lxappearance pcmanfm xscreensaver xscreensaver-gl-extra gnome-icon-theme fonts-croscore ttf-mscorefonts-installer git curl wget
}

# Install Chicago95 theme
function install_theme() {
    echo "Installing Chicago95 theme..."
    if [ ! -d "$HOME/.themes/Chicago95" ]; then
        git clone https://github.com/grassmunk/Chicago95.git "$HOME/.themes/Chicago95"
    fi
    mkdir -p "$HOME/.icons"
    cp -r "$HOME/.themes/Chicago95/icons/*" "$HOME/.icons/"
    echo "Theme installed. Use lxappearance to activate."
}

# Set wallpaper
function set_wallpaper() {
    echo "Setting wallpaper..."
    mkdir -p "$HOME/Pictures"
    wget -qO "$HOME/Pictures/cs_office_wall.jpg" https://i.imgur.com/YOUR_CUSTOM_WALLPAPER.jpg
    pcmanfm --set-wallpaper "$HOME/Pictures/cs_office_wall.jpg"
}

# Enable screensavers
function enable_screensavers() {
    echo "Enabling screensavers..."
    xscreensaver-command -exit
    echo "Run xscreensaver-demo to configure."
}

# Configure sounds
function install_sounds() {
    echo "== Add Windows 2000 Sound Pack =="

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

    echo "Expected sounds listed at $MANIFEST"
    echo "Place matching WAV files in $SOUND_DIR"
    echo

    found_any=0
    while read -r sound_file; do
        if [ -f "$SOUND_DIR/$sound_file" ]; then
            echo "✔ Found: $sound_file"
            found_any=1
        else
            echo "✘ Missing: $sound_file"
        fi
    done < "$MANIFEST"

    if [ -f "$SOUND_DIR/Windows XP Startup.wav" ]; then
        echo "Configuring startup sound..."
        mkdir -p "$HOME/.config/autostart"
        cat <<EOF > "$HOME/.config/autostart/startup-sound.desktop"
[Desktop Entry]
Name=Startup Sound
Exec=paplay "$SOUND_DIR/Windows XP Startup.wav"
Type=Application
X-GNOME-Autostart-enabled=true
EOF
        echo "Startup sound ready."
    else
        echo "Startup sound not configured (missing file)."
    fi
}

# Main menu
function show_menu() {
    echo
    echo "========= CS_OFFICE_PC Ubuntu Setup ========="
    echo "1. Install LXDE + dependencies"
    echo "2. Apply Chicago95 theme"
    echo "3. Set retro wallpaper"
    echo "4. Enable screensavers"
    echo "5. Configure Windows 2000/XP sounds"
    echo "6. Run all"
    echo "0. Exit"
    echo "============================================="
    read -p "Select option: " choice

    case $choice in
        1) install_dependencies ;;
        2) install_theme ;;
        3) set_wallpaper ;;
        4) enable_screensavers ;;
        5) install_sounds ;;
        6)
            install_dependencies
            install_theme
            set_wallpaper
            enable_screensavers
            install_sounds
            ;;
        0) exit 0 ;;
        *) echo "Invalid option." ;;
    esac
}

while true; do
    show_menu
done
