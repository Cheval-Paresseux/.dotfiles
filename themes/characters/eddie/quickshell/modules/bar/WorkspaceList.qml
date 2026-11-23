import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Shapes
import qs.config

// Workspaces are small heraldic shields numbered in Roman figures, like the quarterings of the family
// arms; the one you are in is emblazoned in scarlet
Row {
    id: root

    required property ShellScreen screen
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(screen)
    readonly property var numerals: ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X"]

    spacing: 4

    Repeater {
        model: Hyprland.workspaces

        delegate: Item {
            id: workspace

            required property HyprlandWorkspace modelData
            readonly property bool active: modelData.active

            visible: modelData.id > 0 && modelData.monitor === root.monitor
            width: 22
            height: 24

            // A heater shield: square shoulders, sides curving down to a point
            Shape {
                anchors.fill: parent
                preferredRendererType: Shape.CurveRenderer

                ShapePath {
                    strokeWidth: 1
                    strokeColor: workspace.active ? Theme.accent : (mouseArea.containsMouse ? Theme.textMuted : Theme.overlay0)
                    fillColor: workspace.active ? Theme.accent : (mouseArea.containsMouse ? Theme.surfaceHover : "transparent")

                    startX: 1.5
                    startY: 1.5
                    PathLine { x: workspace.width - 1.5; y: 1.5 }
                    PathLine { x: workspace.width - 1.5; y: workspace.height * 0.45 }
                    PathQuad { x: workspace.width / 2; y: workspace.height - 1; controlX: workspace.width - 1.5; controlY: workspace.height * 0.85 }
                    PathQuad { x: 1.5; y: workspace.height * 0.45; controlX: 1.5; controlY: workspace.height * 0.85 }
                    PathLine { x: 1.5; y: 1.5 }
                }
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                y: 2
                text: root.numerals[workspace.modelData.id - 1] ?? workspace.modelData.name
                color: workspace.active ? Theme.textOnAccent : Theme.textMuted
                font.family: Theme.displayFont
                font.pixelSize: workspace.modelData.id > 3 ? 9 : 11
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
