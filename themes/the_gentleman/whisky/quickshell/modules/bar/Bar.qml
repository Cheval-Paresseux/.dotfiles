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

            // Smoked glass, warmed in the middle by the lamp above the clock
            Rectangle {
                anchors.fill: parent
                color: Theme.background
            }

            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    orientation: Gradient.Horizontal

                    GradientStop { position: 0.25; color: "transparent" }
                    GradientStop { position: 0.5; color: Theme.lampGlow }
                    GradientStop { position: 0.75; color: "transparent" }
                }
            }

            // The brass rail along the counter, polished where the light falls
            Rectangle {
                width: parent.width
                height: 1
                gradient: Gradient {
                    orientation: Gradient.Horizontal

                    GradientStop { position: 0; color: "transparent" }
                    GradientStop { position: 0.2; color: Qt.alpha(Theme.brass, 0.6) }
                    GradientStop { position: 0.5; color: Theme.honey }
                    GradientStop { position: 0.8; color: Qt.alpha(Theme.brass, 0.6) }
                    GradientStop { position: 1; color: "transparent" }
                }
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
                BarDivider { text: "❧" }
                Clock { anchors.verticalCenter: parent.verticalCenter }
                BarDivider { text: "☙" }
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
