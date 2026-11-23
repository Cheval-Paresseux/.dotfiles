import QtQuick
import qs.config

// A brass rivet set in the strap, lit from the top left
Rectangle {
    anchors.verticalCenter: parent.verticalCenter
    width: 7
    height: 7
    radius: 3.5
    border.width: 1
    border.color: Qt.darker(Theme.brass, 1.8)
    gradient: Gradient {
        GradientStop { position: 0; color: Qt.lighter(Theme.brass, 1.3) }
        GradientStop { position: 1; color: Qt.darker(Theme.brass, 1.4) }
    }
}
