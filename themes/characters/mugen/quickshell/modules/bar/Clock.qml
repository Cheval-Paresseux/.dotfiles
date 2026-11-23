import Quickshell
import QtQuick
import qs.config

// The weekday's kanji in red (日月火水木金土: sun, moon, fire, water, wood, gold, earth), then the date and the hour
Row {
    spacing: 8

    SystemClock {
        id: clock

        precision: SystemClock.Minutes
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        text: "日月火水木金土"[clock.date.getDay()]
        color: Theme.accent
        font.family: Theme.kanjiFont
        font.pixelSize: Theme.fontLarge + 2
        font.weight: Font.Black
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        text: Qt.formatDateTime(clock.date, "d MMMM  ·  HH:mm")
        color: Theme.text
        font.family: Theme.kanjiFont
        font.pixelSize: Theme.fontMedium
        font.weight: Font.Bold
    }
}
