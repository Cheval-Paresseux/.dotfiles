pragma Singleton

import Quickshell
import QtQuick

// Mugen palette: a light theme of washi paper and sumi ink, the vermilion of the rising sun for focus,
// and the old dyes for the rest: indigo, bamboo, ochre and crimson (see themes/characters/mugen/README.md)
Singleton {
    readonly property string name: "mugen"

    // Neutral scale, from the paper to the ink
    readonly property color crust: "#e9e3d7"
    readonly property color mantle: "#efeae0"
    readonly property color surface0: "#e3dccd"
    readonly property color surface1: "#d8cfbd"
    readonly property color surface2: "#c6bca8"
    readonly property color overlay0: "#9c917f"
    readonly property color overlay1: "#7b7163"
    readonly property color subtext0: "#5c544a"
    readonly property color subtext1: "#3f3932"
    readonly property color sumi: "#1e1a17"

    // Accents
    readonly property color sun: "#d23a1e"
    readonly property color indigo: "#2e5a88"
    readonly property color bamboo: "#4f7d35"
    readonly property color ochre: "#a8740f"
    readonly property color crimson: "#9c1730"
    readonly property color plum: "#7a4588"

    // Roles
    readonly property color accent: sun
    readonly property color info: indigo
    readonly property color success: bamboo
    readonly property color warning: ochre
    readonly property color critical: crimson

    // Paper, not glass: everything is opaque
    readonly property color background: crust
    readonly property color backgroundHover: mantle
    readonly property color popupBackground: mantle
    readonly property color surface: surface0
    readonly property color surfaceHover: surface1
    readonly property color surfaceActive: surface2
    readonly property color overlay: "#401e1a17"
    readonly property color lockOverlay: "#99e9e3d7"

    readonly property color border: surface2
    readonly property color borderFocus: accent
    readonly property color borderCritical: critical

    readonly property color text: sumi
    readonly property color textMuted: subtext1
    readonly property color textSubtle: subtext0
    readonly property color textDisabled: overlay1
    readonly property color textCritical: critical
    readonly property color textOnAccent: "#ffffff"

    readonly property color selection: Qt.alpha(accent, 0.22)
    readonly property color selectionText: sumi

    readonly property int radius: 0
    readonly property int padding: 14

    readonly property int fontSmall: 10
    readonly property int fontNormal: 11
    readonly property int fontMedium: 12
    readonly property int fontLarge: 13
    readonly property int fontInput: 14

    // Kanji numerals, titles and the lock screen: heavy strokes like a brush
    readonly property string kanjiFont: "Noto Sans CJK JP"
    readonly property string iconFont: "MesloLGM Nerd Font Propo"
    readonly property int iconSize: 14

    readonly property int barHeight: 26

    readonly property string wallpaperDirectory: Quickshell.shellPath("assets/wallpapers")
    readonly property string defaultWallpaper: wallpaperDirectory + "/champloo.jpg"
}
