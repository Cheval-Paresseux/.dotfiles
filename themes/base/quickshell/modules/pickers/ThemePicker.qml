import Quickshell
import Quickshell.Io
import QtQuick
import qs.config

PickerWindow {
    id: root

    readonly property string script: Quickshell.env("HOME") + "/.config/dotfiles/scripts/switch-theme.sh"

    property var themes: []
    readonly property var results: query ? themes.filter(theme => theme.name.includes(query)) : themes

    name: "theme"
    placeholder: "Search themes..."
    panelWidth: 880
    panelHeight: 262

    onQueryChanged: grid.currentIndex = 0
    onOpened: listProcess.running = true
    onKeyPressed: event => event.accepted = grid.handleKey(event)

    function apply(theme) {
        close()
        if (theme.name !== Theme.name)
            Quickshell.execDetached([script, theme.name]) // restarts Quickshell
    }

    // One "name<TAB>planet" line per theme
    function load(output) {
        themes = output.split("\n")
            .filter(line => line !== "")
            .map(line => ({ name: line.split("\t")[0], planet: line.split("\t")[1] }))
        grid.currentIndex = Math.max(0, results.findIndex(theme => theme.name === Theme.name))
    }

    Process {
        id: listProcess

        command: [root.script, "--list"]
        stdout: StdioCollector {
            onStreamFinished: root.load(this.text)
        }
    }

    PickerGrid {
        id: grid

        anchors.fill: parent
        anchors.bottomMargin: hint.height + 6
        columns: 6
        imageRatio: 1
        model: root.results
        imageOf: theme => theme.planet
        labelOf: theme => theme.name.toUpperCase()
        labelBold: true
        isCurrent: theme => theme.name === Theme.name
        emptyText: "No matching themes"
        onActivated: theme => root.apply(theme)
    }

    Text {
        id: hint

        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Arrows: navigate  ·  Enter: switch theme"
        color: Theme.textDisabled
        font.pixelSize: Theme.fontSmall
    }
}
