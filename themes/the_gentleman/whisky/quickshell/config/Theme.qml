pragma Singleton

import Quickshell
import QtQuick

// Whisky palette: tobacco-dark wood, cream text, amber whisky for focus, the lounge's
// velvet, smoke, ember and wine for the rest (see themes/the_gentleman/whisky/README.md)
Singleton {
    readonly property string name: "whisky"

    // Neutral scale: from the dark of the room to the cream of a menu card
    readonly property color crust: "#0c0907"
    readonly property color mantle: "#17120e"
    readonly property color surface0: "#201913"
    readonly property color surface1: "#2a2119"
    readonly property color surface2: "#382b20"
    readonly property color overlay0: "#5a4838"
    readonly property color overlay1: "#7a6652"
    readonly property color subtext0: "#a8957d"
    readonly property color subtext1: "#cbb89c"
    readonly property color cream: "#eadcc2"

    // Accents
    readonly property color amber: "#e3a14e"
    readonly property color honey: "#f2c37d"
    readonly property color brass: "#9a7038"
    readonly property color velvet: "#7aa874"
    readonly property color smoke: "#8da4bf"
    readonly property color ember: "#e8743c"
    readonly property color wine: "#c94a52"

    // Roles
    readonly property color accent: amber
    readonly property color info: smoke
    readonly property color success: velvet
    readonly property color warning: ember
    readonly property color critical: wine

    // Smoked glass: translucent over Hyprland's blur (see hypr/hyprland/rules.lua)
    readonly property color background: Qt.alpha(crust, 0.82)
    readonly property color popupBackground: Qt.alpha(mantle, 0.92)
    readonly property color surface: surface0
    readonly property color surfaceHover: surface1
    readonly property color surfaceActive: surface2
    readonly property color overlay: "#99000000"
    readonly property color lockOverlay: "#b3060403"
    // The pool of light a lamp leaves on the table
    readonly property color lampGlow: Qt.alpha(amber, 0.16)

    readonly property color border: surface2
    readonly property color borderFocus: accent
    readonly property color borderCritical: critical

    readonly property color text: cream
    readonly property color textMuted: subtext1
    readonly property color textSubtle: subtext0
    readonly property color textDisabled: overlay1
    readonly property color textCritical: critical
    readonly property color textOnAccent: crust

    readonly property color selection: Qt.alpha(accent, 0.3)
    readonly property color selectionText: cream

    readonly property int radius: 8
    readonly property int padding: 16

    readonly property int fontSmall: 10
    readonly property int fontNormal: 11
    readonly property int fontMedium: 12
    readonly property int fontLarge: 13
    readonly property int fontInput: 14

    readonly property string iconFont: "MesloLGM Nerd Font Propo"
    readonly property int iconSize: 15
    // Set like a drinks menu: titles, the clock and the lock screen. Playfair is a variable font
    // whose optical size defaults to its sturdy text cut: displayAxes asks for its Display cut
    readonly property string displayFont: "Playfair"
    readonly property var displayAxes: ({ "opsz": 48 })

    readonly property int barHeight: 32

    readonly property string wallpaperDirectory: Quickshell.shellPath("assets/wallpapers")
    readonly property string defaultWallpaper: wallpaperDirectory + "/whisky.png"
}
