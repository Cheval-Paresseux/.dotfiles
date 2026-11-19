import QtQuick
import qs.components
import qs.config
import qs.services

PopupPanel {
    id: root

    readonly property var history: NotificationService.history

    implicitWidth: 320

    PopupHeader {
        title: "Visions"
        detail: root.history.length > 0 ? root.history.length.toString() : ""
    }

    Row {
        id: actions

        width: parent.width
        spacing: 6

        PopupButton {
            width: (actions.width - actions.spacing) / 2
            icon: NotificationService.doNotDisturb ? Icons.bellOff : Icons.bellOutline
            text: "Meditate"
            checked: NotificationService.doNotDisturb
            onClicked: NotificationService.doNotDisturb = !NotificationService.doNotDisturb
        }

        PopupButton {
            width: (actions.width - actions.spacing) / 2
            text: "Clear"
            enabled: root.history.length > 0
            onClicked: NotificationService.clear()
        }
    }

    PopupSection {
        title: "Received"
    }

    ListView {
        width: parent.width
        height: Math.min(contentHeight, 360)
        visible: count > 0
        clip: true
        spacing: 4
        boundsBehavior: Flickable.StopAtBounds
        model: root.history

        delegate: Rectangle {
            id: entry

            required property var modelData

            width: ListView.view.width
            height: content.implicitHeight + 16
            radius: Theme.radius
            color: mouseArea.containsMouse ? Theme.surfaceActive : Theme.surface

            Rectangle {
                width: 2
                height: parent.height
                color: entry.modelData.critical ? Theme.critical : Theme.info
            }

            Column {
                id: content

                x: 12
                y: 8
                width: parent.width - 20
                spacing: 2

                Item {
                    width: parent.width
                    height: summary.implicitHeight

                    Text {
                        id: summary

                        anchors.left: parent.left
                        anchors.right: time.left
                        anchors.rightMargin: 6
                        text: entry.modelData.summary || entry.modelData.appName
                        textFormat: Text.PlainText
                        color: Theme.text
                        font.pixelSize: Theme.fontNormal
                        font.bold: true
                        elide: Text.ElideRight
                    }

                    Text {
                        id: time

                        anchors.right: parent.right
                        text: Qt.formatTime(entry.modelData.time, "HH:mm")
                        color: Theme.textDisabled
                        font.pixelSize: Theme.fontSmall
                    }
                }

                Text {
                    width: parent.width
                    visible: text !== ""
                    text: entry.modelData.body
                    textFormat: Text.PlainText
                    color: Theme.textMuted
                    font.pixelSize: Theme.fontNormal
                    wrapMode: Text.Wrap
                    elide: Text.ElideRight
                    maximumLineCount: 4
                }

                Text {
                    width: parent.width
                    visible: text !== ""
                    text: entry.modelData.summary ? entry.modelData.appName : ""
                    color: Theme.textDisabled
                    font.pixelSize: Theme.fontSmall
                    elide: Text.ElideRight
                }
            }

            MouseArea {
                id: mouseArea

                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: NotificationService.remove(entry.modelData.key)
            }
        }
    }

    EmptyState {
        visible: root.history.length === 0
        icon: "x-wing"
        text: NotificationService.doNotDisturb ? "No visions · meditating, toasts are hidden" : "No visions"
    }
}
