import Quickshell
import QtQuick
import qs.config

Text {
    SystemClock {
        id: clock

        precision: SystemClock.Minutes
    }

    text: Qt.formatDateTime(clock.date, "ddd d MMM · HH:mm").toUpperCase()
    color: Theme.text
    font.family: Theme.displayFont
    font.pixelSize: Theme.fontMedium
    font.bold: true
    font.letterSpacing: 1.5
}
