import QtQuick
import QtQuick.Controls
import qs.config

Slider {
    id: root

    property bool dimmed: false

    height: 20
    from: 0
    to: 1
    stepSize: 0.01

    background: Rectangle {
        x: root.leftPadding
        y: root.topPadding + root.availableHeight / 2 - height / 2
        width: root.availableWidth
        height: 4
        radius: 2
        color: Theme.surface

        Rectangle {
            width: root.visualPosition * parent.width
            height: parent.height
            radius: 2
            gradient: Gradient {
                orientation: Gradient.Horizontal

                GradientStop { position: 0; color: root.dimmed ? Theme.textDisabled : Theme.oldGold }
                GradientStop { position: 1; color: root.dimmed ? Theme.textDisabled : Theme.accent }
            }
        }
    }

    handle: Rectangle {
        x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
        y: root.topPadding + root.availableHeight / 2 - height / 2
        width: 14
        height: 14
        radius: 7
        color: root.pressed ? Theme.paleGold : Theme.accent
        border.width: 2
        border.color: Theme.mantle
    }
}
