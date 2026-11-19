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
            color: "transparent"

            // Polished onyx, a shade lighter at the top
            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop { position: 0; color: Qt.alpha(Theme.mantle, 0.96) }
                    GradientStop { position: 1; color: Qt.alpha(Theme.crust, 0.96) }
                }
            }

            // A gold hairline along the top edge, brightest in the middle and fading out at the ends
            Rectangle {
                width: parent.width
                height: 1
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0; color: "transparent" }
                    GradientStop { position: 0.2; color: Qt.alpha(Theme.accent, 0.7) }
                    GradientStop { position: 0.5; color: Theme.champagne }
                    GradientStop { position: 0.8; color: Qt.alpha(Theme.accent, 0.7) }
                    GradientStop { position: 1; color: "transparent" }
                }
            }

            Row {
                anchors.left: parent.left
                anchors.leftMargin: 16
                anchors.verticalCenter: parent.verticalCenter
                spacing: 14

                AppsButton {}
                WallpaperButton {}
                BarDivider {}
                WorkspaceList {
                    anchors.verticalCenter: parent.verticalCenter
                    screen: bar.modelData
                }
                BarDivider {}
                MarketTicker {
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Row {
                anchors.centerIn: parent
                spacing: 14

                CaffeineButton {
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "◆"
                    color: Theme.accent
                    font.pixelSize: 7
                }
                Clock {}
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "◆"
                    color: Theme.accent
                    font.pixelSize: 7
                }
                NotificationButton {
                    anchors.verticalCenter: parent.verticalCenter
                }
                SystemTray {
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Row {
                anchors.right: parent.right
                anchors.rightMargin: 16
                anchors.verticalCenter: parent.verticalCenter
                spacing: 14

                NetworkButton {}
                BluetoothButton {}
                AudioButton {}
                BatteryButton {}
                BarDivider {}
                PowerButton {
                    screen: bar.modelData
                }
            }
        }
    }
}
