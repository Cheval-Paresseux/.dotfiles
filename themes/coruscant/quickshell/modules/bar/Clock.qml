import Quickshell
import QtQuick
import qs.config

// The centrepiece, set like a watch dial: the time, and below it the date on Galactic Standard Time
Column {
    anchors.verticalCenter: parent.verticalCenter

    SystemClock {
        id: clock

        precision: SystemClock.Minutes
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: Qt.formatDateTime(clock.date, "HH:mm")
        color: Theme.text
        font.family: Theme.displayFont
        font.pixelSize: 16
        font.weight: Font.Medium
        font.letterSpacing: 1
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: Qt.formatDateTime(clock.date, "ddd d MMM").toUpperCase() + " · GST"
        color: Theme.textSubtle
        font.family: Theme.displayFont
        font.pixelSize: 8
        font.letterSpacing: 2.5
    }
}
