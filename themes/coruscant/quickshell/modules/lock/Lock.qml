import Quickshell
import Quickshell.Io
import Quickshell.Services.Pam
import Quickshell.Wayland
import QtQuick

Scope {
    id: root

    property string password: ""
    property bool authenticating: false
    property bool failed: false

    onPasswordChanged: {
        if (password !== "")
            failed = false
    }

    function lock() {
        if (sessionLock.locked)
            return
        password = ""
        failed = false
        sessionLock.locked = true
    }

    function tryUnlock() {
        if (password === "" || authenticating)
            return
        authenticating = true
        if (!pam.start())
            finish(false)
    }

    function finish(success) {
        authenticating = false
        password = ""
        failed = !success
        if (success)
            sessionLock.locked = false
    }

    WlSessionLock {
        id: sessionLock

        LockSurface {
            lock: root
        }
    }

    PamContext {
        id: pam

        configDirectory: "pam"
        config: "password.conf"

        onPamMessage: {
            if (responseRequired)
                respond(root.password)
        }
        onCompleted: result => root.finish(result === PamResult.Success)
        onError: root.finish(false)
    }

    IpcHandler {
        target: "lock"

        function lock(): void {
            root.lock()
        }

        function isLocked(): bool {
            return sessionLock.locked
        }
    }
}
