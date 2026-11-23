import Quickshell
import QtQuick
import qs.components
import qs.config

PickerWindow {
    id: root

    readonly property var apps: [...DesktopEntries.applications.values]
        .sort((a, b) => (a.name || "").localeCompare(b.name || ""))
    readonly property var results: query
        ? apps.filter(app => [app.name, app.genericName, app.comment, app.id]
            .some(field => (field || "").toLowerCase().includes(query)))
        : apps

    name: "launcher"
    placeholder: "Ring for anything..."
    panelHeight: Math.min(520, 80 + list.contentHeight)

    onQueryChanged: list.currentIndex = 0
    onOpened: list.currentIndex = 0
    onKeyPressed: event => event.accepted = list.handleKey(event)

    function launch(app) {
        app.execute()
        close()
    }

    PickerList {
        id: list

        model: root.results
        onActivated: app => root.launch(app)

        delegate: Rectangle {
            id: entry

            required property DesktopEntry modelData
            required property int index

            width: list.width
            height: 44
            radius: Theme.radius
            color: index === list.currentIndex
                ? Theme.surfaceHover
                : (mouseArea.containsMouse ? Theme.surface : "transparent")

            Rectangle {
                x: 4
                anchors.verticalCenter: parent.verticalCenter
                width: 3
                height: parent.height - 14
                radius: 1.5
                color: Theme.accent
                visible: index === list.currentIndex
            }

            Image {
                id: icon

                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                width: 24
                height: 24
                source: Quickshell.iconPath(entry.modelData.icon, "application-x-executable")
                sourceSize.width: 48
                sourceSize.height: 48
                fillMode: Image.PreserveAspectFit
                asynchronous: true
            }

            Column {
                anchors.left: icon.right
                anchors.leftMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                spacing: 1

                Text {
                    width: parent.width
                    text: entry.modelData.name || ""
                    color: Theme.text
                    font.pixelSize: Theme.fontLarge
                    elide: Text.ElideRight
                }

                Text {
                    width: parent.width
                    visible: text !== ""
                    text: entry.modelData.genericName || entry.modelData.comment || ""
                    color: Theme.textSubtle
                    font.pixelSize: Theme.fontSmall
                    elide: Text.ElideRight
                }
            }

            MouseArea {
                id: mouseArea

                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.launch(entry.modelData)
            }
        }

        EmptyState {
            anchors.centerIn: parent
            visible: list.count === 0
            icon: Icons.barley
            text: "Nothing of the sort on the estate"
        }
    }
}
