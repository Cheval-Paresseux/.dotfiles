import QtQuick
import QtQuick.Effects
import QtMultimedia

// Login screen: one of the live wallpapers (picked at random), with the clock, session and login in the corners.
// Colours are the base theme's palette.
Rectangle {
    id: root

    readonly property color crust: "#111111"
    readonly property color text: "#e6e6e6"
    readonly property color accent: "#73daca"
    readonly property color warning: "#ecd06f"
    readonly property color critical: "#f7768e"

    // SDDM reads a comma-separated value as a list; String() joins it back either way
    readonly property var videos: String(config.videos).split(",")
    readonly property string video: videos[Math.floor(Math.random() * videos.length)]
    // Sizes are designed for 1080p and grow with the screen
    readonly property real u: Math.max(1, height / 1080)
    readonly property real margin: 56 * u

    property int userIndex: userModel.lastIndex
    property int sessionIndex: sessionModel.lastIndex
    // count makes the lookups re-run once the repeaters are filled
    readonly property Item user: users.count ? users.itemAt(userIndex) : null
    readonly property Item session: sessions.count ? sessions.itemAt(sessionIndex) : null
    property bool failed: false

    function glyph(code) {
        return String.fromCodePoint(code)
    }

    function nextSession() {
        sessionIndex = (sessionIndex + 1) % sessionModel.count
    }

    function login() {
        if (user && password.text !== "")
            sddm.login(user.name, password.text, sessionIndex)
    }

    width: 1920
    height: 1080
    color: crust

    Repeater {
        id: users

        model: userModel
        delegate: Item {
            required property string name
            required property string realName
        }
    }

    Repeater {
        id: sessions

        model: sessionModel
        delegate: Item {
            required property string name
        }
    }

    Connections {
        target: sddm

        function onLoginFailed() {
            root.failed = true
            password.text = ""
            shake.restart()
        }
    }

    // The poster is the video's first frame: it shows while the video loads, and stays if playback fails
    Image {
        anchors.fill: parent
        source: "posters/" + root.video.split(".")[0] + ".jpg"
        fillMode: Image.PreserveAspectCrop
    }

    Video {
        id: background

        anchors.fill: parent
        source: Qt.resolvedUrl(root.video)
        fillMode: VideoOutput.PreserveAspectCrop
        loops: MediaPlayer.Infinite
        muted: true
        autoPlay: true
    }

    // Light shading behind the corners keeps the text readable on bright frames
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: Qt.alpha(root.crust, 0.35) }
            GradientStop { position: 0.25; color: "transparent" }
            GradientStop { position: 0.7; color: "transparent" }
            GradientStop { position: 1.0; color: Qt.alpha(root.crust, 0.55) }
        }
    }

    Column {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: root.margin
        layer.enabled: true
        layer.effect: Shadow {}

        Text {
            id: clock

            color: root.text
            font.family: "Noto Sans"
            font.weight: Font.Light
            font.pixelSize: 88 * root.u
        }

        Text {
            id: date

            leftPadding: 4 * root.u
            color: root.text
            opacity: 0.9
            font.family: "Noto Sans"
            font.pixelSize: 20 * root.u
        }

        Timer {
            running: true
            repeat: true
            triggeredOnStart: true
            interval: 1000
            onTriggered: {
                const now = new Date()
                clock.text = Qt.formatTime(now, "HH:mm")
                date.text = Qt.formatDate(now, "dddd d MMMM")
            }
        }
    }

    // Session: click to cycle
    Row {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: root.margin
        layer.enabled: true
        layer.effect: Shadow {}
        spacing: 10 * root.u

        IconButton {
            icon: root.glyph(0xF0379)
            onClicked: root.nextSession()
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: root.session ? root.session.name : ""
            color: root.text
            opacity: 0.9
            font.family: "Noto Sans"
            font.pixelSize: 15 * root.u

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.nextSession()
            }
        }
    }

    Column {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: root.margin
        layer.enabled: true
        layer.effect: Shadow {}
        spacing: 8 * root.u

        Text {
            anchors.right: parent.right
            text: root.failed ? "Wrong password" : (keyboard.capsLock ? "Caps Lock is on" : "")
            color: root.failed ? root.critical : root.warning
            font.family: "Noto Sans"
            font.pixelSize: 13 * root.u
        }

        // The name cycles through the users when there are several
        Row {
            anchors.right: parent.right
            spacing: 8 * root.u

            IconButton {
                visible: userModel.count > 1
                icon: root.glyph(0xF0141)
                font.pixelSize: 16 * root.u
                onClicked: root.userIndex = (root.userIndex + userModel.count - 1) % userModel.count
            }

            Text {
                text: root.user ? root.user.realName || root.user.name : ""
                color: root.text
                font.family: "Noto Sans"
                font.weight: Font.Medium
                font.pixelSize: 16 * root.u
            }

            IconButton {
                visible: userModel.count > 1
                icon: root.glyph(0xF0142)
                font.pixelSize: 16 * root.u
                onClicked: root.userIndex = (root.userIndex + 1) % userModel.count
            }
        }

        Row {
            anchors.right: parent.right
            spacing: 20 * root.u

            // Underlined field, no box: the wallpaper stays visible behind it
            Item {
                width: 260 * root.u
                height: 34 * root.u
                transform: Translate { id: shakeOffset }

                SequentialAnimation {
                    id: shake

                    loops: 2
                    NumberAnimation { target: shakeOffset; property: "x"; to: -8; duration: 40 }
                    NumberAnimation { target: shakeOffset; property: "x"; to: 8; duration: 80 }
                    NumberAnimation { target: shakeOffset; property: "x"; to: 0; duration: 40 }
                }

                TextInput {
                    id: password

                    anchors.fill: parent
                    anchors.rightMargin: 28 * root.u
                    verticalAlignment: TextInput.AlignVCenter
                    echoMode: TextInput.Password
                    passwordCharacter: "•"
                    color: root.text
                    selectionColor: Qt.alpha(root.accent, 0.35)
                    font.family: "Noto Sans"
                    font.pixelSize: 16 * root.u
                    clip: true
                    focus: true
                    onTextChanged: if (text !== "") root.failed = false
                    onAccepted: root.login()

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        visible: password.text === ""
                        text: "Password"
                        color: root.text
                        opacity: 0.7
                        font: password.font
                    }
                }

                IconButton {
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    icon: root.glyph(0xF0054)
                    font.pixelSize: 18 * root.u
                    color: password.text !== "" ? root.accent : Qt.alpha(root.text, 0.85)
                    onClicked: root.login()
                }

                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.width
                    height: Math.max(1, root.u)
                    color: root.failed ? root.critical : (password.text !== "" ? root.accent : Qt.alpha(root.text, 0.45))
                }
            }

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                visible: sddm.canReboot || sddm.canPowerOff
                width: 1
                height: 20 * root.u
                color: Qt.alpha(root.text, 0.3)
            }

            IconButton {
                anchors.verticalCenter: parent.verticalCenter
                visible: sddm.canReboot
                icon: root.glyph(0xF0709)
                onClicked: sddm.reboot()
            }

            IconButton {
                anchors.verticalCenter: parent.verticalCenter
                visible: sddm.canPowerOff
                icon: root.glyph(0xF0425)
                hoverColor: root.critical
                onClicked: sddm.powerOff()
            }
        }
    }

    // Soft shadow under the corner groups, for bright frames
    component Shadow: MultiEffect {
        shadowEnabled: true
        shadowColor: root.crust
        shadowOpacity: 0.9
        shadowBlur: 1.0
        shadowHorizontalOffset: 0
        shadowVerticalOffset: 1
    }

    component IconButton: Text {
        id: button

        property string icon
        property color hoverColor: root.text
        signal clicked()

        text: icon
        color: mouse.containsMouse ? hoverColor : Qt.alpha(root.text, 0.85)
        font.family: "MesloLGM Nerd Font"
        font.pixelSize: 22 * root.u

        MouseArea {
            id: mouse

            anchors.fill: parent
            anchors.margins: -6
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: button.clicked()
        }
    }
}
