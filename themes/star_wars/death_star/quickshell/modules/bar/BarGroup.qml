import QtQuick
import QtQuick.Shapes
import qs.config

// Plate shaped like the trapezoid viewports of the station's bridge
Item {
    id: root

    default property alias content: row.data
    readonly property real slant: height * 0.6

    implicitWidth: row.implicitWidth + 2 * slant + 8
    implicitHeight: Theme.barHeight

    Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            fillColor: Theme.surface
            strokeColor: Theme.border
            strokeWidth: 1
            startX: 0
            startY: root.height

            PathLine { x: root.slant; y: 0 }
            PathLine { x: root.width - root.slant; y: 0 }
            PathLine { x: root.width; y: root.height }
        }
    }

    Row {
        id: row

        anchors.centerIn: parent
        spacing: 10
    }
}
