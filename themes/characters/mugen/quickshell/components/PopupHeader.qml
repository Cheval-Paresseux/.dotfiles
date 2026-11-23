import QtQuick
import qs.config

Item {
    id: root

    property string kanji
    property string title
    property string detail
    property color detailColor: Theme.textDisabled

    property bool showSwitch: false
    property bool checked: false

    signal toggled()

    width: parent ? parent.width : 0
    implicitHeight: 24

    Row {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: 8

        Text {
            anchors.verticalCenter: parent.verticalCenter
            visible: root.kanji !== ""
            text: root.kanji
            color: Theme.accent
            font.family: Theme.kanjiFont
            font.pixelSize: Theme.fontLarge + 5
            font.weight: Font.Black
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: root.title
            color: Theme.text
            font.family: Theme.kanjiFont
            font.pixelSize: Theme.fontLarge
            font.weight: Font.Bold
        }
    }

    Text {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        visible: !root.showSwitch
        text: root.detail
        color: root.detailColor
        font.pixelSize: Theme.fontNormal
    }

    PopupSwitch {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        visible: root.showSwitch
        checked: root.checked
        onToggled: root.toggled()
    }
}
