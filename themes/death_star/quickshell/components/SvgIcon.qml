import Quickshell
import QtQuick
import QtQuick.Effects

// One-colour icon from assets/icons (drawn in white), tinted with any colour
Item {
    id: root

    required property string name
    property color color
    property int size: 16

    implicitWidth: size
    implicitHeight: size

    Image {
        id: image

        anchors.fill: parent
        source: root.name ? Quickshell.shellPath("assets/icons/" + root.name + ".svg") : ""
        sourceSize: Qt.size(root.size * 2, root.size * 2)
        visible: false
    }

    MultiEffect {
        anchors.fill: parent
        source: image
        colorization: 1
        colorizationColor: root.color
    }
}
