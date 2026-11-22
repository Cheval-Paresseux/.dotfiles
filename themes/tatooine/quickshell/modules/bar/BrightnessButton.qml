import QtQuick
import qs.config
import qs.modules.bar.popups
import qs.services

BarButton {
    visible: BrightnessService.available
    icon: Icons.brightness(BrightnessService.level)
    text: Format.percent(BrightnessService.level)
    popup: BrightnessPopup {}

    WheelHandler {
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
        onWheel: event => {
            if (event.angleDelta.y !== 0)
                BrightnessService.setLevel(BrightnessService.level + event.angleDelta.y / 120 * 0.05)
        }
    }
}
