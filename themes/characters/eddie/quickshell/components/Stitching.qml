import QtQuick
import QtQuick.Shapes
import qs.config

// Saddle stitching: a dashed seam running just inside the edge of a piece of leather
Shape {
    id: root

    property int inset: 4

    anchors.fill: parent

    ShapePath {
        strokeColor: Theme.leather
        strokeWidth: 1
        strokeStyle: ShapePath.DashLine
        dashPattern: [3, 2]
        fillColor: "transparent"

        PathRectangle {
            x: root.inset + 0.5
            y: root.inset + 0.5
            width: root.width - root.inset * 2 - 1
            height: root.height - root.inset * 2 - 1
            radius: Math.max(0, Theme.radius - root.inset / 2)
        }
    }
}
