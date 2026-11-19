import Quickshell
import QtQuick
import qs.config

Text {
    SystemClock {
        id: clock

        precision: SystemClock.Minutes
    }

    text: Qt.formatDateTime(clock.date, "HH:mm · dddd d MMMM")
    color: Theme.text
    font.family: Theme.displayFont
    font.pixelSize: Theme.fontMedium
    font.bold: true
}
