import QtQuick
import qs.config

// A faint object from the lounge above a short line in italics, shown when a list is empty
Column {
    id: root

    required property string icon
    property string text

    width: parent ? parent.width : 0
    topPadding: 6
    bottomPadding: 6
    spacing: 6

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: root.icon
        color: Theme.surfaceActive
        font.family: Theme.iconFont
        font.pixelSize: 44
    }

    Text {
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        text: root.text
        color: Theme.textDisabled
        font.family: Theme.displayFont
        font.variableAxes: Theme.displayAxes
        font.pixelSize: Theme.fontMedium
        font.italic: true
    }
}
