import Quickshell
import QtQuick
import QtQuick.Shapes
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
        border.color: Qt.alpha(Theme.neon, 0.3)
        border.width: 1
        radius: Theme.radius
        focus: true

        // Stitched like leather, just inside the edge
        Shape {
            anchors.fill: parent
            anchors.margins: 4

            ShapePath {
                strokeColor: Qt.alpha(Theme.neon, 0.25)
                strokeWidth: 1
                strokeStyle: ShapePath.DashLine
                dashPattern: [4, 3]
                fillColor: "transparent"

                PathRectangle {
                    width: root.width - 8
                    height: root.height - 8
                    radius: Theme.radius - 4
                }
            }
        }

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
