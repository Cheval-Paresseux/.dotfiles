import Quickshell
import Quickshell.Hyprland
import QtQuick
import qs.config

Row {
    id: root

    required property ShellScreen screen
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(screen)

    spacing: 4

    Repeater {
        model: Hyprland.workspaces

        delegate: Rectangle {
            id: workspace

            required property HyprlandWorkspace modelData

            visible: modelData.id > 0 && modelData.monitor === root.monitor
            width: 22
            height: 18
            radius: Theme.radius
            color: modelData.active ? Theme.accent : (mouseArea.containsMouse ? Theme.surface : "transparent")

            Text {
                anchors.centerIn: parent
                text: workspace.modelData.name
                color: workspace.modelData.active ? Theme.textOnAccent : Theme.textSubtle
                font.pixelSize: Theme.fontNormal
                font.bold: true
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
