import QtQuick
import qs.config

// Rounded "dome" holding a row of bar items
Rectangle {
    default property alias content: row.data

    implicitWidth: row.implicitWidth + 20
    implicitHeight: Theme.barItemHeight
    radius: height / 2
    color: Qt.alpha(Theme.surface, 0.7)
    border.width: 1
    border.color: Theme.surfaceHover

    Row {
        id: row

        anchors.centerIn: parent
        spacing: 10
    }
}
