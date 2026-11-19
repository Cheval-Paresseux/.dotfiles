import Quickshell
import QtQuick
import qs.components
import qs.config

Item {
    id: root

    property string icon: ""
    property string text: ""
    property bool clickable: true
    property PopupPanel popup: null
    property bool centerPopup: false
    readonly property bool hovered: mouseArea.containsMouse

    property color color: clickable && hovered ? Theme.text : Theme.textMuted

    signal clicked()

    implicitWidth: row.implicitWidth
    implicitHeight: Theme.barHeight

    Component.onCompleted: {
        if (!popup)
            return
        popup.anchor.item = root
        popup.anchor.edges = centerPopup ? Edges.Top : Edges.Top | Edges.Right
        popup.anchor.gravity = centerPopup ? Edges.Top : Edges.Top | Edges.Left
        popup.anchor.margins.top = -10
    }

    Row {
        id: row

        anchors.verticalCenter: parent.verticalCenter
        spacing: 4

        Text {
            anchors.verticalCenter: parent.verticalCenter
            visible: root.icon !== ""
            text: root.icon
            color: root.color
            font.family: Theme.iconFont
            font.pixelSize: Theme.iconSize
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            visible: root.text !== ""
            text: root.text
            color: root.color
            font.pixelSize: Theme.fontNormal
            font.bold: true
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        enabled: root.clickable
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (root.popup)
                root.popup.toggle()
            root.clicked()
        }
    }
}
