pragma Singleton

import Quickshell
import QtQuick

// Sex palette: black with a wine tint, skin-warm text, magenta neon for focus, and the
// safeword lights for status: green go, amber slow down, red stop (see themes/the_gentleman/sex/README.md)
Singleton {
    readonly property string name: "sex"

    // Neutral scale: from black leather to the warmth of skin
    readonly property color crust: "#0b0709"
    readonly property color mantle: "#160d12"
    readonly property color surface0: "#1f1219"
    readonly property color surface1: "#2a1822"
    readonly property color surface2: "#3a2130"
    readonly property color overlay0: "#5c3a4b"
    readonly property color overlay1: "#7d5868"
    readonly property color subtext0: "#b0909c"
    readonly property color subtext1: "#d4b8c0"
    readonly property color skin: "#f2e4e6"

    // Accents
    readonly property color neon: "#f03c96"
    readonly property color blush: "#f7a8c8"
    readonly property color crimson: "#8e1538"
    readonly property color cyan: "#4fc3d9"
    readonly property color go: "#6fd08c"
    readonly property color tungsten: "#f2a541"
    readonly property color stop: "#ff4b3a"

    // Roles
    readonly property color accent: neon
    readonly property color info: cyan
    readonly property color success: go
    readonly property color warning: tungsten
    readonly property color critical: stop

    // Dark glass over Hyprland's blur (see hypr/hyprland/rules.lua)
    readonly property color background: Qt.alpha(crust, 0.86)
    readonly property color popupBackground: Qt.alpha(mantle, 0.94)
    readonly property color surface: surface0
    readonly property color surfaceHover: surface1
    readonly property color surfaceActive: surface2
    readonly property color overlay: "#b3050304"
    readonly property color lockOverlay: "#cc050304"

    readonly property color border: surface2
    readonly property color borderFocus: accent
    readonly property color borderCritical: critical

    readonly property color text: skin
    readonly property color textMuted: subtext1
    readonly property color textSubtle: subtext0
    readonly property color textDisabled: overlay1
    readonly property color textCritical: critical
    readonly property color textOnAccent: crust

    readonly property color selection: Qt.alpha(accent, 0.3)
    readonly property color selectionText: skin

    readonly property int radius: 12
    readonly property int padding: 16

    readonly property int fontSmall: 10
    readonly property int fontNormal: 11
    readonly property int fontMedium: 12
    readonly property int fontLarge: 13
    readonly property int fontInput: 14

    readonly property string iconFont: "MesloLGM Nerd Font Propo"
    readonly property int iconSize: 15
    // Titles set like a fashion magazine: Playfair at a large optical size, sharp hairlines and high contrast
    readonly property string displayFont: "Playfair"
    readonly property var displayAxes: ({ "opsz": 144 })

    readonly property int barHeight: 34

    readonly property string wallpaperDirectory: Quickshell.shellPath("assets/wallpapers")
    readonly property string defaultWallpaper: wallpaperDirectory + "/car.jpg"
}
