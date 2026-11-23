import Quickshell.Services.Pipewire
import QtQuick
import qs.config
import qs.modules.bar.popups
import qs.services

BarButton {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property bool ready: !!(sink && sink.ready && sink.audio)

    icon: ready ? Icons.volume(sink.audio.volume, sink.audio.muted) : Icons.volumeOff
    text: ready && !sink.audio.muted ? Format.percent(sink.audio.volume) : ""
    color: ready && sink.audio.muted ? Theme.critical : (hovered ? Theme.accent : Theme.textMuted)
    popup: AudioPopup {}

    PwObjectTracker {
        objects: root.sink ? [root.sink] : []
    }

    WheelHandler {
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
        onWheel: event => {
            if (!root.ready || event.angleDelta.y === 0)
                return
            const volume = root.sink.audio.volume + event.angleDelta.y / 120 * 0.05
            root.sink.audio.volume = Math.max(0, Math.min(1, volume))
        }
    }
}
