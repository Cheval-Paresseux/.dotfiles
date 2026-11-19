pragma Singleton

import Quickshell
import QtQuick

// Base theme palette: neutral greys with green, blue and yellow accents (see themes/base/README.md)
Singleton {
    readonly property string name: "base"

    // Neutral scale
    readonly property color crust: "#111111"
    readonly property color mantle: "#1c1c1c"
    readonly property color surface0: "#262626"
    readonly property color surface1: "#303030"
    readonly property color surface2: "#3d3d3d"
    readonly property color overlay0: "#595959"
    readonly property color overlay1: "#737373"
    readonly property color subtext0: "#a6a6a6"
    readonly property color subtext1: "#c4c4c4"
    readonly property color white: "#e6e6e6"

    // Accents
    readonly property color aqua: "#73daca"
    readonly property color green: "#9ece6a"
    readonly property color blue: "#7aa2f7"
    readonly property color yellow: "#ecd06f"
    readonly property color orange: "#ff9e64"
    readonly property color red: "#f7768e"

    // Roles
    readonly property color accent: aqua
    readonly property color info: blue
    readonly property color success: green
    readonly property color warning: yellow
    readonly property color critical: red

    readonly property color background: Qt.alpha(crust, 0.92)
    readonly property color backgroundHover: Qt.alpha(mantle, 0.95)
    readonly property color popupBackground: mantle
    readonly property color surface: surface0
    readonly property color surfaceHover: surface1
    readonly property color surfaceActive: surface2
    readonly property color overlay: "#80000000"
    readonly property color lockOverlay: "#99000000"

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

    readonly property string iconFont: "MesloLGM Nerd Font Propo"
    readonly property int iconSize: 14

    readonly property int barHeight: 20

    readonly property string wallpaperDirectory: Quickshell.shellPath("assets/wallpapers")
    readonly property string defaultWallpaper: wallpaperDirectory + "/house.jpg"
}
