import Quickshell
import Quickshell.Wayland
import qs.config
import qs.services

// Keep awake: while the kettle is on the boil, nobody goes to bed
BarButton {
    id: root

    icon: ShellState.caffeine ? Icons.kettle : Icons.kettleOff
    color: ShellState.caffeine ? Theme.warning : (hovered ? Theme.accent : Theme.textDisabled)
    onClicked: ShellState.caffeine = !ShellState.caffeine

    IdleInhibitor {
        window: root.QsWindow.window
        enabled: ShellState.caffeine
    }
}
