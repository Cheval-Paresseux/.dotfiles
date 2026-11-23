import Quickshell
import Quickshell.Wayland
import QtQuick
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

    // 無限 (mugen, "without limit") over a red sun holding the hour, like the suns of the wallpapers
    Column {
        anchors.centerIn: parent
        spacing: 14

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "無限"
            color: Theme.text
            font.family: Theme.kanjiFont
            font.pixelSize: 34
            font.weight: Font.Black
            font.letterSpacing: 12
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 260
            height: width
            radius: width / 2
            color: Theme.accent

            Text {
                anchors.centerIn: parent
                text: Qt.formatDateTime(clock.date, "HH:mm")
                color: Theme.textOnAccent
                font.family: Theme.kanjiFont
                font.pixelSize: 76
                font.weight: Font.Black
            }
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            bottomPadding: 18
            text: Qt.formatDateTime(clock.date, "dddd d MMMM")
            color: Theme.text
            font.family: Theme.kanjiFont
            font.pixelSize: Theme.fontInput + 2
            font.weight: Font.Bold
        }

        // The password is written on a stroke of ink, which turns red when it is wrong
        Item {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 280
            height: 40

            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 2
                color: root.lock.failed ? Theme.critical : (passwordField.text !== "" ? Theme.accent : Theme.text)
            }

            TextInput {
                id: passwordField

                anchors.fill: parent
                verticalAlignment: TextInput.AlignVCenter
                horizontalAlignment: TextInput.AlignHCenter
                focus: true
                readOnly: root.lock.authenticating
                echoMode: TextInput.Password
                passwordCharacter: "•"
                color: Theme.text
                selectionColor: Theme.selection
                selectedTextColor: Theme.selectionText
                font.pixelSize: Theme.fontInput + 2
                font.letterSpacing: 4
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
                    color: Theme.textSubtle
                    font.pixelSize: Theme.fontInput
                    font.italic: true
                }
            }
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.lock.authenticating ? "Authenticating..."
                : (root.lock.failed ? "Wrong password" : "Dozed off. Say the word and he gets up.")
            color: root.lock.failed ? Theme.textCritical : Theme.textSubtle
            font.pixelSize: Theme.fontNormal
        }
    }
}
