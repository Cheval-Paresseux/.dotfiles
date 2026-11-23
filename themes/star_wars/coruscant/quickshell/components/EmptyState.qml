import QtQuick
import qs.config

// Faint emblem above a short message, shown when a list is empty
Column {
    id: root

    required property string icon
    property string text

    width: parent ? parent.width : 0
    topPadding: 6
    bottomPadding: 6
    spacing: 8

    SvgIcon {
        anchors.horizontalCenter: parent.horizontalCenter
        name: root.icon
        size: 56
        color: Theme.surfaceActive
    }

    Text {
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        text: root.text
        color: Theme.textDisabled
        font.pixelSize: Theme.fontSmall
    }
}
