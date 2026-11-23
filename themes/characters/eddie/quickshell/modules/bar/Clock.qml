import Quickshell
import QtQuick
import qs.config

// Dated like an estate's letterhead: the day in serif italics, the hour in serif figures
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
        font.pixelSize: Theme.fontLarge
        font.italic: true
    }

    Text {
        id: time

        text: Qt.formatDateTime(clock.date, "HH:mm")
        color: Theme.text
        font.family: Theme.displayFont
        font.pixelSize: 17
        font.weight: Font.DemiBold
    }
}
