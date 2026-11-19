import Quickshell
import QtQuick
import qs.config

Text {
    SystemClock {
        id: clock

        precision: SystemClock.Minutes
    }

    text: Qt.formatDateTime(clock.date, "dddd d MMMM yyyy · HH:mm")
    color: Theme.text
    font.pixelSize: Theme.fontMedium
    font.bold: true
}
