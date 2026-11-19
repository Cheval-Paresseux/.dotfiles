pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import qs.config

// Persisted per theme in ~/.local/state/quickshell/by-shell/<id>/settings-<theme>.json
Singleton {
    id: root

    readonly property string wallpaperPath: adapter.wallpaper || Theme.defaultWallpaper
    readonly property url wallpaper: "file://" + wallpaperPath

    function setWallpaper(path) {
        adapter.wallpaper = path
    }

    FileView {
        path: Quickshell.statePath("settings-" + Theme.name + ".json")
        printErrors: false

        onAdapterUpdated: writeAdapter()
        onLoadFailed: error => {
            if (error === FileViewError.FileNotFound)
                writeAdapter()
        }

        JsonAdapter {
            id: adapter

            property string wallpaper: ""
        }
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
