pragma Singleton

import Quickshell
import QtQuick

// Dagobah palette: misty swamp greens, a blue training saber for focus (see themes/dagobah/README.md)
Singleton {
    readonly property string name: "dagobah"

    // Neutral scale
    readonly property color crust: "#0a1110"
    readonly property color mantle: "#131e1b"
    readonly property color surface0: "#1a2824"
    readonly property color surface1: "#22332e"
    readonly property color surface2: "#2c403a"
    readonly property color overlay0: "#476058"
    readonly property color overlay1: "#607a71"
    readonly property color subtext0: "#90a79e"
    readonly property color subtext1: "#b4c6bd"
    readonly property color white: "#dbe6dc"

    // Accents
    readonly property color saber: "#6cb6ff"
    readonly property color mist: "#7cc4b8"
    readonly property color moss: "#9ccc65"
    readonly property color lantern: "#e8c15d"
    readonly property color ember: "#e0735a"
    readonly property color lichen: "#c8d67a"

    // Roles
    readonly property color accent: saber
    readonly property color info: mist
    readonly property color success: moss
    readonly property color warning: lantern
    readonly property color critical: ember

    // Translucent like wet glass, frosted by the Hyprland blur (see hypr/hyprland/rules.lua)
    readonly property color background: Qt.alpha(crust, 0.6)
    readonly property color backgroundHover: Qt.alpha(mantle, 0.75)
    readonly property color popupBackground: Qt.alpha(mantle, 0.8)
    readonly property color surface: surface0
    readonly property color surfaceHover: surface1
    readonly property color surfaceActive: surface2
    readonly property color overlay: "#400a1110"
    readonly property color lockOverlay: "#800a1110"

    readonly property color border: surface2
    readonly property color borderFocus: accent
    readonly property color borderCritical: critical

    readonly property color text: white
    readonly property color textMuted: subtext1
    readonly property color textSubtle: subtext0
    readonly property color textDisabled: overlay1
    readonly property color textCritical: critical
    readonly property color textOnAccent: crust

    readonly property color selection: Qt.alpha(accent, 0.35)
    readonly property color selectionText: white

    readonly property int radius: 12
    readonly property int padding: 14

    readonly property int fontSmall: 10
    readonly property int fontNormal: 11
    readonly property int fontMedium: 12
    readonly property int fontLarge: 13
    readonly property int fontInput: 14

    readonly property string displayFont: "FantasqueSansM Nerd Font Propo" // hand-drawn, like carved wood
    readonly property string iconFont: "MesloLGM Nerd Font Propo"
    readonly property int iconSize: 14

    readonly property int barHeight: 30
    readonly property int barItemHeight: 22
    readonly property int barMargin: 6

    readonly property string wallpaperDirectory: Quickshell.shellPath("assets/wallpapers")
    readonly property string defaultWallpaper: wallpaperDirectory + "/endor.jpg"
}
