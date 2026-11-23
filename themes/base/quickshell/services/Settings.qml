pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import qs.config

// Persisted per theme in ~/.local/state/quickshell/by-shell/<id>/settings-<theme>.json
Singleton {
    id: root

    // A saved wallpaper whose file has since been deleted gives way to the theme's default
    property bool savedWallpaperMissing: false
    readonly property string wallpaperPath: adapter.wallpaper && !savedWallpaperMissing ? adapter.wallpaper : Theme.defaultWallpaper
    readonly property url wallpaper: "file://" + wallpaperPath

    function setWallpaper(path) {
        adapter.wallpaper = path
    }

    FileView {
        path: Quickshell.statePath("settings-" + Theme.name + ".json")
        printErrors: false

        onLoaded: wallpaperCheck.running = true
        onAdapterUpdated: {
            writeAdapter()
            wallpaperCheck.running = true
        }
        onLoadFailed: error => {
            if (error === FileViewError.FileNotFound)
                writeAdapter()
        }

        JsonAdapter {
            id: adapter

            property string wallpaper: ""
        }
    }

    Process {
        id: wallpaperCheck

        command: ["test", "-f", adapter.wallpaper]
        onExited: code => root.savedWallpaperMissing = code !== 0
    }

    IpcHandler {
        target: "settings"

        function setWallpaper(path: string): void {
            root.setWallpaper(path)
        }

        function getWallpaper(): string {
            return root.wallpaperPath
        }
    }
}
