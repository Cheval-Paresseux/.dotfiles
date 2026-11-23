pragma Singleton

import Quickshell
import QtQuick

// Death Star palette: gunmetal neutrals, saber red focus, Force-lightning violet for danger
// (see themes/star_wars/death_star/README.md)
Singleton {
    readonly property string name: "death_star"

    // Neutral scale
    readonly property color crust: "#08090b"
    readonly property color mantle: "#131519"
    readonly property color surface0: "#1b1e23"
    readonly property color surface1: "#24282e"
    readonly property color surface2: "#30353d"
    readonly property color overlay0: "#4b515b"
    readonly property color overlay1: "#676e79"
    readonly property color subtext0: "#9399a3"
    readonly property color subtext1: "#b8bdc5"
    readonly property color white: "#dfe2e6"

    // Accents
    readonly property color saber: "#e32b36"
    readonly property color blood: "#8f1820"
    readonly property color reactor: "#84c26a"
    readonly property color imperialBlue: "#73a7d9"
    readonly property color fire: "#e8743b"
    readonly property color alarm: "#f2b134"
    readonly property color lightning: "#b18cff"

    // Roles
    readonly property color accent: saber
    readonly property color info: imperialBlue
    readonly property color success: reactor
    readonly property color warning: alarm
    readonly property color critical: lightning

    readonly property color background: Qt.alpha(crust, 0.96)
    readonly property color backgroundHover: mantle
    readonly property color popupBackground: mantle
    readonly property color surface: surface0
    readonly property color surfaceHover: surface1
    readonly property color surfaceActive: surface2
    readonly property color overlay: "#b308090b"
    readonly property color lockOverlay: "#8c08090b"

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

    readonly property string displayFont: "Oxanium" // stencilled signage: clock, titles, lock screen
    readonly property string iconFont: "MesloLGM Nerd Font Propo"
    readonly property int iconSize: 14

    readonly property int barHeight: 28
    readonly property int barItemHeight: 20

    readonly property string wallpaperDirectory: Quickshell.shellPath("assets/wallpapers")
    readonly property string defaultWallpaper: wallpaperDirectory + "/vader.jpg"
}
