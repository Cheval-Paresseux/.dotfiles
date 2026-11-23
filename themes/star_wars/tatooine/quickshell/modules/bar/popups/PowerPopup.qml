import Quickshell
import Quickshell.Io
import QtQuick
import qs.components
import qs.config
import qs.services

PopupPanel {
    id: root

    readonly property var actions: [
        { label: "Lock", icon: Icons.lock, color: Theme.accent, command: ["qs", "ipc", "call", "lock", "lock"] },
        { label: "Suspend", icon: Icons.sleep, color: Theme.duskBlue, command: ["systemctl", "suspend"] },
        { label: "Log out", icon: Icons.logout, color: Theme.gold, command: ["uwsm", "stop"], confirm: true },
        { label: "Reboot", icon: Icons.restart, color: Theme.rust, command: ["systemctl", "reboot"], confirm: true },
        { label: "Shut down", icon: Icons.shutdown, color: Theme.blaster, command: ["systemctl", "poweroff"], confirm: true }
    ]

    property int selectedIndex: 0
    property int confirmIndex: -1
    property string uptime: ""

    implicitWidth: 220

    onVisibleChanged: {
        selectedIndex = 0
        confirmIndex = -1
        if (visible)
            uptimeProcess.running = true
    }

    onKeyPressed: event => {
        switch (event.key) {
        case Qt.Key_Down:
        case Qt.Key_Tab:
            moveSelection(1)
            break
        case Qt.Key_Up:
        case Qt.Key_Backtab:
            moveSelection(-1)
            break
        case Qt.Key_Return:
        case Qt.Key_Enter:
            run(selectedIndex)
            break
        default:
            return
        }
        event.accepted = true
    }

    function moveSelection(delta) {
        selectedIndex = (selectedIndex + delta + actions.length) % actions.length
        confirmIndex = -1
    }

    function run(index) {
        const action = actions[index]
        if (action.confirm && confirmIndex !== index) {
            confirmIndex = index
            confirmTimer.restart()
            return
        }
        visible = false
        Quickshell.execDetached(action.command)
    }

    Timer {
        id: confirmTimer

        interval: 3000
        onTriggered: root.confirmIndex = -1
    }

    Process {
        id: uptimeProcess

        command: ["cat", "/proc/uptime"]
        stdout: StdioCollector {
            onStreamFinished: root.uptime = "up " + Format.duration(parseFloat(this.text))
        }
    }

    PopupHeader {
        title: "Power"
        detail: root.uptime
    }

    PopupSection {
        title: "Session"
    }

    Column {
        width: parent.width
        spacing: 2

        Repeater {
            model: root.actions

            delegate: PopupListItem {
                required property var modelData
                required property int index

                readonly property bool confirming: root.confirmIndex === index

                icon: modelData.icon
                iconColor: modelData.color
                title: confirming ? modelData.label + "?" : modelData.label
                titleColor: confirming ? Theme.textCritical : Theme.text
                trailing: confirming ? "press again" : ""
                highlighted: root.selectedIndex === index

                onHoveredChanged: {
                    if (hovered)
                        root.selectedIndex = index
                }
                onClicked: root.run(index)
            }
        }
    }
}
