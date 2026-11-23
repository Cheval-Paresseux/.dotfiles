import Quickshell.Services.Mpris
import QtQuick
import qs.config

// The record on the turntable: title and artist of what is playing, in italics.
// Click to pause or play, scroll to change track; hidden when nothing is loaded.
Item {
    id: root

    readonly property MprisPlayer player: Mpris.players.values.find(p => p.isPlaying) ?? Mpris.players.values[0] ?? null
    readonly property bool playing: player?.isPlaying ?? false

    visible: player !== null && player.trackTitle !== ""
    implicitWidth: row.implicitWidth
    implicitHeight: Theme.barHeight

    Row {
        id: row

        anchors.verticalCenter: parent.verticalCenter
        spacing: 6

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: Icons.record
            color: root.playing ? Theme.accent : Theme.textDisabled
            font.family: Theme.iconFont
            font.pixelSize: Theme.iconSize

            RotationAnimation on rotation {
                running: root.playing
                loops: Animation.Infinite
                from: 0
                to: 360
                duration: 1800 // 33⅓ turns a minute
            }
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            width: Math.min(implicitWidth, 260)
            text: root.player ? [root.player.trackTitle, root.player.trackArtist].filter(s => s).join(" · ") : ""
            textFormat: Text.PlainText
            color: mouseArea.containsMouse ? Theme.text : (root.playing ? Theme.textMuted : Theme.textDisabled)
            font.family: Theme.displayFont
            font.variableAxes: Theme.displayAxes
            font.pixelSize: Theme.fontLarge
            font.italic: true
            elide: Text.ElideRight
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.player.togglePlaying()
        onWheel: wheel => {
            if (wheel.angleDelta.y < 0 && root.player.canGoNext)
                root.player.next()
            else if (wheel.angleDelta.y > 0 && root.player.canGoPrevious)
                root.player.previous()
        }
    }
}
