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
        gradient: Gradient {
            orientation: Gradient.Horizontal

            GradientStop { position: 0; color: Qt.alpha(Theme.neon, 0.5) }
            GradientStop { position: 1; color: "transparent" }
        }
    }

    Text {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        text: root.title.toUpperCase()
        color: Theme.accent
        font.pixelSize: Theme.fontSmall
        font.bold: true
        font.letterSpacing: 3
    }

    Row {
        id: trailingRow

        anchors.right: parent.right
        anchors.bottom: parent.bottom
        spacing: 6
    }
}
