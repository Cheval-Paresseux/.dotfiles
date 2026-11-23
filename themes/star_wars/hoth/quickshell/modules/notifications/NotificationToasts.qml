import Quickshell
import QtQuick
import qs.services

PanelWindow {
    screen: ShellState.focusedScreen
    anchors {
        top: true
        right: true
    }
    margins.top: 10
    margins.right: 10
    implicitWidth: 300
    implicitHeight: Math.max(1, column.implicitHeight)
    exclusiveZone: 0
    color: "transparent"
    visible: repeater.count > 0

    Column {
        id: column

        spacing: 8

        Repeater {
            id: repeater

            model: NotificationService.toasts

            delegate: NotificationToast {}
        }
    }
}
