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

    // A lamp hangs above the door: its pool of light breathes like a flame
    Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            strokeWidth: 0
            fillGradient: RadialGradient {
                centerX: root.width / 2
                centerY: root.height * 0.38
                centerRadius: root.height * 0.55
                focalX: centerX
                focalY: centerY

                GradientStop { position: 0; color: Qt.alpha(Theme.gold, 0.12) }
                GradientStop { position: 0.5; color: Qt.alpha(Theme.gold, 0.035) }
                GradientStop { position: 1; color: "transparent" }
            }

            PathRectangle {
                width: root.width
                height: root.height
            }
        }

        SequentialAnimation on opacity {
            loops: Animation.Infinite

            NumberAnimation { to: 0.82; duration: 1700; easing.type: Easing.InOutSine }
            NumberAnimation { to: 1; duration: 900; easing.type: Easing.InOutSine }
            NumberAnimation { to: 0.9; duration: 2300; easing.type: Easing.InOutSine }
            NumberAnimation { to: 1; duration: 1300; easing.type: Easing.InOutSine }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: passwordField.forceActiveFocus()
    }

    Column {
        anchors.centerIn: parent
        spacing: 8

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: Icons.glass
            color: Theme.gold
            font.family: Theme.iconFont
            font.pixelSize: 34
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "MEMBERS ONLY"
            color: Theme.oldGold
            font.pixelSize: Theme.fontSmall
            font.bold: true
            font.letterSpacing: 5
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: Qt.formatDateTime(clock.date, "HH:mm")
            color: Theme.text
            font.family: Theme.displayFont
            font.variableAxes: Theme.displayAxes
            font.pixelSize: 108
            font.weight: Font.Light
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: Qt.formatDateTime(clock.date, "dddd d MMMM yyyy")
            color: Theme.textMuted
            font.family: Theme.displayFont
            font.variableAxes: Theme.displayAxes
            font.pixelSize: 20
            font.italic: true
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            topPadding: 10
            bottomPadding: 22
            text: "───────  ❦  ───────"
            color: Theme.oldGold
            font.family: Theme.iconFont
            font.pixelSize: Theme.fontLarge
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 300
            height: 42
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
                    text: "Password"
                    color: Theme.textDisabled
                    font.pixelSize: Theme.fontInput
                }
            }
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            topPadding: 4
            text: {
                if (root.lock.authenticating)
                    return "Checking the list..."
                return root.lock.failed ? "Wrong password" : "The door is closed. Password, please."
            }
            color: root.lock.failed ? Theme.textCritical : Theme.textSubtle
            font.family: Theme.displayFont
            font.variableAxes: Theme.displayAxes
            font.pixelSize: Theme.fontLarge
            font.italic: true
        }
    }
}
