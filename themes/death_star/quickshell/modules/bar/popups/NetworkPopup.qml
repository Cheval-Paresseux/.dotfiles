import Quickshell.Io
import Quickshell.Networking
import QtQuick
import qs.components
import qs.config
import qs.services

PopupPanel {
    id: root

    readonly property var device: WifiService.device
    readonly property var current: WifiService.network
    readonly property string interfaceName: device ? device.name : ""

    property var selectedNetwork: null
    property string error: ""

    property string ipAddress: ""
    property string gateway: ""
    property real rxRate: 0
    property real txRate: 0
    property var lastCounters: null

    onVisibleChanged: {
        if (device)
            device.scannerEnabled = visible

        if (visible) {
            refreshDetails()
        } else {
            selectedNetwork = null
            error = ""
            lastCounters = null
            rxRate = 0
            txRate = 0
        }
    }

    onCurrentChanged: {
        if (visible)
            refreshDetails()
    }

    function refreshDetails() {
        if (interfaceName !== "")
            detailsProcess.running = true
    }

    function select(network) {
        error = ""

        if (network.known || network.security === WifiSecurityType.Open) {
            selectedNetwork = null
            network.connect()
            return
        }

        selectedNetwork = network
        passwordInput.text = ""
        passwordInput.forceActiveFocus()
    }

    function submitPassword() {
        if (!selectedNetwork || passwordInput.text === "")
            return
        selectedNetwork.connectWithPsk(passwordInput.text)
        passwordInput.text = ""
        selectedNetwork = null
    }

    function updateRates(output) {
        const [rx, tx] = output.trim().split("\n").map(Number)
        const now = Date.now()
        if (lastCounters) {
            const seconds = (now - lastCounters.time) / 1000
            rxRate = Math.max(0, (rx - lastCounters.rx) / seconds)
            txRate = Math.max(0, (tx - lastCounters.tx) / seconds)
        }
        lastCounters = { time: now, rx: rx, tx: tx }
    }

    Process {
        id: detailsProcess

        command: ["nmcli", "-t", "-f", "IP4.ADDRESS,IP4.GATEWAY", "device", "show", root.interfaceName]
        stdout: StdioCollector {
            onStreamFinished: {
                const fields = {}
                for (const line of this.text.split("\n")) {
                    const separator = line.indexOf(":")
                    if (separator > 0)
                        fields[line.slice(0, separator)] = line.slice(separator + 1)
                }
                root.ipAddress = fields["IP4.ADDRESS[1]"] ?? ""
                root.gateway = fields["IP4.GATEWAY"] ?? ""
            }
        }
    }

    Timer {
        interval: 1000
        repeat: true
        triggeredOnStart: true
        running: root.visible && root.current !== null
        onTriggered: trafficProcess.running = true
    }

    Process {
        id: trafficProcess

        readonly property string statistics: "/sys/class/net/" + root.interfaceName + "/statistics/"

        command: ["cat", statistics + "rx_bytes", statistics + "tx_bytes"]
        stdout: StdioCollector {
            onStreamFinished: root.updateRates(this.text)
        }
    }

    PopupHeader {
        title: "Holonet"
        showSwitch: true
        checked: WifiService.enabled
        onToggled: WifiService.toggle()
    }

    PopupSection {
        title: "Connection"
        visible: root.current !== null

        PopupButton {
            small: true
            text: "Disconnect"
            onClicked: root.current.disconnect()
        }
    }

    Column {
        width: parent.width
        spacing: 3
        visible: root.current !== null

        PopupListItem {
            icon: root.current ? Icons.wifi(root.current.signalStrength) : ""
            title: root.current ? root.current.name : ""
            trailing: root.current ? Format.percent(root.current.signalStrength) : ""
            active: true
        }

        InfoRow {
            label: "IP address"
            value: root.ipAddress || "--"
        }

        InfoRow {
            label: "Gateway"
            value: root.gateway || "--"
        }

        InfoRow {
            label: "Traffic"
            value: "↓ " + Format.rate(root.rxRate) + "   ↑ " + Format.rate(root.txRate)
        }
    }

    PopupSection {
        title: "Channels"
        visible: WifiService.enabled && root.device !== null
    }

    ListView {
        width: parent.width
        height: Math.min(contentHeight, 180)
        visible: WifiService.enabled && count > 0
        clip: true
        spacing: 2
        boundsBehavior: Flickable.StopAtBounds
        model: WifiService.otherNetworks

        delegate: PopupListItem {
            required property var modelData

            width: ListView.view.width
            icon: Icons.wifi(modelData.signalStrength)
            title: modelData.name
            trailing: modelData.stateChanging ? "Connecting..." : (modelData.known ? "Saved" : "")
            trailingIcon: !modelData.known && modelData.security !== WifiSecurityType.Open ? Icons.lockOutline : ""
            highlighted: root.selectedNetwork === modelData

            onClicked: mouse => {
                if (mouse.button !== Qt.RightButton)
                    root.select(modelData)
                else if (modelData.known)
                    modelData.forget()
            }

            Connections {
                target: modelData

                function onConnectionFailed(reason) {
                    root.error = "Could not connect to " + modelData.name
                        + " (" + ConnectionFailReason.toString(reason) + ")"
                }
            }
        }
    }

    Column {
        width: parent.width
        spacing: 6
        visible: root.selectedNetwork !== null

        Text {
            width: parent.width
            text: root.selectedNetwork ? "Password for " + root.selectedNetwork.name : ""
            color: Theme.text
            font.pixelSize: Theme.fontNormal
            elide: Text.ElideRight
        }

        Row {
            width: parent.width
            spacing: 6

            Rectangle {
                width: parent.width - connectButton.width - parent.spacing
                height: 28
                radius: Theme.radius
                color: Theme.surface
                border.color: passwordInput.activeFocus ? Theme.borderFocus : Theme.border

                TextInput {
                    id: passwordInput

                    anchors.fill: parent
                    anchors.leftMargin: 8
                    anchors.rightMargin: 8
                    verticalAlignment: TextInput.AlignVCenter
                    echoMode: TextInput.Password
                    color: Theme.text
                    selectionColor: Theme.selection
                    font.pixelSize: Theme.fontNormal
                    clip: true

                    Keys.onReturnPressed: root.submitPassword()
                    Keys.onEnterPressed: root.submitPassword()

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        visible: passwordInput.text === ""
                        text: "Password"
                        color: Theme.textDisabled
                        font.pixelSize: Theme.fontNormal
                    }
                }
            }

            PopupButton {
                id: connectButton

                text: "Connect"
                onClicked: root.submitPassword()
            }
        }
    }

    Text {
        width: parent.width
        topPadding: 4
        visible: root.selectedNetwork === null
        text: {
            if (root.error !== "")
                return root.error
            if (!root.device)
                return "No transmitter found"
            if (!WifiService.enabled)
                return "The Holonet is offline"
            return "Click: connect · Right-click a saved network: forget"
        }
        color: root.error !== "" ? Theme.textCritical : Theme.textDisabled
        font.pixelSize: Theme.fontSmall
        wrapMode: Text.WordWrap
    }
}
