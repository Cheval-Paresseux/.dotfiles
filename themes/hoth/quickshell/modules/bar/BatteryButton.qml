import qs.config
import qs.modules.bar.popups
import qs.services

BarButton {
    visible: BatteryService.available
    icon: BatteryService.icon
    text: Format.percent(BatteryService.level)
    color: BatteryService.color ?? (hovered ? Theme.text : Theme.textMuted)
    popup: BatteryPopup {}
}
