import Quickshell
import Quickshell.Io
import QtQuick
import qs.config
import qs.services

PickerWindow {
    id: root

    readonly property var directories: [
        Theme.wallpaperDirectory,
        Quickshell.env("HOME") + "/Pictures/Wallpapers"
    ]

    property var wallpapers: []
    readonly property var results: query
        ? wallpapers.filter(path => fileName(path).toLowerCase().includes(query))
        : wallpapers

    name: "wallpaper"
    placeholder: "Search the snowfields..."
    panelWidth: 760

    onQueryChanged: grid.currentIndex = 0
    onOpened: scanProcess.running = true
    onKeyPressed: event => event.accepted = grid.handleKey(event)

    function fileName(path) {
        return path.slice(path.lastIndexOf("/") + 1)
    }

    function apply(path) {
        Settings.setWallpaper(path)
        close()
    }

    function load(output) {
        wallpapers = output.split("\n")
            .filter(path => path !== "")
            .sort((a, b) => fileName(a).localeCompare(fileName(b)))
        grid.currentIndex = Math.max(0, results.indexOf(Settings.wallpaperPath))
        grid.positionViewAtIndex(grid.currentIndex, GridView.Contain)
    }

    Process {
        id: scanProcess

        command: ["sh", "-c",
            'for d in "$@"; do [ -d "$d" ] && find -L "$d" -maxdepth 1 -type f '
            + '\\( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \\); done; true',
            "sh", ...root.directories]
        stdout: StdioCollector {
            onStreamFinished: root.load(this.text)
        }
    }

    PickerGrid {
        id: grid

        anchors.fill: parent
        anchors.bottomMargin: hint.height + 6
        model: root.results
        labelOf: path => root.fileName(path)
        isCurrent: path => path === Settings.wallpaperPath
        emptyText: root.wallpapers.length === 0
            ? "No wallpapers found.\nAdd images to ~/Pictures/Wallpapers"
            : "No matching wallpapers"
        onActivated: path => root.apply(path)
    }

    Text {
        id: hint

        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Arrows: navigate  ·  Enter: apply  ·  ~/Pictures/Wallpapers"
        color: Theme.textDisabled
        font.pixelSize: Theme.fontSmall
    }
}
