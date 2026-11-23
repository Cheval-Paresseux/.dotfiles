import QtQuick
import qs.config

Rectangle {
    id: root

    property string icon: ""
    property string text: ""
    property bool checked: false
    property bool small: false
    property color accentColor: Theme.accent
    readonly property bool hovered: mouseArea.containsMouse
    readonly property color contentColor: checked ? Theme.textOnAccent : Theme.text

    signal clicked()

    implicitWidth: row.implicitWidth + (small ? 12 : 20)
    implicitHeight: small ? 20 : 28
    radius: Theme.radius
    opacity: enabled ? 1 : 0.4
    color: checked ? accentColor : (hovered ? Theme.surfaceActive : Theme.surface)
    border.width: 1
    border.color: checked ? accentColor : (hovered ? Theme.overlay0 : Theme.border)

    Row {
        id: row

        anchors.centerIn: parent
        spacing: 6

        Text {
            anchors.verticalCenter: parent.verticalCenter
            visible: root.icon !== ""
            text: root.icon
            color: root.contentColor
            font.family: Theme.iconFont
            font.pixelSize: root.small ? Theme.fontNormal : Theme.iconSize
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            visible: root.text !== ""
            text: root.text
            color: root.contentColor
            font.pixelSize: root.small ? Theme.fontSmall : Theme.fontNormal
            font.bold: root.checked
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
