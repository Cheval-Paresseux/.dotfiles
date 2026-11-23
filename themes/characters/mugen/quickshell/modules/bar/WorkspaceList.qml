import Quickshell
import Quickshell.Hyprland
import QtQuick
import qs.config

// Workspaces in the formal numerals of old documents and coins (一 alone would read as a no-entry sign);
// the one you are in sits inside the red sun
Row {
    id: root

    required property ShellScreen screen
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(screen)
    readonly property var numerals: ["壱", "弐", "参", "肆", "伍", "陸", "漆", "捌", "玖", "拾"]

    spacing: 2

    Repeater {
        model: Hyprland.workspaces

        delegate: Rectangle {
            id: workspace

            required property HyprlandWorkspace modelData

            visible: modelData.id > 0 && modelData.monitor === root.monitor
            width: 22
            height: 22
            radius: width / 2
            color: modelData.active ? Theme.accent : (mouseArea.containsMouse ? Theme.surfaceHover : "transparent")

            Behavior on color {
                ColorAnimation { duration: 150 }
            }

            Text {
                anchors.centerIn: parent
                text: root.numerals[workspace.modelData.id - 1] ?? workspace.modelData.name
                color: workspace.modelData.active ? Theme.textOnAccent : Theme.textMuted
                font.family: Theme.kanjiFont
                font.pixelSize: Theme.fontMedium
                font.weight: Font.Bold
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
