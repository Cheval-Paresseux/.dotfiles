import Quickshell.Services.Pipewire
import QtQuick
import qs.components
import qs.config

PopupPanel {
    id: root

    readonly property var devices: Pipewire.nodes.values.filter(node => node.audio && !node.isStream)
    readonly property var sinks: devices.filter(node => node.isSink)
    readonly property var sources: devices.filter(node => !node.isSink)

    function nodeName(node) {
        return node.description || node.nickname || node.name
    }

    PopupHeader {
        title: "The gramophone"
    }

    PopupSection {
        title: "Output"
    }

    VolumeControl {
        node: Pipewire.defaultAudioSink
    }

    Column {
        width: parent.width
        spacing: 2
        visible: root.sinks.length > 1

        Repeater {
            model: root.sinks

            delegate: PopupListItem {
                required property PwNode modelData

                icon: root.nodeName(modelData).toLowerCase().includes("head") ? Icons.headphones : Icons.speaker
                title: root.nodeName(modelData)
                active: Pipewire.defaultAudioSink === modelData
                onClicked: Pipewire.preferredDefaultAudioSink = modelData
            }
        }
    }

    PopupSection {
        title: "Input"
    }

    VolumeControl {
        node: Pipewire.defaultAudioSource
        input: true
        visible: Pipewire.defaultAudioSource !== null
    }

    Column {
        width: parent.width
        spacing: 2
        visible: root.sources.length > 1

        Repeater {
            model: root.sources

            delegate: PopupListItem {
                required property PwNode modelData

                icon: Icons.microphone
                title: root.nodeName(modelData)
                active: Pipewire.defaultAudioSource === modelData
                onClicked: Pipewire.preferredDefaultAudioSource = modelData
            }
        }
    }

    Text {
        visible: Pipewire.defaultAudioSource === null
        text: "No input device"
        color: Theme.textDisabled
        font.pixelSize: Theme.fontSmall
    }
}
