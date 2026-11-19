pragma Singleton

import Quickshell
import QtQuick

// Tatooine palette: dusk-warm browns, sand text, twin-sun accents (see themes/tatooine/README.md)
Singleton {
    readonly property string name: "tatooine"

    // Neutral scale
    readonly property color crust: "#130e0a"
    readonly property color mantle: "#1f1812"
    readonly property color surface0: "#2b221a"
    readonly property color surface1: "#372b21"
    readonly property color surface2: "#47382b"
    readonly property color overlay0: "#6e5b49"
    readonly property color overlay1: "#8c7663"
    readonly property color subtext0: "#b9a58d"
    readonly property color subtext1: "#d3c1a5"
    readonly property color white: "#eedfc4"

    // Accents
    readonly property color sun: "#f2a65a"
    readonly property color gold: "#f5cf73"
    readonly property color sage: "#a9b665"
    readonly property color sky: "#7fb4b5"
    readonly property color duskBlue: "#8aa6c1"
    readonly property color rust: "#d2734a"
    readonly property color blaster: "#e5533d"

    // Roles
    readonly property color accent: sun
    readonly property color info: sky
    readonly property color success: sage
    readonly property color warning: gold
    readonly property color critical: blaster

    readonly property color background: Qt.alpha(crust, 0.6)
    readonly property color backgroundHover: Qt.alpha(mantle, 0.75)
    readonly property color popupBackground: Qt.alpha(mantle, 0.78)
    readonly property color surface: surface0
    readonly property color surfaceHover: surface1
    readonly property color surfaceActive: surface2
    readonly property color overlay: "#40130e0a"
    readonly property color lockOverlay: "#99130e0a"

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

    readonly property int radius: 8
    readonly property int padding: 14

    readonly property int fontSmall: 10
    readonly property int fontNormal: 11
    readonly property int fontMedium: 12
    readonly property int fontLarge: 13
    readonly property int fontInput: 14

    readonly property string displayFont: "Oxanium" // signage: clock, titles, lock screen
    readonly property string iconFont: "MesloLGM Nerd Font Propo"
    readonly property int iconSize: 14

    readonly property int barHeight: 26
    readonly property int barItemHeight: 20

    readonly property string wallpaperDirectory: Quickshell.shellPath("assets/wallpapers")
    readonly property string defaultWallpaper: wallpaperDirectory + "/moonset.png"
}
