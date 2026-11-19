pragma Singleton

import Quickshell
import Quickshell.Bluetooth
import Quickshell.Io
import QtQuick

// Runs the pairing agent; `request` is what it currently needs from the user, if anything.
Singleton {
    id: root

    property var message: null
    // BlueZ says nothing when a shown code is no longer needed, so it only lasts while its device pairs.
    readonly property var request: message && (message.kind !== "type"
        || Bluetooth.devices.values.some(d => d.address === message.address && d.pairing)) ? message : null

    function answer(accepted) {
        agent.write(accepted ? "yes\n" : "no\n")
        message = null
    }

    Process {
        id: agent

        running: true
        command: ["python3", Quickshell.shellDir + "/scripts/bt-agent.py"]
        stdinEnabled: true
        stdout: SplitParser {
            onRead: line => {
                const message = JSON.parse(line)
                root.message = message.kind === "cancel" ? null : message
            }
        }
    }
}
