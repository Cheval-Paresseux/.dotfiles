import QtQuick
import qs.config

// A chrome O-ring, the hardware of a collar, between the sections of the strap
Rectangle {
    anchors.verticalCenter: parent.verticalCenter
    width: 11
    height: 11
    radius: width / 2
    color: "transparent"
    border.width: 2
    border.color: Theme.overlay1
}
