import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.services

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property ShellScreen modelData

            screen: modelData
            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }
            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.layer: WlrLayer.Background
            WlrLayershell.namespace: "quickshell-background"
            color: "black"

            Image {
                anchors.fill: parent
                source: Settings.wallpaper
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                retainWhileLoading: true
            }
        }
    }
}
