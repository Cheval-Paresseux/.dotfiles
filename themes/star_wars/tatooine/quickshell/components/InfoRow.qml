import QtQuick
import qs.config

Item {
    id: root

    property string label
    property string value

    width: parent ? parent.width : 0
    implicitHeight: 18

    Text {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        text: root.label
        color: Theme.textSubtle
        font.pixelSize: Theme.fontNormal
    }

    Text {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        width: Math.min(implicitWidth, parent.width * 0.65)
        horizontalAlignment: Text.AlignRight
        text: root.value
        textFormat: Text.PlainText
        color: Theme.text
        font.pixelSize: Theme.fontNormal
        elide: Text.ElideLeft
    }
}
