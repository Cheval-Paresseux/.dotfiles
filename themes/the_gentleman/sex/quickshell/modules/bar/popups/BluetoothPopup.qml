import Quickshell.Bluetooth
import QtQuick
import qs.components
import qs.config
import qs.services

PopupPanel {
    id: root

    readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter
    readonly property bool powered: !!adapter && adapter.enabled
    readonly property bool scanning: !!adapter && adapter.discovering
    readonly property var paired: adapter ? adapter.devices.values.filter(d => d.paired) : []
    readonly property var nearby: adapter ? adapter.devices.values.filter(d => !d.paired && d.deviceName !== "") : []

    onVisibleChanged: {
        if (!visible && scanning)
            adapter.discovering = false
    }

    function status(device) {
        switch (device.state) {
        case BluetoothDeviceState.Connecting:
            return "Connecting..."
        case BluetoothDeviceState.Disconnecting:
            return "Disconnecting..."
        }
        if (device.pairing)
            return "Pairing..."
        return device.connected ? "Connected" : "Not connected"
    }

    PopupHeader {
        title: "Close contact"
        showSwitch: root.adapter !== null
        checked: root.powered
        onToggled: root.adapter.enabled = !root.adapter.enabled
    }

    PopupSection {
        title: "Familiar"
        visible: root.powered
    }

    Column {
        width: parent.width
        spacing: 2
        visible: root.powered

        Repeater {
            model: root.paired

            delegate: PopupListItem {
                required property BluetoothDevice modelData

                icon: modelData.connected ? Icons.bluetoothConnected : Icons.bluetooth
                title: modelData.name
                subtitle: root.status(modelData)
                trailing: modelData.batteryAvailable ? Format.percent(modelData.battery) : ""
                active: modelData.connected

                onClicked: mouse => {
                    if (mouse.button === Qt.RightButton)
                        modelData.forget()
                    else if (modelData.connected)
                        modelData.disconnect()
                    else
                        modelData.connect()
                }
            }
        }

        EmptyState {
            visible: root.paired.length === 0
            icon: Icons.bed
            text: "Nobody close yet"
        }
    }

    PopupSection {
        title: "Within reach"
        visible: root.powered

        PopupButton {
            small: true
            icon: Icons.magnify
            text: root.scanning ? "Stop" : "Scan"
            checked: root.scanning
            onClicked: root.adapter.discovering = !root.scanning
        }
    }

    Column {
        width: parent.width
        spacing: 2
        visible: root.powered

        Repeater {
            model: root.nearby

            delegate: PopupListItem {
                required property BluetoothDevice modelData

                icon: Icons.bluetooth
                title: modelData.deviceName
                trailing: modelData.pairing ? "Pairing..." : "Pair"

                onClicked: {
                    modelData.trusted = true
                    modelData.pair()
                }
            }
        }

        Text {
            visible: root.nearby.length === 0
            text: root.scanning ? "Searching..." : "Press Scan to find new devices"
            color: Theme.textDisabled
            font.pixelSize: Theme.fontSmall
        }
    }

    Column {
        width: parent.width
        spacing: 6
        visible: root.powered && BluetoothAgent.request !== null

        Text {
            width: parent.width
            text: {
                const request = BluetoothAgent.request
                switch (request?.kind) {
                case "type":
                    return `Type this code on ${request.name}, then press Enter`
                case "confirm":
                    return `Does ${request.name} show this code?`
                case "authorize":
                    return `Allow ${request.name} to connect?`
                }
                return ""
            }
            color: Theme.text
            font.pixelSize: Theme.fontNormal
            wrapMode: Text.WordWrap
        }

        Text {
            visible: !!BluetoothAgent.request?.code
            text: BluetoothAgent.request?.code ?? ""
            color: Theme.accent
            font.pixelSize: Theme.fontInput
            font.bold: true
            font.letterSpacing: 4
        }

        Row {
            spacing: 6
            visible: BluetoothAgent.request?.kind !== "type"

            PopupButton {
                text: "Pair"
                checked: true
                onClicked: BluetoothAgent.answer(true)
            }

            PopupButton {
                text: "Cancel"
                onClicked: BluetoothAgent.answer(false)
            }
        }
    }

    Text {
        width: parent.width
        topPadding: 4
        text: {
            if (!root.adapter)
                return "No Bluetooth adapter found"
            return root.powered ? "Click: connect / disconnect · Right-click: forget" : "Bluetooth is off"
        }
        color: Theme.textDisabled
        font.pixelSize: Theme.fontSmall
        wrapMode: Text.WordWrap
    }
}
