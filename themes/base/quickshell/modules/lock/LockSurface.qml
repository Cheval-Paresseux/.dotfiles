import Quickshell
import Quickshell.Wayland
import QtQuick
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

    MouseArea {
        anchors.fill: parent
        onClicked: passwordField.forceActiveFocus()
    }

    Column {
        anchors.centerIn: parent
        spacing: 8

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: Qt.formatDateTime(clock.date, "HH:mm")
            color: Theme.text
            font.pixelSize: 72
            font.bold: true
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            bottomPadding: 24
            text: Qt.formatDateTime(clock.date, "dddd d MMMM yyyy")
            color: Theme.textMuted
            font.pixelSize: Theme.fontInput
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 280
            height: 40
            radius: Theme.radius
            color: Theme.background
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
            text: root.lock.authenticating ? "Authenticating..." : (root.lock.failed ? "Wrong password" : " ")
            color: root.lock.failed ? Theme.textCritical : Theme.textSubtle
            font.pixelSize: Theme.fontNormal
        }
    }
}
