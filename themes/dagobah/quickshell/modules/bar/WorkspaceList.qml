import Quickshell
import Quickshell.Hyprland
import QtQuick
import qs.config

// Workspaces as fireflies: a dot each, the active one stretched and lit
Row {
    id: root

    required property ShellScreen screen
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(screen)

    spacing: 6

    Repeater {
        model: Hyprland.workspaces

        delegate: Rectangle {
            id: workspace

            required property HyprlandWorkspace modelData

            anchors.verticalCenter: parent.verticalCenter
            visible: modelData.id > 0 && modelData.monitor === root.monitor
            width: modelData.active ? 22 : 9
            height: 9
            radius: height / 2
            color: modelData.active ? Theme.accent : (mouseArea.containsMouse ? Theme.subtext0 : Theme.overlay0)

            Behavior on width {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.OutCubic
                }
            }

            MouseArea {
                id: mouseArea

                anchors.fill: parent
                anchors.margins: -3
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: workspace.modelData.activate()
            }
        }
    }
}
