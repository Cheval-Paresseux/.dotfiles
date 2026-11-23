import Quickshell
import QtQuick
import qs.components
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
            implicitHeight: Theme.barHeight
            exclusiveZone: Theme.barHeight
            color: "transparent"

            // A leather strap: stitched along its edges, its sections set apart by brass rivets
            Rectangle {
                anchors.fill: parent
                color: Theme.background

                Stitching { inset: 3 }
            }

            Row {
                anchors.left: parent.left
                anchors.leftMargin: 14
                anchors.verticalCenter: parent.verticalCenter
                spacing: 10

                WallpaperButton {}
                AppsButton {}
                BarDivider {}
                WorkspaceList {
                    anchors.verticalCenter: parent.verticalCenter
                    screen: bar.modelData
                }
                BarDivider {}
                NowPlaying {}
            }

            Row {
                anchors.centerIn: parent
                spacing: 12

                CaffeineButton {}
                BarDivider {}
                Clock { anchors.verticalCenter: parent.verticalCenter }
                BarDivider {}
                NotificationButton {}
            }

            Row {
                anchors.right: parent.right
                anchors.rightMargin: 14
                anchors.verticalCenter: parent.verticalCenter
                spacing: 10

                SystemTray {
                    anchors.verticalCenter: parent.verticalCenter
                }
                NetworkButton {}
                BluetoothButton {}
                AudioButton {}
                BrightnessButton {}
                BatteryButton {}
                BarDivider {}
                PowerButton {
                    screen: bar.modelData
                }
            }
        }
    }
}
