import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects
import qs.components
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
        id: wallpaper

        anchors.fill: parent
        source: Settings.wallpaper
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        visible: false
    }

    // Out of focus, so the signage reads on any wallpaper
    MultiEffect {
        anchors.fill: parent
        source: wallpaper
        blurEnabled: true
        blur: 0.6
        blurMax: 32
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

        SvgIcon {
            anchors.horizontalCenter: parent.horizontalCenter
            name: "portico"
            size: 72
            color: Theme.accent
            layer.enabled: true
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor: Theme.accent
                shadowBlur: 1
                shadowHorizontalOffset: 0
                shadowVerticalOffset: 0
            }
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            topPadding: 8
            text: "CORUSCANT EXCHANGE"
            color: Theme.accent
            font.family: Theme.displayFont
            font.pixelSize: Theme.fontLarge
            font.weight: Font.Medium
            font.letterSpacing: 8
        }

        // Engraved ornament: a gold hairline either side of a diamond
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                width: 70
                height: 1
                color: Qt.alpha(Theme.accent, 0.6)
            }

            Text {
                text: "◆"
                color: Theme.accent
                font.pixelSize: Theme.fontSmall
            }

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                width: 70
                height: 1
                color: Qt.alpha(Theme.accent, 0.6)
            }
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: Qt.formatDateTime(clock.date, "HH:mm")
            color: Theme.text
            font.family: Theme.displayFont
            font.pixelSize: 96
            font.weight: Font.Light
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: Qt.formatDateTime(clock.date, "dddd d MMMM yyyy").toUpperCase()
            color: Theme.textMuted
            font.family: Theme.displayFont
            font.pixelSize: Theme.fontMedium
            font.letterSpacing: 4
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            bottomPadding: 24
            text: "TRADING SUSPENDED"
            color: Theme.textSubtle
            font.family: Theme.displayFont
            font.pixelSize: Theme.fontSmall
            font.letterSpacing: 4
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
                    text: "Trader credentials"
                    color: Theme.textDisabled
                    font.pixelSize: Theme.fontInput
                }
            }
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.lock.authenticating ? "Verifying credentials..." : (root.lock.failed ? "Credentials rejected" : " ")
            color: root.lock.failed ? Theme.textCritical : Theme.textSubtle
            font.pixelSize: Theme.fontNormal
        }
    }
}
