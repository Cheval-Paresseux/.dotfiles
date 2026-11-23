import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import qs.config

Rectangle {
    id: root

    required property Notification modelData

    readonly property bool critical: modelData.urgency === NotificationUrgency.Critical
    readonly property int timeout: modelData.expireTimeout > 0
        ? Math.min(Math.max(modelData.expireTimeout * 1000, 1500), 10000)
        : 5000
    readonly property string iconSource: {
        const icon = modelData.appIcon
        if (!icon)
            return ""
        if (icon.startsWith("/"))
            return "file://" + icon
        return icon.includes("://") ? icon : Quickshell.iconPath(icon, true)
    }

    width: 300
    height: content.implicitHeight + 20
    radius: Theme.radius
    color: mouseArea.containsMouse ? Theme.surfaceHover : Theme.popupBackground
    border.width: 1
    border.color: critical ? Theme.borderCritical : Theme.border

    Rectangle {
        x: 4
        anchors.verticalCenter: parent.verticalCenter
        width: 3
        height: parent.height - 14
        radius: 1.5
        color: root.critical ? Theme.critical : Theme.info
    }

    Column {
        id: content

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 10
        spacing: 4

        Row {
            width: parent.width
            spacing: 8

            Image {
                id: appIcon

                anchors.verticalCenter: parent.verticalCenter
                width: 16
                height: 16
                visible: status === Image.Ready
                source: root.iconSource
                sourceSize.width: 32
                sourceSize.height: 32
                fillMode: Image.PreserveAspectFit
                asynchronous: true
            }

            Text {
                width: parent.width - (appIcon.visible ? appIcon.width + parent.spacing : 0)
                text: root.modelData.summary || root.modelData.appName
                textFormat: Text.PlainText
                color: Theme.text
                font.pixelSize: Theme.fontMedium
                font.bold: true
                elide: Text.ElideRight
            }
        }

        Text {
            width: parent.width
            visible: text !== ""
            text: root.modelData.body
            textFormat: Text.PlainText
            color: Theme.textMuted
            font.pixelSize: Theme.fontNormal
            wrapMode: Text.Wrap
            elide: Text.ElideRight
            maximumLineCount: 3
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.modelData.dismiss()
    }

    Timer {
        interval: root.timeout
        running: !root.critical && !mouseArea.containsMouse
        onTriggered: root.modelData.expire()
    }
}
