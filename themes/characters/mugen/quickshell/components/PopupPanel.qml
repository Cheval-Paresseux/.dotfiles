import Quickshell
import QtQuick
import qs.config

PopupWindow {
    id: root

    default property alias content: column.data
    property alias spacing: column.spacing

    signal keyPressed(var event)

    implicitWidth: 300
    readonly property int shadow: 4

    implicitHeight: column.implicitHeight + Theme.padding * 2 + shadow

    color: "transparent"
    grabFocus: true

    function toggle() {
        root.visible = !root.visible
    }

    Rectangle {
        x: root.shadow
        y: root.shadow
        width: parent.width - root.shadow
        height: parent.height - root.shadow
        color: Theme.text
    }

    Rectangle {
        width: parent.width - root.shadow
        height: parent.height - root.shadow
        color: Theme.popupBackground
        border.color: Theme.text
        border.width: 1
        radius: Theme.radius
        focus: true

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
