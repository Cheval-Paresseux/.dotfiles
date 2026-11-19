import QtQuick
import qs.config

Item {
    id: root

    property string title
    default property alias trailing: trailingRow.data

    width: parent ? parent.width : 0
    implicitHeight: 28

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: 4
        width: parent.width
        height: 1
        color: Theme.border
    }

    Text {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        text: root.title.toUpperCase()
        color: Theme.accent
        font.family: Theme.displayFont
        font.pixelSize: Theme.fontSmall
        font.weight: Font.Medium
        font.letterSpacing: 2
    }

    Row {
        id: trailingRow

        anchors.right: parent.right
        anchors.bottom: parent.bottom
        spacing: 6
    }
}
