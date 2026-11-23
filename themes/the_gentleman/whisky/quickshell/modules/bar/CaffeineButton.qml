import Quickshell
import Quickshell.Wayland
import qs.config
import qs.services

// Keep awake: while the cigar is lit, the evening goes on
BarButton {
    id: root

    icon: ShellState.caffeine ? Icons.cigar : Icons.cigarOff
    color: ShellState.caffeine ? Theme.cognac : (hovered ? Theme.accent : Theme.textDisabled)
    onClicked: ShellState.caffeine = !ShellState.caffeine

    IdleInhibitor {
        window: root.QsWindow.window
        enabled: ShellState.caffeine
    }
}
