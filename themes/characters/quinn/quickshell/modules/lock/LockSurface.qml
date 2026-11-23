import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Shapes
import qs.config
import qs.services

WlSessionLockSurface {
    id: root

    required property var lock

    color: "black"

    SystemClock {
        id: clock

        precision: SystemClock.Minutes
    }

    Image {
        anchors.fill: parent
        source: Settings.wallpaper
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.lockOverlay
    }

    // A neon glow behind the door, pulsing like a slow heartbeat
    Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            strokeWidth: 0
            fillGradient: RadialGradient {
                centerX: root.width / 2
                centerY: root.height * 0.45
                centerRadius: root.height * 0.6
                focalX: centerX
                focalY: centerY

                GradientStop { position: 0; color: Qt.alpha(Theme.neon, 0.2) }
                GradientStop { position: 0.45; color: Qt.alpha(Theme.crimson, 0.1) }
                GradientStop { position: 1; color: "transparent" }
            }

            PathRectangle {
                width: root.width
                height: root.height
            }
        }

        SequentialAnimation on opacity {
            loops: Animation.Infinite

            NumberAnimation { to: 1; duration: 180; easing.type: Easing.OutQuad }
            NumberAnimation { to: 0.75; duration: 220; easing.type: Easing.InQuad }
            NumberAnimation { to: 0.92; duration: 160; easing.type: Easing.OutQuad }
            NumberAnimation { to: 0.6; duration: 600; easing.type: Easing.InOutSine }
            PauseAnimation { duration: 400 }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: passwordField.forceActiveFocus()
    }

    Column {
        anchors.centerIn: parent
        spacing: 6

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: Icons.mask
            color: Theme.neon
            font.family: Theme.iconFont
            font.pixelSize: 40
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            topPadding: 4
            text: "BEHIND CLOSED DOORS"
            color: Theme.blush
            font.pixelSize: Theme.fontSmall
            font.letterSpacing: 6
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: Qt.formatDateTime(clock.date, "HH:mm")
            color: Theme.text
            font.family: Theme.displayFont
            font.variableAxes: Theme.displayAxes
            font.pixelSize: 132
            font.italic: true
            // Distance-field text breaks up the overlapping outlines of a variable font at this size
            renderType: Text.CurveRendering
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            bottomPadding: 30
            text: Qt.formatDateTime(clock.date, "dddd d MMMM").toUpperCase()
            color: Theme.textMuted
            font.pixelSize: Theme.fontMedium
            font.letterSpacing: 4
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 300
            height: 44
            radius: height / 2
            color: Theme.popupBackground
            border.width: 1
            border.color: root.lock.failed
                ? Theme.borderCritical
                : (passwordField.activeFocus ? Theme.borderFocus : Theme.border)

            TextInput {
                id: passwordField

                anchors.fill: parent
                anchors.leftMargin: 12
                anchors.rightMargin: 12
                verticalAlignment: TextInput.AlignVCenter
                horizontalAlignment: TextInput.AlignHCenter
                focus: true
                readOnly: root.lock.authenticating
                echoMode: TextInput.Password
                passwordCharacter: "•"
                color: Theme.text
                selectionColor: Theme.selection
                selectedTextColor: Theme.selectionText
                font.pixelSize: Theme.fontInput
                clip: true

                Component.onCompleted: forceActiveFocus()

                onTextChanged: {
                    if (root.lock.password !== text)
                        root.lock.password = text
                }

                Keys.onReturnPressed: root.lock.tryUnlock()
                Keys.onEnterPressed: root.lock.tryUnlock()
                Keys.onEscapePressed: root.lock.password = ""

                Connections {
                    target: root.lock

                    function onPasswordChanged() {
                        if (passwordField.text !== root.lock.password)
                            passwordField.text = root.lock.password
                    }
                }

                Text {
                    anchors.fill: parent
                    visible: passwordField.text === ""
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: "Safeword"
                    color: Theme.textDisabled
                    font.pixelSize: Theme.fontInput
                }
            }
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            topPadding: 6
            text: {
                if (root.lock.authenticating)
                    return "Hold still..."
                return root.lock.failed ? "That's not the word. Wrong password." : "Say the word: your password."
            }
            color: root.lock.failed ? Theme.textCritical : Theme.textSubtle
            font.family: Theme.displayFont
            font.variableAxes: Theme.displayAxes
            font.pixelSize: Theme.fontLarge + 1
            font.italic: true
        }
    }
}
