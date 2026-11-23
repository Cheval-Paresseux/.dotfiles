pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

// Screen backlight through brightnessctl, on the same perceptual curve (-e4) as the brightness keys
Singleton {
    id: root

    property string device: ""
    property int max: 0
    property int raw: 0
    readonly property bool available: device !== "" && max > 0
    readonly property real level: available ? Math.pow(raw / max, 1 / 4) : 0

    function setLevel(value) {
        const percent = Math.round(Math.max(0, Math.min(1, value)) * 100)
        Quickshell.execDetached(["brightnessctl", "-q", "-e4", "-n2", "set", percent + "%"])
    }

    Process {
        running: true
        command: ["brightnessctl", "-m", "-c", "backlight", "info"]
        stdout: StdioCollector {
            onStreamFinished: {
                const fields = text.trim().split(",")
                if (fields.length < 5)
                    return
                root.max = Number(fields[4])
                root.device = fields[0]
            }
        }
    }

    FileView {
        path: root.device ? "/sys/class/backlight/" + root.device + "/actual_brightness" : ""
        watchChanges: true
        onFileChanged: reload()
        onLoaded: root.raw = Number(text())
    }
}
