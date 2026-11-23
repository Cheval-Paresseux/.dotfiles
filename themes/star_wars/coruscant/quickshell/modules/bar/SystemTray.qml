import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import qs.config

Row {
    spacing: 6
    visible: tray.count > 0

    Repeater {
        id: tray

        model: SystemTray.items

        delegate: Item {
            id: trayItem

            required property SystemTrayItem modelData

            width: Theme.iconSize
            height: Theme.iconSize

            Image {
                anchors.fill: parent
                source: trayItem.modelData.icon
                sourceSize.width: Theme.iconSize * 2
                sourceSize.height: Theme.iconSize * 2
                fillMode: Image.PreserveAspectFit
            }

            QsMenuAnchor {
                id: menuAnchor

                menu: trayItem.modelData.menu
                anchor.item: trayItem
                anchor.edges: Edges.Top
                anchor.gravity: Edges.Top
                anchor.margins.top: -10
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                cursorShape: Qt.PointingHandCursor

                onClicked: mouse => {
                    const item = trayItem.modelData
                    const wantsMenu = mouse.button === Qt.RightButton || item.onlyMenu
                    if (mouse.button === Qt.MiddleButton)
                        item.secondaryActivate()
                    else if (wantsMenu && item.hasMenu)
                        menuAnchor.open()
                    else if (!wantsMenu)
                        item.activate()
                }

                onWheel: wheel => trayItem.modelData.scroll(wheel.angleDelta.y, false)
            }
        }
    }
}
