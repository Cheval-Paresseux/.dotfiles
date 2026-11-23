pragma Singleton

import Quickshell
import QtQuick

Singleton {
    function duration(seconds) {
        const hours = Math.floor(seconds / 3600)
        const minutes = Math.floor((seconds % 3600) / 60)
        return hours > 0 ? hours + "h " + minutes + "m" : minutes + "m"
    }

    function rate(bytesPerSecond) {
        if (bytesPerSecond >= 1048576)
            return (bytesPerSecond / 1048576).toFixed(1) + " MB/s"
        if (bytesPerSecond >= 1024)
            return Math.round(bytesPerSecond / 1024) + " KB/s"
        return Math.round(bytesPerSecond) + " B/s"
    }

    function percent(fraction) {
        return Math.round(fraction * 100) + "%"
    }
}
