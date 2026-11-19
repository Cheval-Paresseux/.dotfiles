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
            implicitHeight: Theme.barHeight
            exclusiveZone: Theme.barHeight
            color: Theme.background

            // Hull seam along the top edge
            Rectangle {
                anchors.top: parent.top
                width: parent.width
                height: 1
                color: Theme.blood
                z: 1
            }

            BarGroup {
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.verticalCenter: parent.verticalCenter

                WallpaperButton {}
                AppsButton {}
                WorkspaceList {
                    anchors.verticalCenter: parent.verticalCenter
                    screen: bar.modelData
                }
            }

            BarGroup {
                anchors.centerIn: parent

                CaffeineButton {}
                Clock {
                    anchors.verticalCenter: parent.verticalCenter
                }
                NotificationButton {}
                SystemTray {
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            BarGroup {
                anchors.right: parent.right
                anchors.rightMargin: 4
                anchors.verticalCenter: parent.verticalCenter

                NetworkButton {}
                BluetoothButton {}
                AudioButton {}
                BatteryButton {}
                PowerButton {
                    screen: bar.modelData
                }
            }
        }
    }
}
