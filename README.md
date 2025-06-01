# 📄 CS\_OFFICE\_PC Setup Script

A retro-themed setup script for recreating the **Windows 2000/XP-style** desktop seen in `cs_office` (from Counter-Strike) on a **Debian 12 system using LXDE**.

---

## 📦 Requirements

* Debian 12 (Bookworm)
* LXDE desktop environment

Install LXDE if it's not already installed:

```bash
sudo apt update
sudo apt install task-lxde-desktop
```

---

## 🚀 Getting Started

1. Clone or download the script:

   ```bash
   wget https://your-server.com/cs_office_pc_setup.sh
   chmod +x cs_office_pc_setup.sh
   ```

2. Run the script:

   ```bash
   ./cs_office_pc_setup.sh
   ```

---

## 🛠️ What the Script Does

The script offers a menu-driven setup to configure the following:

| Option | Description                                                     |
| ------ | --------------------------------------------------------------- |
| 1      | Installs required packages (themes, fonts, etc.)                |
| 2      | Applies the **Chicago95** GTK+ theme for a Windows 9x/2000 feel |
| 3      | Sets a custom retro wallpaper                                   |
| 4      | Enables classic screensavers (via `xscreensaver`)               |
| 5      | Installs Microsoft Core Fonts (via `ttf-mscorefonts-installer`) |
| 6      | Adds support for **Windows XP/2000 sound effects**              |
| 7      | Runs **all of the above**                                       |
| 0      | Exits the script                                                |

---

## 🔊 Adding Windows 2000/XP Sound Effects

To enable startup/shutdown/login sounds:

1. Place your `.wav` sound files into:

   ```
   ~/.config/cs_office_pc/sounds/
   ```

2. The script will generate a file:

   ```
   ~/.config/cs_office_pc/sounds/expected_sounds.txt
   ```

   This lists all expected filenames like:

   * `Windows XP Startup.wav`
   * `Windows XP Shutdown.wav`
   * `Windows XP Error.wav`
   * `Windows XP Notify.wav`

3. Rerun the script and select option `6` to configure the sounds.

📝 **Note:** Only the startup sound is hooked automatically (via `autostart`). You can use the remaining sounds manually or with custom system event scripts.

---

## 📁 File Structure

```
~/
├── cs_office_pc_setup.sh
└── .config/
    └── cs_office_pc/
        └── sounds/
            ├── expected_sounds.txt
            └── [Your WAV files here]
```

---

## 🎨 Optional Tools

* Customize theme/icons using `lxappearance`
* Set screensavers with `xscreensaver-demo`
* Browse and manage desktop background via `pcmanfm`

---

## ✅ Tips

* **Fully re-runnable**: You can run the script multiple times to reconfigure or add new content.
* Great for retro-style setups, theme screenshots, or building a physical “CS Office” style PC.

---

## 📜 License

MIT License (free for personal or commercial use)

---

## 🔹 Inspired By

* Valve’s *Counter-Strike* (`cs_office`)
* Windows 2000 / XP desktops
* The community behind [Chicago95](https://github.com/grassmunk/Chicago95)

---

**Built for fun and nostalgia. Enjoy the chunky beige vibes!**
