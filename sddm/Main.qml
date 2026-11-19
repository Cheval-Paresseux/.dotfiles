import QtQuick
import QtQuick.Effects
import QtQuick.Shapes
import QtMultimedia

// Login screen: one of the live wallpapers (picked at random), with the clock, session and login in the corners.
// Each wallpaper brings its own accent colour (theme.conf); the rest is the base theme's neutrals.
Rectangle {
    id: root

    readonly property color crust: "#111111"
    readonly property color text: "#f2f2f2"
    readonly property color warning: "#ecd06f"
    readonly property color critical: "#f7768e"

    // SDDM reads a comma-separated value as a list; String() joins it back either way
    readonly property var videos: String(config.videos).split(",")
    readonly property var accents: String(config.accents).split(",")
    readonly property int pick: Math.floor(Math.random() * videos.length)
    readonly property string video: videos[pick]
    readonly property color accent: accents[pick] || "#73daca"
    // Sizes are designed for 1080p and grow with the screen
    readonly property real u: Math.max(1, height / 1080)
    readonly property real margin: 72 * u

    property int userIndex: userModel.lastIndex
    property int sessionIndex: sessionModel.lastIndex
    // count makes the lookups re-run once the repeaters are filled
    readonly property Item user: users.count ? users.itemAt(userIndex) : null
    readonly property Item session: sessions.count ? sessions.itemAt(sessionIndex) : null
    property bool failed: false

    function glyph(code) {
        return String.fromCodePoint(code)
    }

    function cycle(index, count, step) {
        return (index + step + count) % count
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
        anchors.fill: parent
        source: Qt.resolvedUrl(root.video)
        fillMode: VideoOutput.PreserveAspectCrop
        loops: MediaPlayer.Infinite
        muted: true
        autoPlay: true
    }

    // Vignette: settles the edges and the corners where the interface sits
    Shape {
        anchors.fill: parent

        ShapePath {
            strokeWidth: -1
            fillGradient: RadialGradient {
                centerX: root.width / 2
                centerY: root.height * 0.45
                centerRadius: Math.hypot(root.width, root.height) * 0.55
                focalX: centerX
                focalY: centerY
                GradientStop { position: 0.45; color: "transparent" }
                GradientStop { position: 1.0; color: Qt.alpha(root.crust, 0.7) }
            }
            PathRectangle { width: root.width; height: root.height }
        }
    }

    // Everything drawn over the wallpaper fades in once the greeter is up
    Item {
        anchors.fill: parent
        opacity: 0
        Component.onCompleted: opacity = 1

        Behavior on opacity {
            NumberAnimation { duration: 1200; easing.type: Easing.OutCubic }
        }

        Column {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: root.margin
            spacing: 10 * root.u
            layer.enabled: true
            layer.effect: Shadow {}

            Text {
                id: clock

                // The thin weight's side bearing pushes the digits right; pull them back onto the margin
                x: -16 * root.u
                textFormat: Text.StyledText
                color: root.text
                font.family: "Noto Sans"
                font.weight: Font.Thin
                font.pixelSize: 168 * root.u
                font.letterSpacing: -4 * root.u
            }

            Caption {
                id: date
            }

            Timer {
                running: true
                repeat: true
                triggeredOnStart: true
                interval: 1000
                onTriggered: {
                    const now = new Date()
                    clock.text = Qt.formatTime(now, "HH") + "<font color='" + root.accent + "'>:</font>" + Qt.formatTime(now, "mm")
                    date.text = Qt.formatDate(now, "dddd  ·  d MMMM")
                }
            }
        }

        // Session: the arrows (or a click on the name) cycle through the sessions
        Column {
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins: root.margin
            spacing: 12 * root.u
            layer.enabled: true
            layer.effect: Shadow {}

            Caption {
                text: "Session"
            }

            Row {
                spacing: 14 * root.u

                IconButton {
                    anchors.verticalCenter: parent.verticalCenter
                    visible: sessionModel.count > 1
                    icon: root.glyph(0xF0141)
                    onClicked: root.sessionIndex = root.cycle(root.sessionIndex, sessionModel.count, -1)
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: root.session ? root.session.name : ""
                    color: root.text
                    font.family: "Noto Sans"
                    font.weight: Font.Light
                    font.pixelSize: 20 * root.u

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.sessionIndex = root.cycle(root.sessionIndex, sessionModel.count, 1)
                    }
                }

                IconButton {
                    anchors.verticalCenter: parent.verticalCenter
                    visible: sessionModel.count > 1
                    icon: root.glyph(0xF0142)
                    onClicked: root.sessionIndex = root.cycle(root.sessionIndex, sessionModel.count, 1)
                }
            }
        }

        Column {
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: root.margin
            spacing: 12 * root.u
            layer.enabled: true
            layer.effect: Shadow {}

            Caption {
                anchors.right: parent.right
                text: root.failed ? "Wrong password" : (keyboard.capsLock ? "Caps Lock is on" : "Welcome back")
                lineColor: root.failed ? root.critical : (keyboard.capsLock ? root.warning : root.accent)
            }

            // The name cycles through the users when there are several
            Row {
                anchors.right: parent.right
                spacing: 14 * root.u

                IconButton {
                    anchors.verticalCenter: parent.verticalCenter
                    visible: userModel.count > 1
                    icon: root.glyph(0xF0141)
                    onClicked: root.userIndex = root.cycle(root.userIndex, userModel.count, -1)
                }

                Text {
                    text: root.user ? root.user.realName || root.user.name : ""
                    color: root.text
                    font.family: "Noto Sans"
                    font.weight: Font.Light
                    font.pixelSize: 40 * root.u
                }

                IconButton {
                    anchors.verticalCenter: parent.verticalCenter
                    visible: userModel.count > 1
                    icon: root.glyph(0xF0142)
                    onClicked: root.userIndex = root.cycle(root.userIndex, userModel.count, 1)
                }
            }

            Item {
                width: 1
                height: 8 * root.u
            }

            Row {
                anchors.right: parent.right
                spacing: 12 * root.u

                // Dark glass pill: reads on bright frames, the wallpaper stays visible through it
                Rectangle {
                    width: 340 * root.u
                    height: 52 * root.u
                    radius: height / 2
                    color: Qt.alpha(root.crust, password.activeFocus ? 0.45 : 0.35)
                    border.width: 1
                    border.color: root.failed ? root.critical
                        : (password.text !== "" ? Qt.alpha(root.accent, 0.8) : Qt.alpha(root.text, 0.25))
                    transform: Translate { id: shakeOffset }

                    Behavior on border.color {
                        ColorAnimation { duration: 200 }
                    }

                    SequentialAnimation {
                        id: shake

                        loops: 2
                        NumberAnimation { target: shakeOffset; property: "x"; to: -10; duration: 45 }
                        NumberAnimation { target: shakeOffset; property: "x"; to: 10; duration: 90 }
                        NumberAnimation { target: shakeOffset; property: "x"; to: 0; duration: 45 }
                    }

                    TextInput {
                        id: password

                        anchors.fill: parent
                        anchors.leftMargin: 24 * root.u
                        anchors.rightMargin: 56 * root.u
                        verticalAlignment: TextInput.AlignVCenter
                        echoMode: TextInput.Password
                        passwordCharacter: "●"
                        color: root.text
                        selectionColor: Qt.alpha(root.accent, 0.4)
                        font.family: "Noto Sans"
                        font.pixelSize: 14 * root.u
                        font.letterSpacing: 4 * root.u
                        clip: true
                        focus: true
                        onTextChanged: if (text !== "") root.failed = false
                        onAccepted: root.login()
                        Keys.onEscapePressed: text = ""

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            visible: password.text === ""
                            text: "Password"
                            color: Qt.alpha(root.text, 0.7)
                            font.family: "Noto Sans"
                            font.weight: Font.Light
                            font.pixelSize: 17 * root.u
                        }
                    }

                    // Submit: lights up in the accent once there is something to send
                    Rectangle {
                        anchors.right: parent.right
                        anchors.rightMargin: 7 * root.u
                        anchors.verticalCenter: parent.verticalCenter
                        width: 38 * root.u
                        height: width
                        radius: width / 2
                        color: password.text !== "" ? root.accent : Qt.alpha(root.text, 0.12)

                        Behavior on color {
                            ColorAnimation { duration: 200 }
                        }

                        Text {
                            anchors.centerIn: parent
                            text: root.glyph(0xF0054)
                            color: password.text !== "" ? root.crust : Qt.alpha(root.text, 0.7)
                            font.family: "MesloLGM Nerd Font"
                            font.pixelSize: 18 * root.u
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.login()
                        }
                    }
                }

                RoundButton {
                    visible: sddm.canReboot
                    icon: root.glyph(0xF0709)
                    onClicked: sddm.reboot()
                }

                RoundButton {
                    visible: sddm.canPowerOff
                    icon: root.glyph(0xF0425)
                    hoverColor: root.critical
                    onClicked: sddm.powerOff()
                }
            }
        }
    }

    // Soft shadow under the corner groups, for bright frames
    component Shadow: MultiEffect {
        shadowEnabled: true
        shadowColor: root.crust
        shadowOpacity: 0.8
        shadowBlur: 1.0
        shadowVerticalOffset: 1
    }

    // Small spaced-out uppercase label led by a short line in the accent
    component Caption: Row {
        property alias text: label.text
        property alias lineColor: line.color

        spacing: 14 * root.u

        Rectangle {
            id: line

            anchors.verticalCenter: parent.verticalCenter
            width: 28 * root.u
            height: Math.max(1, 2 * root.u)
            radius: height / 2
            color: root.accent
        }

        Text {
            id: label

            color: root.text
            opacity: 0.95
            font.family: "Noto Sans"
            font.weight: Font.Medium
            font.pixelSize: 13 * root.u
            font.letterSpacing: 4 * root.u
            font.capitalization: Font.AllUppercase
        }
    }

    component IconButton: Text {
        id: iconButton

        property string icon
        signal clicked()

        text: icon
        color: mouse.containsMouse ? root.accent : Qt.alpha(root.text, 0.7)
        font.family: "MesloLGM Nerd Font"
        font.pixelSize: 18 * root.u

        MouseArea {
            id: mouse

            anchors.fill: parent
            anchors.margins: -8
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: iconButton.clicked()
        }
    }

    // Circle the height of the password pill
    component RoundButton: Rectangle {
        id: roundButton

        property string icon
        property color hoverColor: root.text
        signal clicked()

        width: 52 * root.u
        height: width
        radius: width / 2
        color: area.containsMouse ? Qt.alpha(hoverColor, 0.85) : Qt.alpha(root.crust, 0.35)
        border.width: 1
        border.color: area.containsMouse ? "transparent" : Qt.alpha(root.text, 0.25)

        Behavior on color {
            ColorAnimation { duration: 150 }
        }

        Text {
            anchors.centerIn: parent
            text: roundButton.icon
            color: area.containsMouse ? root.crust : root.text
            font.family: "MesloLGM Nerd Font"
            font.pixelSize: 20 * root.u
        }

        MouseArea {
            id: area

            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: roundButton.clicked()
        }
    }
}
