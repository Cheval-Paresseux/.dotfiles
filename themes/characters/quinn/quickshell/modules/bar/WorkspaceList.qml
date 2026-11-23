import Quickshell
import Quickshell.Hyprland
import QtQuick
import qs.config

// Workspaces are hearts: empty ones are outlines, the others fill in, and the one you are in
// beats in neon, faster the more windows it holds
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
            readonly property bool active: modelData.active
            readonly property int windows: modelData.toplevels.values.length
            // Resting at 60 beats a minute, racing up to 150
            readonly property int beat: 60000 / Math.min(150, 60 + 18 * windows)

            visible: modelData.id > 0 && modelData.monitor === root.monitor
            width: 22
            height: 22

            Text {
                id: heart

                anchors.centerIn: parent
                text: workspace.windows > 0 || workspace.active ? Icons.heart : Icons.heartOutline
                color: {
                    if (workspace.active)
                        return Theme.accent
                    if (mouseArea.containsMouse)
                        return Theme.blush
                    return workspace.windows > 0 ? Theme.crimson : Theme.overlay0
                }
                font.family: Theme.iconFont
                font.pixelSize: 21

                // Lub-dub: two quick beats, then rest
                SequentialAnimation on scale {
                    running: workspace.active
                    loops: Animation.Infinite
                    alwaysRunToEnd: true

                    NumberAnimation { to: 1.18; duration: workspace.beat * 0.12; easing.type: Easing.OutQuad }
                    NumberAnimation { to: 1; duration: workspace.beat * 0.12; easing.type: Easing.InQuad }
                    NumberAnimation { to: 1.1; duration: workspace.beat * 0.1; easing.type: Easing.OutQuad }
                    NumberAnimation { to: 1; duration: workspace.beat * 0.16; easing.type: Easing.InQuad }
                    PauseAnimation { duration: workspace.beat * 0.5 }
                }
            }

            Text {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -1
                visible: workspace.windows > 0 || workspace.active
                scale: heart.scale
                text: workspace.modelData.name
                color: workspace.active ? Theme.textOnAccent : Theme.textMuted
                font.pixelSize: 8
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
