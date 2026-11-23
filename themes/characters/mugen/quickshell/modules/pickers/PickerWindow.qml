import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services

PanelWindow {
    id: root

    required property string name
    property string placeholder: "Search..."
    property int panelWidth: 520
    property int panelHeight: 520

    readonly property string query: searchField.text.trim().toLowerCase()
    default property alias content: body.data

    signal opened()
    signal keyPressed(var event)

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }
    color: "transparent"
    visible: false
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "quickshell-" + name
    WlrLayershell.keyboardFocus: visible ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

    function open() {
        screen = ShellState.focusedScreen
        searchField.text = ""
        visible = true
        searchField.forceActiveFocus()
        opened()
    }

    function close() {
        visible = false
    }

    function toggle() {
        if (visible)
            close()
        else
            open()
    }

    Connections {
        target: ShellState

        function onToggleRequested(target) {
            if (target === root.name)
                root.toggle()
        }
    }

    IpcHandler {
        target: root.name

        function toggle(): void {
            root.toggle()
        }

        function open(): void {
            root.open()
        }

        function close(): void {
            root.close()
        }
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.overlay

        MouseArea {
            anchors.fill: parent
            onClicked: root.close()
        }
    }

    // The ink shadow of the printed card
    Rectangle {
        x: panel.x + 6
        y: panel.y + 6
        width: panel.width
        height: panel.height
        color: Theme.text
    }

    Rectangle {
        id: panel

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.18
        width: root.panelWidth
        height: root.panelHeight
        radius: Theme.radius
        color: Theme.popupBackground
        border.color: Theme.text
        border.width: 1

        MouseArea {
            anchors.fill: parent
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: Theme.padding
            spacing: 10

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                radius: Theme.radius
                color: Theme.surface
                border.color: searchField.activeFocus ? Theme.borderFocus : Theme.surfaceActive

                TextInput {
                    id: searchField

                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    verticalAlignment: TextInput.AlignVCenter
                    color: Theme.text
                    selectionColor: Theme.selection
                    selectedTextColor: Theme.selectionText
                    font.pixelSize: Theme.fontInput
                    clip: true

                    Keys.onPressed: event => {
                        if (event.key === Qt.Key_Escape) {
                            root.close()
                            event.accepted = true
                        } else {
                            root.keyPressed(event)
                        }
                    }

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        visible: searchField.text === ""
                        text: root.placeholder
                        color: Theme.textDisabled
                        font.pixelSize: Theme.fontInput
                    }
                }
            }

            Item {
                id: body

                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}
