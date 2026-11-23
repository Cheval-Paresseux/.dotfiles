import Quickshell.Bluetooth
import qs.config
import qs.modules.bar.popups

BarButton {
    readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter
    readonly property bool powered: !!adapter && adapter.enabled
    readonly property bool connected: powered && adapter.devices.values.some(device => device.connected)

    icon: powered ? (connected ? Icons.bluetoothConnected : Icons.bluetooth) : Icons.bluetoothOff
    color: connected ? Theme.info : (hovered ? Theme.accent : (powered ? Theme.textMuted : Theme.textDisabled))
    popup: BluetoothPopup {}
}
