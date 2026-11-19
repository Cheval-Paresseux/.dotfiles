pragma Singleton

import Quickshell
import Quickshell.Services.UPower
import QtQuick
import qs.config

Singleton {
    readonly property UPowerDevice device: UPower.displayDevice
    readonly property bool available: device.ready && device.isLaptopBattery
    readonly property real level: device.percentage
    readonly property int state: device.state
    readonly property bool pluggedIn: state === UPowerDeviceState.Charging
        || state === UPowerDeviceState.FullyCharged
        || state === UPowerDeviceState.PendingCharge
    readonly property bool low: UPower.onBattery && level <= 0.15
    readonly property bool warning: UPower.onBattery && level <= 0.3
    readonly property var color: {
        if (low)
            return Theme.critical
        if (warning)
            return Theme.warning
        if (state === UPowerDeviceState.Charging)
            return Theme.success
        return null
    }
    readonly property string icon: Icons.battery(level, pluggedIn)

    readonly property string status: {
        switch (state) {
        case UPowerDeviceState.FullyCharged:
            return "Fully charged"
        case UPowerDeviceState.Charging:
            return "Charging"
        case UPowerDeviceState.PendingCharge:
            return "Plugged in, not charging"
        default:
            return "On battery"
        }
    }

    readonly property string estimate: {
        if (state === UPowerDeviceState.Charging && device.timeToFull > 0)
            return Format.duration(device.timeToFull) + " until full"
        if (state === UPowerDeviceState.Discharging && device.timeToEmpty > 0)
            return Format.duration(device.timeToEmpty) + " remaining"
        return ""
    }
}
