import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import qs.config
import qs.modules.bar.popups

BarButton {
    id: root

    required property ShellScreen screen

    icon: Icons.shutdown
    color: hovered ? Theme.critical : Theme.textSubtle
    popup: PowerPopup {}

    IpcHandler {
        target: "power"
        enabled: Hyprland.focusedMonitor?.name === root.screen.name

        function toggle(): void {
            root.popup.toggle()
        }
    }
}
