import Quickshell
import Quickshell.Wayland
import qs.config
import qs.services

BarButton {
    id: root

    icon: ShellState.caffeine ? Icons.coffee : Icons.coffeeOutline
    color: ShellState.caffeine ? Theme.warning : (hovered ? Theme.accent : Theme.textDisabled)
    onClicked: ShellState.caffeine = !ShellState.caffeine

    IdleInhibitor {
        window: root.QsWindow.window
        enabled: ShellState.caffeine
    }
}
