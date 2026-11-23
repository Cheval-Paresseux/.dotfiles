import Quickshell
import QtQuick
import qs.config

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar

            required property ShellScreen modelData

            screen: modelData
            anchors {
                left: true
                right: true
                bottom: true
            }
            margins {
                left: Theme.barMargin
                right: Theme.barMargin
                bottom: Theme.barMargin
            }
            implicitHeight: Theme.barHeight
            exclusiveZone: Theme.barHeight
            color: "transparent"

            // Floats over the water like a fallen branch
            Rectangle {
                anchors.fill: parent
                radius: height / 2
                color: Theme.background
                border.width: 1
                border.color: Theme.border
            }

            Row {
                anchors.left: parent.left
                anchors.leftMargin: 16
                anchors.verticalCenter: parent.verticalCenter
                spacing: 8

                WallpaperButton {}
                AppsButton {}
                WorkspaceList {
                    anchors.verticalCenter: parent.verticalCenter
                    screen: bar.modelData
                }
            }

            CaffeineButton {
                anchors.right: clock.left
                anchors.rightMargin: 12
            }

            Clock {
                id: clock

                anchors.centerIn: parent
            }

            NotificationButton {
                id: notifications

                anchors.left: clock.right
                anchors.leftMargin: 12
            }

            SystemTray {
                anchors.left: notifications.right
                anchors.leftMargin: 16
                anchors.verticalCenter: parent.verticalCenter
            }

            Row {
                anchors.right: parent.right
                anchors.rightMargin: 16
                anchors.verticalCenter: parent.verticalCenter
                spacing: 8

                NetworkButton {}
                BluetoothButton {}
                AudioButton {}
                BrightnessButton {}
                BatteryButton {}
                PowerButton {
                    screen: bar.modelData
                }
            }
        }
    }
}
