import qs.config
import qs.modules.bar.popups
import qs.services

BarButton {
    readonly property int count: NotificationService.history.length

    icon: NotificationService.doNotDisturb ? Icons.bellOff : (count > 0 ? Icons.bell : Icons.bellOutline)
    text: count > 0 ? count.toString() : ""
    color: {
        if (NotificationService.doNotDisturb)
            return Theme.textDisabled
        if (count > 0)
            return Theme.info
        return hovered ? Theme.accent : Theme.textSubtle
    }
    centerPopup: true
    popup: NotificationPopup {}
}
