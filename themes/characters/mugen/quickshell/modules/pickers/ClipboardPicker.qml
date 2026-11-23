import Quickshell
import Quickshell.Io
import QtQuick
import qs.config

PickerWindow {
    id: root

    property var entries: []
    readonly property var results: query
        ? entries.filter(entry => entry.text.toLowerCase().includes(query))
        : entries

    name: "clipboard"
    placeholder: "Search your pockets..."

    onQueryChanged: list.currentIndex = 0
    onOpened: listProcess.running = true
    onKeyPressed: event => {
        if (event.key === Qt.Key_Delete && (event.modifiers & Qt.ShiftModifier)) {
            remove(results[list.currentIndex])
            event.accepted = true
        } else {
            event.accepted = list.handleKey(event)
        }
    }

    function parse(output) {
        entries = output.split("\n")
            .filter(line => line.includes("\t"))
            .map(line => {
                const preview = line.slice(line.indexOf("\t") + 1)
                const image = preview.match(/^\[\[ binary data (.+) \]\]$/)
                return {
                    line: line,
                    text: image ? "Image · " + image[1] : preview,
                    isImage: image !== null
                }
            })
        list.currentIndex = 0
    }

    function copy(entry) {
        Quickshell.execDetached(["sh", "-c", 'printf "%s\\n" "$1" | cliphist decode | wl-copy', "sh", entry.line])
        close()
    }

    function remove(entry) {
        if (!entry)
            return
        deleteProcess.command = ["sh", "-c", 'printf "%s\\n" "$1" | cliphist delete', "sh", entry.line]
        deleteProcess.running = true
    }

    Process {
        id: listProcess

        command: ["cliphist", "list"]
        stdout: StdioCollector {
            onStreamFinished: root.parse(this.text)
        }
    }

    Process {
        id: deleteProcess

        onExited: listProcess.running = true
    }

    PickerList {
        id: list

        anchors.bottomMargin: hint.height + 6
        model: root.results
        onActivated: entry => root.copy(entry)

        delegate: Rectangle {
            id: item

            required property var modelData
            required property int index

            width: list.width
            height: 34
            radius: Theme.radius
            color: index === list.currentIndex
                ? Theme.surfaceHover
                : (mouseArea.containsMouse ? Theme.surface : "transparent")

            Rectangle {
                width: 2
                height: parent.height
                color: Theme.accent
                visible: index === list.currentIndex
            }

            Text {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                text: item.modelData.text
                textFormat: Text.PlainText
                maximumLineCount: 1
                elide: Text.ElideRight
                color: item.modelData.isImage ? Theme.textSubtle : Theme.text
                font.pixelSize: Theme.fontMedium
                font.italic: item.modelData.isImage
            }

            MouseArea {
                id: mouseArea

                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.copy(item.modelData)
            }
        }

        Text {
            anchors.centerIn: parent
            visible: list.count === 0
            text: root.entries.length === 0 ? "Empty pockets" : "Not in your pockets"
            color: Theme.textDisabled
            font.pixelSize: Theme.fontLarge
        }
    }

    Text {
        id: hint

        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Enter: copy  ·  Shift+Delete: remove"
        color: Theme.textDisabled
        font.pixelSize: Theme.fontSmall
    }
}
