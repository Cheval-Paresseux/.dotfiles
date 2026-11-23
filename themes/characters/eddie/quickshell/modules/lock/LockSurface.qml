import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Shapes
import qs.components
import qs.config
import qs.services

WlSessionLockSurface {
    id: root

    required property var lock

    color: Theme.crust

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

    MouseArea {
        anchors.fill: parent
        onClicked: passwordField.forceActiveFocus()
    }

    Column {
        anchors.centerIn: parent
        spacing: 8

        // The family arms: a chevron between three fleurs-de-lis, on a scarlet heater shield edged in brass
        Item {
            id: arms

            anchors.horizontalCenter: parent.horizontalCenter
            width: 84
            height: 100

            Shape {
                anchors.fill: parent
                preferredRendererType: Shape.CurveRenderer

                ShapePath {
                    strokeWidth: 3
                    strokeColor: Theme.brass
                    fillColor: Theme.accent

                    startX: 2
                    startY: 2
                    PathLine { x: arms.width - 2; y: 2 }
                    PathLine { x: arms.width - 2; y: arms.height * 0.45 }
                    PathQuad { x: arms.width / 2; y: arms.height - 2; controlX: arms.width - 2; controlY: arms.height * 0.85 }
                    PathQuad { x: 2; y: arms.height * 0.45; controlX: 2; controlY: arms.height * 0.85 }
                    PathLine { x: 2; y: 2 }
                }

                ShapePath {
                    strokeWidth: 0
                    strokeColor: "transparent"
                    fillColor: Theme.oatmeal

                    startX: 4
                    startY: 66
                    PathLine { x: arms.width / 2; y: 32 }
                    PathLine { x: arms.width - 4; y: 66 }
                    PathLine { x: arms.width - 4; y: 80 }
                    PathLine { x: arms.width / 2; y: 46 }
                    PathLine { x: 4; y: 80 }
                    PathLine { x: 4; y: 66 }
                }
            }

            Repeater {
                model: [{ x: 21, y: 18 }, { x: 63, y: 18 }, { x: 42, y: 70 }]

                Text {
                    required property var modelData

                    x: modelData.x - width / 2
                    y: modelData.y - height / 2
                    text: "⚜"
                    color: Theme.oatmeal
                    font.family: Theme.iconFont
                    font.pixelSize: 17
                }
            }
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            topPadding: 6
            text: "PRIVATE ESTATE"
            color: Theme.brass
            font.family: Theme.displayFont
            font.pixelSize: Theme.fontMedium
            font.weight: Font.DemiBold
            font.letterSpacing: 6
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: Qt.formatDateTime(clock.date, "HH:mm")
            color: Theme.text
            font.family: Theme.displayFont
            font.pixelSize: 104
            font.weight: Font.Medium
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            bottomPadding: 26
            text: Qt.formatDateTime(clock.date, "dddd d MMMM yyyy")
            color: Theme.textMuted
            font.family: Theme.displayFont
            font.pixelSize: 20
            font.italic: true
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 300
            height: 44
            radius: Theme.radius
            color: Theme.popupBackground
            border.width: 1
            border.color: root.lock.failed
                ? Theme.borderCritical
                : (passwordField.activeFocus ? Theme.borderFocus : Theme.border)

            Stitching {}

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
                    return "Checking with the butler..."
                return root.lock.failed ? "Wrong password" : "The gates are shut. State your business."
            }
            color: root.lock.failed ? Theme.textCritical : Theme.textSubtle
            font.family: Theme.displayFont
            font.pixelSize: Theme.fontLarge
            font.italic: true
        }
    }
}
