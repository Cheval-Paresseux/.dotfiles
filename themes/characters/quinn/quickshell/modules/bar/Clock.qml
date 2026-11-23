import Quickshell
import QtQuick
import qs.config

// Set like a magazine cover: the day in spaced capitals, the hour in large italics
Row {
    spacing: 10

    SystemClock {
        id: clock

        precision: SystemClock.Minutes
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        text: Qt.formatDateTime(clock.date, "dddd d MMMM").toUpperCase()
        color: Theme.textSubtle
        font.pixelSize: Theme.fontSmall
        font.letterSpacing: 3
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        text: Qt.formatDateTime(clock.date, "HH:mm")
        color: Theme.text
        font.family: Theme.displayFont
        font.variableAxes: Theme.displayAxes
        font.pixelSize: 21
        font.italic: true
    }
}
