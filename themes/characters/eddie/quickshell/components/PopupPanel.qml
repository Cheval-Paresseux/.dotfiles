import Quickshell
import QtQuick
import qs.config

PopupWindow {
    id: root

    default property alias content: column.data
    property alias spacing: column.spacing

    signal keyPressed(var event)

    implicitWidth: 300
    implicitHeight: column.implicitHeight + Theme.padding * 2

    color: "transparent"
    grabFocus: true

    function toggle() {
        root.visible = !root.visible
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.popupBackground
        border.color: Theme.border
        border.width: 1
        radius: Theme.radius
        focus: true

        Stitching {}

        Keys.onPressed: event => {
            if (event.key === Qt.Key_Escape) {
                root.visible = false
                event.accepted = true
            } else {
                root.keyPressed(event)
            }
        }

        Column {
            id: column

            x: Theme.padding
            y: Theme.padding
            width: parent.width - Theme.padding * 2
            spacing: 8
        }
    }
}
