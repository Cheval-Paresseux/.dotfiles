pragma Singleton

import Quickshell
import QtQuick

// Whisky palette: quiet luxury in old-money shades. Bottle-green darks, ivory text, antique gold
// for focus, and muted sage, slate, cognac and claret for the rest (see themes/the_gentleman/whisky/README.md)
Singleton {
    readonly property string name: "whisky"

    // Neutral scale: from the dark green of the club's velvet to the ivory of a menu card
    readonly property color crust: "#0a0d0b"
    readonly property color mantle: "#121815"
    readonly property color surface0: "#18201b"
    readonly property color surface1: "#1f2a23"
    readonly property color surface2: "#2a372e"
    readonly property color overlay0: "#45524a"
    readonly property color overlay1: "#66716a"
    readonly property color subtext0: "#9a9f94"
    readonly property color subtext1: "#c2bfae"
    readonly property color ivory: "#e4dcc8"

    // Accents
    readonly property color gold: "#c8a96a"
    readonly property color paleGold: "#e3cf9c"
    readonly property color oldGold: "#7d6535"
    readonly property color sage: "#88a878"
    readonly property color slate: "#8b9cab"
    readonly property color cognac: "#c98a4b"
    readonly property color claret: "#b24a4f"

    // Roles
    readonly property color accent: gold
    readonly property color info: slate
    readonly property color success: sage
    readonly property color warning: cognac
    readonly property color critical: claret

    // Smoked glass: translucent over Hyprland's blur (see hypr/hyprland/rules.lua)
    readonly property color background: Qt.alpha(crust, 0.82)
    readonly property color popupBackground: Qt.alpha(mantle, 0.92)
    readonly property color surface: surface0
    readonly property color surfaceHover: surface1
    readonly property color surfaceActive: surface2
    readonly property color overlay: "#99000000"
    readonly property color lockOverlay: "#b3060403"
    // The pool of light a lamp leaves on the table
    readonly property color lampGlow: Qt.alpha(gold, 0.07)

    readonly property color border: surface2
    readonly property color borderFocus: accent
    readonly property color borderCritical: critical

    readonly property color text: ivory
    readonly property color textMuted: subtext1
    readonly property color textSubtle: subtext0
    readonly property color textDisabled: overlay1
    readonly property color textCritical: critical
    readonly property color textOnAccent: crust

    readonly property color selection: Qt.alpha(accent, 0.3)
    readonly property color selectionText: ivory

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
