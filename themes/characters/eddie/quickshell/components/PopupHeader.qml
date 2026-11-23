import QtQuick
import qs.config

Item {
    id: root

    property string title
    property string detail
    property color detailColor: Theme.textDisabled

    property bool showSwitch: false
    property bool checked: false

    signal toggled()

    width: parent ? parent.width : 0
    implicitHeight: 24

    Text {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        text: root.title
        color: Theme.text
        font.family: Theme.displayFont
        font.pixelSize: 17
        font.weight: Font.Medium
    }

    Text {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        visible: !root.showSwitch
        text: root.detail
        color: root.detailColor
        font.family: Theme.displayFont
        font.pixelSize: Theme.fontMedium
        font.italic: true
    }

    PopupSwitch {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        visible: root.showSwitch
        checked: root.checked
        onToggled: root.toggled()
    }
}
