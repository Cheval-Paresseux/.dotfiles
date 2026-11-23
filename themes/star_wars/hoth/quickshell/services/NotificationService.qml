pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import QtQuick

Singleton {
    id: root

    readonly property int maxToasts: 5
    readonly property int maxHistory: 50

    property bool doNotDisturb: false
    property var history: []
    property int nextKey: 0

    readonly property var toasts: server.trackedNotifications

    function clear() {
        root.history = []
    }

    function remove(key) {
        root.history = root.history.filter(entry => entry.key !== key)
    }

    function record(notification, critical) {
        const entry = {
            key: root.nextKey++,
            appName: notification.appName,
            summary: notification.summary,
            body: notification.body,
            critical: critical,
            time: new Date()
        }
        root.history = [entry, ...root.history].slice(0, root.maxHistory)
    }

    NotificationServer {
        id: server

        onNotification: notification => {
            const critical = notification.urgency === NotificationUrgency.Critical

            if (!notification.transient)
                root.record(notification, critical)

            if (root.doNotDisturb && !critical)
                return

            notification.tracked = true

            const tracked = server.trackedNotifications.values
            for (let i = 0; i < tracked.length - root.maxToasts; i++)
                tracked[i].dismiss()
        }
    }

    IpcHandler {
        target: "notifications"

        function toggleDnd(): void {
            root.doNotDisturb = !root.doNotDisturb
        }

        function clear(): void {
            root.clear()
        }
    }
}
