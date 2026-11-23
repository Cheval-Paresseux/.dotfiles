pragma Singleton

import Quickshell
import QtQuick

// Nerd Font Material Design glyphs (ttf-meslo-nerd), drawn with Theme.iconFont: the objects of the bedroom
Singleton {
    readonly property string wallpaper: glyph(0xF0FD2) // the bed: set the scene
    readonly property string apps: glyph(0xF13B5) // lipstick
    readonly property string handcuffs: glyph(0xF113E)
    readonly property string mask: glyph(0xF1023)
    readonly property string bed: glyph(0xF0FD4)
    readonly property string wine: glyph(0xF0876)
    readonly property string heart: glyph(0xF02D1)
    readonly property string heartOutline: glyph(0xF02D5)

    readonly property string power: glyph(0xF0425)
    readonly property string exit: glyph(0xF081C) // the door out
    readonly property string lock: glyph(0xF10AF)
    readonly property string sleep: glyph(0xF0904)
    readonly property string logout: glyph(0xF0343)
    readonly property string restart: glyph(0xF0709)

    // Power profiles: gentle, steady, wild
    readonly property string powerSaver: glyph(0xF05E2)
    readonly property string balanced: glyph(0xF05F6)
    readonly property string performance: glyph(0xF0238)

    // Secrets: sealed messages, and closed eyes for Do Not Disturb
    readonly property string bell: glyph(0xF0FCD)
    readonly property string bellOutline: glyph(0xF01F1)
    readonly property string bellOff: glyph(0xF0209)

    readonly property string bluetooth: glyph(0xF00AF)
    readonly property string bluetoothConnected: glyph(0xF00B1)
    readonly property string bluetoothOff: glyph(0xF00B2)

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

    // Candlelight, a night light, the lights on
    readonly property string brightnessLow: glyph(0xF05E2)
    readonly property string brightnessMedium: glyph(0xF1A4C)
    readonly property string brightnessHigh: glyph(0xF06E8)

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

    function brightness(level) {
        if (level < 0.34)
            return brightnessLow
        return level < 0.67 ? brightnessMedium : brightnessHigh
    }

    function battery(level, charging) {
        const index = Math.max(0, Math.min(10, Math.round(level * 10)))
        return charging ? batteryChargingLevels[index] : batteryLevels[index]
    }
}
