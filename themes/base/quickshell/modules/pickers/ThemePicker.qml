import Quickshell
import Quickshell.Io
import QtQuick
import qs.config

// One row per group of themes (star_wars, the_gentleman...), its name on the left
PickerWindow {
    id: root

    readonly property string script: Quickshell.env("HOME") + "/.dotfiles/scripts/switch-theme.sh"
    readonly property int columns: 5

    property var themes: []
    readonly property var results: query ? themes.filter(theme => theme.name.includes(query)) : themes
    // Consecutive themes of the same group, in the order of the list
    readonly property var groups: results.reduce((groups, theme) => {
        const last = groups[groups.length - 1]
        if (last?.name === theme.group)
            last.themes.push(theme)
        else
            groups.push({ name: theme.group, themes: [theme] })
        return groups
    }, [])
    // The grid's cells: each group fills whole rows, ending with empty cells (null)
    readonly property var cells: {
        const cells = []
        for (let g = 0; g < groups.length; g++) {
            for (let t = 0; t < groups[g].themes.length; t++)
                cells.push(groups[g].themes[t])
            while (cells.length % columns !== 0)
                cells.push(null)
        }
        return cells
    }

    name: "theme"
    placeholder: "Search themes..."
    panelWidth: 920
    panelHeight: 110 + grid.cellHeight * Math.max(1, cells.length / columns)

    onQueryChanged: grid.currentIndex = 0
    onOpened: listProcess.running = true
    onKeyPressed: event => event.accepted = grid.handleKey(event)

    function apply(theme) {
        close()
        if (theme.name !== Theme.name)
            Quickshell.execDetached([script, theme.name]) // restarts Quickshell
    }

    // One "name<TAB>emblem<TAB>group" line per theme
    function load(output) {
        themes = output.split("\n")
            .filter(line => line !== "")
            .map(line => line.split("\t"))
            .map(fields => ({ name: fields[0], emblem: fields[1], group: fields[2] }))
        grid.currentIndex = Math.max(0, cells.findIndex(theme => theme?.name === Theme.name))
    }

    Process {
        id: listProcess

        command: [root.script, "--list"]
        stdout: StdioCollector {
            onStreamFinished: root.load(this.text)
        }
    }

    Column {
        id: groupNames

        anchors.left: parent.left
        anchors.top: parent.top
        width: 140

        Repeater {
            model: root.groups

            delegate: Text {
                required property var modelData

                width: groupNames.width
                height: grid.cellHeight * Math.ceil(modelData.themes.length / root.columns)
                bottomPadding: 24
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                text: modelData.name.replace(/_/g, " ").toUpperCase()
                color: root.cells[grid.currentIndex]?.group === modelData.name ? Theme.accent : Theme.textSubtle
                font.pixelSize: Theme.fontSmall
                font.bold: true
                font.letterSpacing: 2
            }
        }
    }

    PickerGrid {
        id: grid

        anchors.fill: parent
        anchors.leftMargin: groupNames.width
        anchors.bottomMargin: hint.height + 6
        columns: root.columns
        imageRatio: 1
        model: root.cells
        imageOf: theme => theme?.emblem ?? ""
        labelOf: theme => theme?.name.toUpperCase() ?? ""
        labelBold: true
        isCurrent: theme => theme?.name === Theme.name
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
