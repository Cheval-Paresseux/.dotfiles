import Quickshell
import Quickshell.Hyprland
import QtQuick
import qs.config

// Workspaces as ice crystals: a diamond each, the active one filled
Row {
    id: root

    required property ShellScreen screen
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(screen)

    spacing: 4

    Repeater {
        model: Hyprland.workspaces

        delegate: Item {
            id: workspace

            required property HyprlandWorkspace modelData

            visible: modelData.id > 0 && modelData.monitor === root.monitor
            width: 14
            height: 14

            Rectangle {
                anchors.centerIn: parent
                width: workspace.modelData.active ? 10 : 8
                height: width
                rotation: 45
                color: workspace.modelData.active ? Theme.accent : "transparent"
                border.width: workspace.modelData.active ? 0 : 1.5
                border.color: mouseArea.containsMouse ? Theme.text : Theme.textDisabled
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
