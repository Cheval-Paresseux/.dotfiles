import QtQuick
import qs.config

Rectangle {
    id: root

    property bool checked: false

    signal toggled()

    implicitWidth: 30
    implicitHeight: 16
    radius: Theme.radius
    color: checked ? Theme.accent : Theme.surface
    border.width: 1
    border.color: checked ? Theme.accent : Theme.border

    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        x: root.checked ? parent.width - width - 3 : 3
        width: 10
        height: 10
        radius: Theme.radius
        color: root.checked ? Theme.textOnAccent : Theme.textSubtle

        Behavior on x {
            NumberAnimation { duration: 100 }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.toggled()
    }
}
