pragma Singleton

import Quickshell
import Quickshell.Networking
import QtQuick

Singleton {
    readonly property bool enabled: Networking.wifiEnabled
    readonly property var device: Networking.devices.values.find(d => d.type === DeviceType.Wifi) ?? null
    readonly property var network: device?.networks.values.find(n => n.connected) ?? null
    readonly property var otherNetworks: device
        ? device.networks.values
            .filter(n => !n.connected)
            .sort((a, b) => b.signalStrength - a.signalStrength)
        : []

    function toggle() {
        Networking.wifiEnabled = !Networking.wifiEnabled
    }
}
