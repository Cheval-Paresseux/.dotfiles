import Quickshell
import Quickshell.Hyprland
import QtQuick
import qs.config

// Workspaces are tumblers on the counter: each fills with the windows it holds,
// the one you are in is poured amber and catches the light
Row {
    id: root

    required property ShellScreen screen
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(screen)

    spacing: 5

    Repeater {
        model: Hyprland.workspaces

        delegate: Item {
            id: workspace

            required property HyprlandWorkspace modelData
            readonly property bool active: modelData.active
            readonly property int windows: modelData.toplevels.values.length

            visible: modelData.id > 0 && modelData.monitor === root.monitor
            width: 16
            height: 20

            // The glass: open at the top, heavy at the base
            Rectangle {
                id: glass

                anchors.fill: parent
                anchors.bottomMargin: 2
                color: "transparent"
                topLeftRadius: 1
                topRightRadius: 1
                bottomLeftRadius: 4
                bottomRightRadius: 4
                border.width: 1
                border.color: workspace.active
                    ? Theme.honey
                    : Qt.alpha(Theme.subtext0, mouseArea.containsMouse ? 0.8 : 0.4)
            }

            Rectangle {
                anchors.left: glass.left
                anchors.right: glass.right
                anchors.bottom: glass.bottom
                anchors.margins: 2
                height: workspace.active
                    ? glass.height - 6
                    : Math.min(glass.height - 6, 3 * workspace.windows)
                bottomLeftRadius: 2
                bottomRightRadius: 2
                gradient: Gradient {
                    GradientStop { position: 0; color: workspace.active ? Theme.honey : Qt.alpha(Theme.amber, 0.45) }
                    GradientStop { position: 1; color: workspace.active ? Theme.brass : Qt.alpha(Theme.brass, 0.45) }
                }

                Behavior on height {
                    NumberAnimation { duration: 400; easing.type: Easing.OutCubic }
                }
            }

            // The heavy base of the tumbler
            Rectangle {
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - 4
                height: 2
                radius: 1
                color: glass.border.color
            }

            MouseArea {
                id: mouseArea

                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: workspace.modelData.activate()
            }
        }
    }
}
