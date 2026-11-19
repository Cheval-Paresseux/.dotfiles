import qs.config
import qs.modules.bar.popups
import qs.services

BarButton {
    icon: {
        if (!WifiService.enabled || !WifiService.device)
            return Icons.wifiOff
        return WifiService.network ? Icons.wifi(WifiService.network.signalStrength) : Icons.wifiDisconnected
    }
    color: hovered ? Theme.text : (WifiService.network ? Theme.textMuted : Theme.textDisabled)
    popup: NetworkPopup {}
}
