import QtQuick
import QtQuick.Effects
import QtQuick.Shapes
import QtMultimedia

// Login screen: one of the samurai live wallpapers (picked at random), with the interface in the empty right half.
// Ink on paper: each wallpaper sets the ink (text) and the paper (wash and shadow), so the same layout reads on
// the white ink painting and on the night under the red moon. The accent is a vermilion seal: the hanko signs you in.
Rectangle {
    id: root

    readonly property color warning: "#c8902e"
    readonly property string font: "Noto Serif"
    readonly property string kanjiFont: "Noto Sans CJK JP"

    // SDDM reads a comma-separated value as a list; String() joins it back either way
    readonly property var videos: String(config.videos).split(",")
    readonly property int pick: Math.floor(Math.random() * videos.length)
    readonly property string video: videos[pick]
    readonly property color ink: String(config.inks).split(",")[pick] || "#1b1916"
    readonly property color paper: String(config.papers).split(",")[pick] || "#eeebe5"
    readonly property color accent: String(config.accents).split(",")[pick] || "#c0352a"
    // Sizes are designed for 1080p and grow with the screen
    readonly property real u: Math.max(1, height / 1080)
    readonly property real margin: 80 * u

    property int userIndex: userModel.lastIndex
    property int sessionIndex: sessionModel.lastIndex
    // count makes the lookups re-run once the repeaters are filled
    readonly property Item user: users.count ? users.itemAt(userIndex) : null
    readonly property Item session: sessions.count ? sessions.itemAt(sessionIndex) : null
    property bool failed: false

    function cycle(index, count, step) {
        return (index + step + count) % count
    }

    // 1 to 31 in kanji numerals: 十一, 二十三
    function kanji(n) {
        const digits = ["", "一", "二", "三", "四", "五", "六", "七", "八", "九"]
        const tens = Math.floor(n / 10)
        return (tens > 1 ? digits[tens] : "") + (tens ? "十" : "") + digits[n % 10]
    }

    function login() {
        if (user && password.text !== "") {
            stamp.restart()
            sddm.login(user.name, password.text, sessionIndex)
        }
    }

    width: 1920
    height: 1080
    color: paper

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
        source: Qt.resolvedUrl("videos/" + root.video)
        fillMode: VideoOutput.PreserveAspectCrop
        loops: MediaPlayer.Infinite
        muted: true
        autoPlay: true
    }

    // A wash of paper from the right edge, where the interface sits; the samurai on the left stays untouched
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.45; color: "transparent" }
            GradientStop { position: 1.0; color: Qt.alpha(root.paper, 0.7) }
        }
    }

    // Everything drawn over the wallpaper fades in once the greeter is up, like ink soaking into paper
    Item {
        anchors.fill: parent
        opacity: 0
        Component.onCompleted: opacity = 1

        Behavior on opacity {
            NumberAnimation { duration: 1600; easing.type: Easing.OutCubic }
        }

        // The clock, and the date written the Japanese way: in columns, read from the right
        Row {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: root.margin
            spacing: 28 * root.u
            layer.enabled: true
            layer.effect: Glow {}

            Column {
                spacing: 6 * root.u

                Text {
                    id: clock

                    anchors.right: parent.right
                    textFormat: Text.StyledText
                    color: root.ink
                    font.family: root.font
                    font.weight: Font.Thin
                    font.pixelSize: 140 * root.u
                    font.features: { "lnum": 1, "tnum": 1 }
                }

                Text {
                    id: date

                    anchors.right: parent.right
                    color: Qt.alpha(root.ink, 0.75)
                    font.family: root.font
                    font.italic: true
                    font.pixelSize: 22 * root.u
                    font.letterSpacing: 1 * root.u
                }
            }

            // Hairline between the two scripts, as on a hanging scroll
            Rectangle {
                width: Math.max(1, root.u)
                height: kanjiDate.height
                y: 14 * root.u
                color: Qt.alpha(root.ink, 0.35)
            }

            Row {
                id: kanjiDate

                y: 14 * root.u
                spacing: 6 * root.u

                Repeater {
                    id: columns

                    delegate: Text {
                        required property string modelData
                        required property int index

                        text: modelData.split("").join("\n")
                        color: index === 0 ? root.accent : root.ink
                        horizontalAlignment: Text.AlignHCenter
                        lineHeight: 1.05
                        font.family: root.kanjiFont
                        font.weight: Font.Light
                        font.pixelSize: 24 * root.u
                    }
                }
            }

            Timer {
                running: true
                repeat: true
                triggeredOnStart: true
                interval: 1000
                onTriggered: {
                    const now = new Date()
                    clock.text = Qt.formatTime(now, "HH") + "<font color='" + root.accent + "'>:</font>" + Qt.formatTime(now, "mm")
                    date.text = Qt.formatDate(now, "dddd, d MMMM")
                    // Columns run right to left: the weekday, then the month and day
                    columns.model = ["日月火水木金土"[now.getDay()] + "曜日",
                                     root.kanji(now.getMonth() + 1) + "月" + root.kanji(now.getDate()) + "日"]
                }
            }
        }

        // Session and power in one quiet line under the login: the arrows (or a click on the name) cycle the sessions
        Row {
            id: footer

            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: root.margin
            spacing: 14 * root.u
            layer.enabled: true
            layer.effect: Glow {}

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: "道"
                color: root.accent
                font.family: root.kanjiFont
                font.weight: Font.Medium
                font.pixelSize: 18 * root.u
            }

            Chevron {
                visible: sessionModel.count > 1
                text: "‹"
                onClicked: root.sessionIndex = root.cycle(root.sessionIndex, sessionModel.count, -1)
            }

            Link {
                anchors.verticalCenter: parent.verticalCenter
                text: root.session ? root.session.name : ""
                onClicked: root.sessionIndex = root.cycle(root.sessionIndex, sessionModel.count, 1)
            }

            Chevron {
                visible: sessionModel.count > 1
                text: "›"
                onClicked: root.sessionIndex = root.cycle(root.sessionIndex, sessionModel.count, 1)
            }

            Item {
                width: 18 * root.u
                height: 1
            }

            Link {
                anchors.verticalCenter: parent.verticalCenter
                visible: sddm.canReboot
                text: "Restart"
                onClicked: sddm.reboot()
            }

            Link {
                anchors.verticalCenter: parent.verticalCenter
                visible: sddm.canPowerOff
                text: "Shut down"
                onClicked: sddm.powerOff()
            }
        }

        // Login: the name, a brush stroke to write the password on, and the seal to sign with
        Column {
            anchors.right: parent.right
            anchors.rightMargin: root.margin
            anchors.bottom: footer.top
            anchors.bottomMargin: 56 * root.u
            spacing: 14 * root.u
            layer.enabled: true
            layer.effect: Glow {}

            Caption {
                anchors.right: parent.right
                kanji: root.failed ? "否" : (keyboard.capsLock ? "注" : "名")
                text: root.failed ? "Wrong password" : (keyboard.capsLock ? "Caps Lock is on" : "Who comes")
                kanjiColor: root.failed ? root.accent : (keyboard.capsLock ? root.warning : root.accent)
            }

            // The name cycles through the users when there are several
            Row {
                anchors.right: parent.right
                spacing: 16 * root.u

                Chevron {
                    visible: userModel.count > 1
                    text: "‹"
                    onClicked: root.userIndex = root.cycle(root.userIndex, userModel.count, -1)
                }

                Text {
                    text: root.user ? root.user.realName || root.user.name : ""
                    color: root.ink
                    font.family: root.font
                    font.weight: Font.Light
                    font.pixelSize: 46 * root.u
                }

                Chevron {
                    visible: userModel.count > 1
                    text: "›"
                    onClicked: root.userIndex = root.cycle(root.userIndex, userModel.count, 1)
                }
            }

            Row {
                anchors.right: parent.right
                spacing: 22 * root.u

                Item {
                    id: field

                    width: 340 * root.u
                    height: 56 * root.u
                    transform: Translate { id: shakeOffset }

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
                        anchors.leftMargin: 8 * root.u
                        anchors.rightMargin: 8 * root.u
                        verticalAlignment: TextInput.AlignVCenter
                        echoMode: TextInput.Password
                        passwordCharacter: "•"
                        color: root.ink
                        selectionColor: Qt.alpha(root.accent, 0.4)
                        font.family: root.font
                        font.pixelSize: 22 * root.u
                        font.letterSpacing: 6 * root.u
                        clip: true
                        focus: true
                        onTextChanged: if (text !== "") root.failed = false
                        onAccepted: root.login()
                        Keys.onEscapePressed: text = ""

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            visible: password.text === ""
                            text: "Password"
                            color: Qt.alpha(root.ink, 0.55)
                            font.family: root.font
                            font.italic: true
                            font.pixelSize: 22 * root.u
                        }
                    }

                    // A single brush stroke, thin at both ends: ink at rest, vermilion while typing
                    Shape {
                        id: stroke

                        readonly property color color: root.failed || password.text !== "" ? root.accent : Qt.alpha(root.ink, 0.6)

                        anchors.bottom: parent.bottom
                        width: parent.width
                        height: 5 * root.u
                        preferredRendererType: Shape.CurveRenderer

                        ShapePath {
                            strokeWidth: -1
                            fillColor: stroke.color
                            startX: 0
                            startY: stroke.height * 0.6
                            PathQuad { x: stroke.width; y: stroke.height * 0.4; controlX: stroke.width * 0.3; controlY: -stroke.height * 0.3 }
                            PathQuad { x: 0; y: stroke.height * 0.6; controlX: stroke.width * 0.45; controlY: stroke.height * 1.4 }
                        }
                    }
                }

                // The hanko: a vermilion seal with 入 (enter), stamped to sign in
                Rectangle {
                    id: seal

                    readonly property bool active: password.text !== "" || sealArea.containsMouse

                    anchors.bottom: field.bottom
                    width: 56 * root.u
                    height: width
                    radius: 5 * root.u
                    rotation: -4
                    color: active ? root.accent : Qt.alpha(root.accent, 0.8)
                    scale: sealArea.containsMouse ? 1.06 : 1

                    Behavior on color {
                        ColorAnimation { duration: 200 }
                    }

                    Behavior on scale {
                        NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
                    }

                    SequentialAnimation {
                        id: stamp

                        NumberAnimation { target: seal; property: "scale"; to: 0.86; duration: 90; easing.type: Easing.InQuad }
                        NumberAnimation { target: seal; property: "scale"; to: 1; duration: 260; easing.type: Easing.OutBack }
                    }

                    // The seal's carved border
                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 4 * root.u
                        radius: 3 * root.u
                        color: "transparent"
                        border.width: Math.max(1, 1.5 * root.u)
                        border.color: Qt.alpha(root.paper, 0.85)
                    }

                    Text {
                        anchors.centerIn: parent
                        text: "入"
                        color: root.paper
                        font.family: root.kanjiFont
                        font.weight: Font.Bold
                        font.pixelSize: 28 * root.u
                    }

                    MouseArea {
                        id: sealArea

                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.login()
                    }
                }
            }
        }
    }

    // A soft halo of paper under the interface, so the ink reads over brush strokes and bright frames
    component Glow: MultiEffect {
        shadowEnabled: true
        shadowColor: root.paper
        shadowOpacity: 0.9
        shadowBlur: 1.0
    }

    // A kanji in the accent, a short brush line, and a small label in spaced capitals
    component Caption: Row {
        id: caption

        property string kanji
        property alias text: label.text
        property color kanjiColor: root.accent

        spacing: 12 * root.u

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: caption.kanji
            color: caption.kanjiColor
            font.family: root.kanjiFont
            font.weight: Font.Medium
            font.pixelSize: 20 * root.u
        }

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width: 26 * root.u
            height: Math.max(1, root.u)
            color: Qt.alpha(root.ink, 0.5)
        }

        Text {
            id: label

            anchors.verticalCenter: parent.verticalCenter
            color: Qt.alpha(root.ink, 0.8)
            font.family: root.font
            font.pixelSize: 14 * root.u
            font.letterSpacing: 4 * root.u
            font.capitalization: Font.AllUppercase
        }
    }

    // Plain text that takes the accent under the pointer
    component Link: Text {
        id: link

        property int size: 17
        readonly property bool hovered: mouse.containsMouse
        signal clicked()

        color: hovered ? root.accent : Qt.alpha(root.ink, 0.85)
        font.family: root.font
        font.pixelSize: size * root.u

        Behavior on color {
            ColorAnimation { duration: 150 }
        }

        MouseArea {
            id: mouse

            anchors.fill: parent
            anchors.margins: -6 * root.u
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: link.clicked()
        }
    }

    component Chevron: Link {
        anchors.verticalCenter: parent.verticalCenter
        size: 30
        color: hovered ? root.accent : Qt.alpha(root.ink, 0.6)
    }
}
