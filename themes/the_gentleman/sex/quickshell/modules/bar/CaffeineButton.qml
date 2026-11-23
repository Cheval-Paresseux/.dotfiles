import Quickshell
import Quickshell.Wayland
import qs.config
import qs.services

// Keep awake: while the handcuffs are on, the screen is not going anywhere
BarButton {
    id: root

    icon: Icons.handcuffs
    color: ShellState.caffeine ? Theme.warning : (hovered ? Theme.accent : Theme.textDisabled)
    onClicked: ShellState.caffeine = !ShellState.caffeine

    IdleInhibitor {
        window: root.QsWindow.window
        enabled: ShellState.caffeine
    }
}
