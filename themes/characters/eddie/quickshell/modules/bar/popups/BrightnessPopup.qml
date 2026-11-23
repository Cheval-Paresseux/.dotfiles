import QtQuick
import qs.components
import qs.config
import qs.services

PopupPanel {
    PopupHeader {
        title: "The weather"
    }

    Item {
        width: parent.width
        height: 28

        Text {
            id: icon

            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 28
            horizontalAlignment: Text.AlignHCenter
            text: Icons.brightness(BrightnessService.level)
            color: Theme.text
            font.family: Theme.iconFont
            font.pixelSize: Theme.iconSize
        }

        PopupSlider {
            anchors.left: icon.right
            anchors.leftMargin: 10
            anchors.right: percent.left
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            value: BrightnessService.level
            onMoved: BrightnessService.setLevel(value)
        }

        Text {
            id: percent

            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: 34
            horizontalAlignment: Text.AlignRight
            text: Format.percent(BrightnessService.level)
            color: Theme.textMuted
            font.pixelSize: Theme.fontNormal
        }
    }
}
