import Quickshell
import QtQuick
import qs.config

Text {
    SystemClock {
        id: clock

        precision: SystemClock.Minutes
    }

    text: Qt.formatDateTime(clock.date, "HH:mm · ddd d MMM").toUpperCase()
    color: Theme.text
    font.family: Theme.displayFont
    font.pixelSize: Theme.fontMedium
    font.bold: true
    font.letterSpacing: 2
}
