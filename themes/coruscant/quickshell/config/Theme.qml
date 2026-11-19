pragma Singleton

import Quickshell
import QtQuick

// Coruscant palette: onyx navy, champagne gold for focus, ivory text, and jewel tones;
// emerald and ruby keep the market's meaning, good and bad news (see themes/coruscant/README.md)
Singleton {
    readonly property string name: "coruscant"

    // Neutral scale
    readonly property color crust: "#07080c"
    readonly property color mantle: "#10131b"
    readonly property color surface0: "#161a24"
    readonly property color surface1: "#1e2330"
    readonly property color surface2: "#2a3040"
    readonly property color overlay0: "#474d5e"
    readonly property color overlay1: "#656b7c"
    readonly property color subtext0: "#a8a49b"
    readonly property color subtext1: "#cdc8bc"
    readonly property color white: "#ece6d8"

    // Accents
    readonly property color gold: "#d8b26e"
    readonly property color champagne: "#f0d9a0"
    readonly property color brass: "#8c6a32"
    readonly property color sapphire: "#7ea6e0"
    readonly property color emerald: "#4fb38a"
    readonly property color ruby: "#d9506a"
    readonly property color topaz: "#e39a55"
    readonly property color amethyst: "#a68bd8"

    // Roles
    readonly property color accent: gold
    readonly property color info: sapphire
    readonly property color success: emerald
    readonly property color warning: topaz
    readonly property color critical: ruby

    readonly property color background: Qt.alpha(crust, 0.78)
    readonly property color backgroundHover: Qt.alpha(mantle, 0.9)
    readonly property color popupBackground: Qt.alpha(mantle, 0.9)
    readonly property color surface: surface0
    readonly property color surfaceHover: surface1
    readonly property color surfaceActive: surface2
    readonly property color overlay: "#b307080c"
    readonly property color lockOverlay: "#8c07080c"

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

    readonly property int radius: 0
    readonly property int padding: 14

    readonly property int fontSmall: 10
    readonly property int fontNormal: 11
    readonly property int fontMedium: 12
    readonly property int fontLarge: 13
    readonly property int fontInput: 14

    readonly property string displayFont: "Noto Sans Display" // letter-spaced capitals, like a private bank's letterhead: clock, titles, lock screen
    readonly property string iconFont: "MesloLGM Nerd Font Propo"
    readonly property int iconSize: 14

    readonly property int barHeight: 36
    readonly property int barItemHeight: 20

    readonly property string wallpaperDirectory: Quickshell.shellPath("assets/wallpapers")
    readonly property string defaultWallpaper: wallpaperDirectory + "/deco.jpg"
}
