import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls
import qs.components
import qs.config
import qs.services

Item {
    id: root

    property PwNode node
    property bool input: false
    readonly property bool ready: !!(node && node.ready && node.audio)
    readonly property bool muted: !ready || node.audio.muted

    width: parent ? parent.width : 0
    implicitHeight: 28

    PwObjectTracker {
        objects: root.node ? [root.node] : []
    }

    PopupButton {
        id: muteButton

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        width: 28
        enabled: root.ready
        icon: root.input
            ? (root.muted ? Icons.microphoneOff : Icons.microphone)
            : (root.ready ? Icons.volume(root.node.audio.volume, root.muted) : Icons.volumeOff)
        onClicked: root.node.audio.muted = !root.node.audio.muted
    }

    Slider {
        id: slider

        anchors.left: muteButton.right
        anchors.leftMargin: 10
        anchors.right: percent.left
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        height: 20
        from: 0
        to: 1
        stepSize: 0.01
        enabled: root.ready
        value: root.ready ? root.node.audio.volume : 0

        onMoved: {
            root.node.audio.volume = value
            root.node.audio.muted = false
        }

        background: Rectangle {
            x: slider.leftPadding
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            width: slider.availableWidth
            height: 4
            color: Theme.surface

            Rectangle {
                width: slider.visualPosition * parent.width
                height: parent.height
                color: root.muted ? Theme.textDisabled : Theme.accent
            }
        }

        handle: Rectangle {
            x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
            y: slider.topPadding + slider.availableHeight / 2 - height / 2
            width: 8
            height: 16
            color: slider.pressed ? Theme.text : Theme.accent
        }
    }

    Text {
        id: percent

        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        width: 34
        horizontalAlignment: Text.AlignRight
        text: root.ready ? Format.percent(root.node.audio.volume) : "--"
        color: Theme.textMuted
        font.pixelSize: Theme.fontNormal
    }
}
