pragma Singleton

import Quickshell
import QtQuick

// Nerd Font glyphs (ttf-meslo-nerd), drawn with Theme.iconFont.
// The Vader helmet, TIE fighter and AT-AT are SVGs in assets/icons, drawn with SvgIcon.
Singleton {
    readonly property string wallpaper: glyph(0xF08D8)
    readonly property string apps: glyph(0xF1D1)
    readonly property string coffee: glyph(0xF0208)
    readonly property string coffeeOutline: glyph(0xF06D1)

    readonly property string shutdown: glyph(0xEDDC)
    readonly property string lock: glyph(0xF099D)
    readonly property string sleep: glyph(0xF0904)
    readonly property string logout: glyph(0xF0A48)
    readonly property string restart: glyph(0xF0709)

    readonly property string powerSaver: glyph(0xF032A)
    readonly property string balanced: glyph(0xF05D1)
    readonly property string performance: glyph(0xF0238)

    readonly property string bell: glyph(0xF0909)
    readonly property string bellOutline: glyph(0xF1720)
    readonly property string bellOff: glyph(0xF1721)

    readonly property string droid: glyph(0xF1A1A)
    readonly property string droidConnected: glyph(0xF0B46)
    readonly property string droidOff: glyph(0xF16A7)

    readonly property string wifiOff: glyph(0xF05AA)
    readonly property string wifiDisconnected: glyph(0xF092F)
    readonly property var wifiLevels: [0xF091F, 0xF0922, 0xF0925, 0xF0928].map(glyph)

    readonly property string speaker: glyph(0xF04C3)
    readonly property string headphones: glyph(0xF02CB)
    readonly property string microphone: glyph(0xF036C)
    readonly property string microphoneOff: glyph(0xF036D)
    readonly property string volumeOff: glyph(0xF0581)
    readonly property string volumeLow: glyph(0xF057F)
    readonly property string volumeMedium: glyph(0xF0580)
    readonly property string volumeHigh: glyph(0xF057E)

    readonly property string lockOutline: glyph(0xF0341)
    readonly property string magnify: glyph(0xF0349)

    readonly property var batteryLevels: [
        0xF008E, 0xF007A, 0xF007B, 0xF007C, 0xF007D, 0xF007E,
        0xF007F, 0xF0080, 0xF0081, 0xF0082, 0xF0079
    ].map(glyph)
    readonly property var batteryChargingLevels: [
        0xF089C, 0xF089C, 0xF0086, 0xF0087, 0xF0088, 0xF089D,
        0xF0089, 0xF089E, 0xF008A, 0xF008B, 0xF0085
    ].map(glyph)

    function glyph(codepoint) {
        return String.fromCodePoint(codepoint)
    }

    function wifi(strength) {
        return wifiLevels[Math.max(0, Math.min(3, Math.floor(strength * 4)))]
    }

    function volume(level, muted) {
        if (muted || level <= 0)
            return volumeOff
        if (level < 0.34)
            return volumeLow
        return level < 0.67 ? volumeMedium : volumeHigh
    }

    function battery(level, charging) {
        const index = Math.max(0, Math.min(10, Math.round(level * 10)))
        return charging ? batteryChargingLevels[index] : batteryLevels[index]
    }
}
