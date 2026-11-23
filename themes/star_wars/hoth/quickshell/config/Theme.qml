pragma Singleton

import Quickshell
import QtQuick

// Hoth palette: a light theme of snow and ice greys under slate text, Rebel orange for focus,
// and the two sabers of the duel: Luke's blue for information, Vader's red for danger
// (see themes/star_wars/hoth/README.md)
Singleton {
    readonly property string name: "hoth"

    // Neutral scale, from the snow outwards to the slate text
    readonly property color crust: "#e3eaf1"
    readonly property color mantle: "#ebf0f5"
    readonly property color surface0: "#dce4ec"
    readonly property color surface1: "#cfd9e3"
    readonly property color surface2: "#bccad8"
    readonly property color overlay0: "#91a1b3"
    readonly property color overlay1: "#718296"
    readonly property color subtext0: "#536478"
    readonly property color subtext1: "#3d4c5e"
    readonly property color slate: "#1f2a37"

    // Accents
    readonly property color rebel: "#d9581f"
    readonly property color saber: "#2f73c0"
    readonly property color vader: "#c42f3a"
    readonly property color tundra: "#3f8a3a"
    readonly property color beacon: "#a87b00"
    readonly property color steel: "#546a82"

    // Roles
    readonly property color accent: rebel
    readonly property color info: saber
    readonly property color success: tundra
    readonly property color warning: beacon
    readonly property color critical: vader

    // Frosted like ice, blurred by Hyprland (see hypr/hyprland/rules.lua)
    readonly property color background: Qt.alpha(crust, 0.7)
    readonly property color backgroundHover: Qt.alpha(mantle, 0.85)
    readonly property color popupBackground: Qt.alpha(mantle, 0.88)
    readonly property color surface: surface0
    readonly property color surfaceHover: surface1
    readonly property color surfaceActive: surface2
    readonly property color overlay: "#40e3eaf1"
    readonly property color lockOverlay: "#73e3eaf1"

    readonly property color border: surface2
    readonly property color borderFocus: accent
    readonly property color borderCritical: critical

    readonly property color text: slate
    readonly property color textMuted: subtext1
    readonly property color textSubtle: subtext0
    readonly property color textDisabled: overlay1
    readonly property color textCritical: critical
    readonly property color textOnAccent: "#ffffff"

    readonly property color selection: Qt.alpha(accent, 0.25)
    readonly property color selectionText: slate

    readonly property int radius: 6
    readonly property int padding: 14

    readonly property int fontSmall: 10
    readonly property int fontNormal: 11
    readonly property int fontMedium: 12
    readonly property int fontLarge: 13
    readonly property int fontInput: 14

    readonly property string displayFont: "Oxanium" // stencilled like Echo Base's hangar markings
    readonly property string iconFont: "MesloLGM Nerd Font Propo"
    readonly property int iconSize: 14

    readonly property int barHeight: 28
    readonly property int barItemHeight: 20

    readonly property string wallpaperDirectory: Quickshell.shellPath("assets/wallpapers")
    readonly property string defaultWallpaper: wallpaperDirectory + "/blue_vader.jpg"
}
