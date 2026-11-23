pragma Singleton

import Quickshell
import QtQuick

// Eddie palette: the duke's estate in tweed and oak. Loden and oak darks, oatmeal text, the scarlet of
// the hunting coat for focus, and the overchecks of a tweed for the rest (see themes/characters/eddie/README.md)
Singleton {
    readonly property string name: "eddie"

    // Neutral scale: from the oak of the gun room to the oatmeal of a tweed
    readonly property color crust: "#100f0b"
    readonly property color mantle: "#1b1913"
    readonly property color surface0: "#23201a"
    readonly property color surface1: "#2d2921"
    readonly property color surface2: "#3a352a"
    readonly property color overlay0: "#554e3f"
    readonly property color overlay1: "#776e5a"
    readonly property color subtext0: "#a39a80"
    readonly property color subtext1: "#c7bea2"
    readonly property color oatmeal: "#e8dfc5"

    // Accents
    readonly property color scarlet: "#c8432c"
    readonly property color claret: "#a63a55"
    readonly property color moss: "#8ea35a"
    readonly property color mustard: "#d0a443"
    readonly property color lovat: "#7f9cb0"
    readonly property color saddle: "#b5865a"
    // Saddlery: the stitching of a leather strap and its brass rivets
    readonly property color leather: "#8c6a45"
    readonly property color brass: "#c2a05a"

    // Roles
    readonly property color accent: scarlet
    readonly property color info: lovat
    readonly property color success: moss
    readonly property color warning: mustard
    readonly property color critical: claret

    // Matte and opaque, like waxed cotton
    readonly property color background: crust
    readonly property color popupBackground: mantle
    readonly property color surface: surface0
    readonly property color surfaceHover: surface1
    readonly property color surfaceActive: surface2
    readonly property color overlay: "#99000000"
    readonly property color lockOverlay: "#c0100f0b"

    readonly property color border: surface2
    readonly property color borderFocus: accent
    readonly property color borderCritical: critical

    readonly property color text: oatmeal
    readonly property color textMuted: subtext1
    readonly property color textSubtle: subtext0
    readonly property color textDisabled: overlay1
    readonly property color textCritical: critical
    readonly property color textOnAccent: "#f3ead2"

    readonly property color selection: Qt.alpha(accent, 0.3)
    readonly property color selectionText: oatmeal

    readonly property int radius: 4
    readonly property int padding: 16

    readonly property int fontSmall: 10
    readonly property int fontNormal: 11
    readonly property int fontMedium: 12
    readonly property int fontLarge: 13
    readonly property int fontInput: 14

    readonly property string iconFont: "MesloLGM Nerd Font Propo"
    readonly property int iconSize: 15
    // Set like an estate's letterhead: titles, the clock, workspace numerals and the lock screen
    readonly property string displayFont: "Noto Serif Display"

    readonly property int barHeight: 32

    readonly property string wallpaperDirectory: Quickshell.shellPath("assets/wallpapers")
    readonly property string defaultWallpaper: wallpaperDirectory + "/whisky.png"
}
