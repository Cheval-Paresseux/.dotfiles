pragma Singleton

import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property bool caffeine: false

    readonly property ShellScreen focusedScreen: Quickshell.screens.find(
        screen => screen.name === Hyprland.focusedMonitor?.name
    ) ?? Quickshell.screens[0] ?? null

    signal toggleRequested(string target)

    function toggle(target) {
        root.toggleRequested(target)
    }

    IpcHandler {
        target: "caffeine"

        function toggle(): void {
            root.caffeine = !root.caffeine
        }

        function isEnabled(): bool {
            return root.caffeine
        }
    }
}
