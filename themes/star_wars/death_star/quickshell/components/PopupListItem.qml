import QtQuick
import qs.config

Rectangle {
    id: root

    property string icon: ""
    property string title: ""
    property string subtitle: ""
    property string trailing: ""
    property string trailingIcon: ""
    property bool active: false
    property bool highlighted: false
    property color titleColor: Theme.text
    property color iconColor: active ? Theme.accent : Theme.textMuted
    readonly property bool hovered: mouseArea.containsMouse

    signal clicked(var mouse)

    width: parent ? parent.width : 0
    implicitHeight: subtitle !== "" ? 38 : 28
    radius: Theme.radius
    color: active ? Theme.surfaceActive : (highlighted || hovered ? Theme.surface : "transparent")

    Rectangle {
        width: 2
        height: parent.height
        color: Theme.accent
        visible: root.active
    }

    Text {
        id: iconText

        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        visible: root.icon !== ""
        text: root.icon
        color: root.iconColor
        font.family: Theme.iconFont
        font.pixelSize: Theme.iconSize
    }

    Column {
        anchors.left: parent.left
        anchors.leftMargin: iconText.visible ? 18 + iconText.implicitWidth : 10
        anchors.right: trailingRow.left
        anchors.rightMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        spacing: 2

        Text {
            width: parent.width
            text: root.title
            textFormat: Text.PlainText
            color: root.titleColor
            font.pixelSize: Theme.fontNormal
            font.bold: root.active
            elide: Text.ElideRight
        }

        Text {
            width: parent.width
            visible: root.subtitle !== ""
            text: root.subtitle
            textFormat: Text.PlainText
            color: Theme.textSubtle
            font.pixelSize: Theme.fontSmall
            elide: Text.ElideRight
        }
    }

    Row {
        id: trailingRow

        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        spacing: 4

        Text {
            anchors.verticalCenter: parent.verticalCenter
            visible: root.trailing !== ""
            text: root.trailing
            color: Theme.textSubtle
            font.pixelSize: Theme.fontSmall
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            visible: root.trailingIcon !== ""
            text: root.trailingIcon
            color: Theme.textSubtle
            font.family: Theme.iconFont
            font.pixelSize: Theme.fontNormal
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor
        onClicked: mouse => root.clicked(mouse)
    }
}
