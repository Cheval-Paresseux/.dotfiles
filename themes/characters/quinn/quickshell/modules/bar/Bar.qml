import Quickshell
import QtQuick
import QtQuick.Shapes
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

            // A black leather strap, stitched in neon along both edges
            Shape {
                anchors.fill: parent

                ShapePath {
                    id: stitch

                    strokeColor: Qt.alpha(Theme.neon, 0.45)
                    strokeWidth: 1
                    strokeStyle: ShapePath.DashLine
                    dashPattern: [4, 3]
                    fillColor: "transparent"
                    startX: 0
                    startY: 4

                    PathLine { x: bar.width; y: 4 }
                }

                ShapePath {
                    strokeColor: stitch.strokeColor
                    strokeWidth: 1
                    strokeStyle: ShapePath.DashLine
                    dashPattern: stitch.dashPattern
                    fillColor: "transparent"
                    startX: 0
                    startY: Theme.barHeight - 4

                    PathLine { x: bar.width; y: Theme.barHeight - 4 }
                }
            }

            Row {
                anchors.left: parent.left
                anchors.leftMargin: 16
                anchors.verticalCenter: parent.verticalCenter
                spacing: 12

                WallpaperButton {}
                AppsButton {}
                BarRing {}
                WorkspaceList {
                    anchors.verticalCenter: parent.verticalCenter
                    screen: bar.modelData
                }
            }

            Row {
                anchors.centerIn: parent
                spacing: 14

                CaffeineButton {}
                BarRing {}
                Clock {
                    anchors.verticalCenter: parent.verticalCenter
                }
                BarRing {}
                NotificationButton {}
            }

            Row {
                anchors.right: parent.right
                anchors.rightMargin: 16
                anchors.verticalCenter: parent.verticalCenter
                spacing: 12

                SystemTray {
                    anchors.verticalCenter: parent.verticalCenter
                }
                NetworkButton {}
                BluetoothButton {}
                AudioButton {}
                BrightnessButton {}
                BatteryButton {}
                BarRing {}
                PowerButton {
                    screen: bar.modelData
                }
            }
        }
    }
}
