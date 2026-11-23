import Quickshell
import QtQuick
import qs.config

// The hour in serif figures, the day in italics, as on a menu card
Row {
    spacing: 8

    SystemClock {
        id: clock

        precision: SystemClock.Minutes
    }

    Text {
        anchors.baseline: time.baseline
        text: Qt.formatDateTime(clock.date, "dddd d MMMM")
        color: Theme.textSubtle
        font.family: Theme.displayFont
        font.variableAxes: Theme.displayAxes
        font.pixelSize: Theme.fontLarge
        font.italic: true
    }

    Text {
        id: time

        text: Qt.formatDateTime(clock.date, "HH:mm")
        color: Theme.honey
        font.family: Theme.displayFont
        font.variableAxes: Theme.displayAxes
        font.pixelSize: 18
        font.weight: Font.Medium
    }
}
