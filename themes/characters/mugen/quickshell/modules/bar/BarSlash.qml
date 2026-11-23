import QtQuick
import qs.config

// A sword cut between two groups of the bar
Rectangle {
    anchors.verticalCenter: parent ? parent.verticalCenter : undefined
    width: 2
    height: 16
    rotation: 25
    antialiasing: true
    color: Theme.accent
}
