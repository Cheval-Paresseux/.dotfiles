import QtQuick
import qs.config

// A thin gold rule between sections, fading out at both ends
Rectangle {
    anchors.verticalCenter: parent.verticalCenter
    width: 1
    height: 18
    gradient: Gradient {
        GradientStop { position: 0; color: "transparent" }
        GradientStop { position: 0.5; color: Qt.alpha(Theme.accent, 0.55) }
        GradientStop { position: 1; color: "transparent" }
    }
}
