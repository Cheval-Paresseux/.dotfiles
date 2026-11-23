import Quickshell
import Quickshell.Hyprland
import QtQuick
import qs.config

// Workspaces as a volume chart: each gilded column grows with the windows it holds
Row {
    id: root

    required property ShellScreen screen
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(screen)

    height: Theme.barItemHeight
    spacing: 3

    // Polished gold, lit from above
    Gradient {
        id: gilt

        GradientStop { position: 0; color: Theme.champagne }
        GradientStop { position: 0.6; color: Theme.gold }
        GradientStop { position: 1; color: Theme.brass }
    }

    Repeater {
        model: Hyprland.workspaces

        delegate: Rectangle {
            id: workspace

            required property HyprlandWorkspace modelData
            readonly property int windows: modelData.toplevels.values.length

            visible: modelData.id > 0 && modelData.monitor === root.monitor
            anchors.bottom: parent.bottom
            width: 14
            height: modelData.active ? root.height : Math.min(root.height, 11 + 2 * windows)
            color: "transparent"
            border.width: modelData.active ? 0 : 1
            border.color: Qt.alpha(Theme.accent, mouseArea.containsMouse ? 0.8 : 0.35)
            gradient: modelData.active ? gilt : null

            Behavior on height {
                NumberAnimation { duration: 150 }
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                text: workspace.modelData.name
                color: workspace.modelData.active ? Theme.textOnAccent : Theme.textSubtle
                font.family: Theme.displayFont
                font.pixelSize: Theme.fontSmall
                font.weight: Font.Medium
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
