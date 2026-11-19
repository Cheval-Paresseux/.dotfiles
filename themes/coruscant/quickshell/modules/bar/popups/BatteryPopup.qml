import Quickshell.Services.UPower
import QtQuick
import qs.components
import qs.config
import qs.services

PopupPanel {
    id: root

    readonly property UPowerDevice device: BatteryService.device
    readonly property var profiles: [
        { label: "Austerity", icon: Icons.powerSaver, value: PowerProfile.PowerSaver, color: Theme.success },
        { label: "Stable", icon: Icons.balanced, value: PowerProfile.Balanced, color: Theme.info },
        { label: "Growth", icon: Icons.performance, value: PowerProfile.Performance, color: Theme.warning }
    ].filter(profile => profile.value !== PowerProfile.Performance || PowerProfiles.hasPerformanceProfile)

    PopupHeader {
        title: "Treasury"
        detail: BatteryService.status
    }

    Item {
        width: parent.width
        height: 40

        Text {
            id: batteryIcon

            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            text: BatteryService.icon
            color: BatteryService.color ?? Theme.text
            font.family: Theme.iconFont
            font.pixelSize: 28
        }

        Column {
            anchors.left: batteryIcon.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2

            Text {
                text: Format.percent(BatteryService.level)
                color: Theme.text
                font.pixelSize: 18
                font.bold: true
            }

            Text {
                visible: text !== ""
                text: BatteryService.estimate
                color: Theme.textSubtle
                font.pixelSize: Theme.fontSmall
            }
        }
    }

    PopupSection {
        title: "Details"
    }

    Column {
        width: parent.width
        spacing: 3

        InfoRow {
            visible: root.device.changeRate !== 0
            label: BatteryService.state === UPowerDeviceState.Charging ? "Charge rate" : "Power draw"
            value: Math.abs(root.device.changeRate).toFixed(1) + " W"
        }

        InfoRow {
            visible: root.device.energyCapacity > 0
            label: "Energy"
            value: root.device.energy.toFixed(1) + " / " + root.device.energyCapacity.toFixed(1) + " Wh"
        }

        InfoRow {
            visible: root.device.healthSupported
            label: "Health"
            value: Math.round(root.device.healthPercentage) + "%"
        }
    }

    PopupSection {
        title: "Power profile"
    }

    Row {
        id: profileRow

        width: parent.width
        spacing: -1

        Repeater {
            model: root.profiles

            delegate: PopupButton {
                required property var modelData

                width: (profileRow.width + root.profiles.length - 1) / root.profiles.length
                icon: modelData.icon
                text: modelData.label
                accentColor: modelData.color
                checked: PowerProfiles.profile === modelData.value
                onClicked: PowerProfiles.profile = modelData.value
            }
        }
    }
}
