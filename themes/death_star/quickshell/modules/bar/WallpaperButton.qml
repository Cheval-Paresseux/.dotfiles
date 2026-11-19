import qs.config
import qs.services

BarButton {
    icon: Icons.wallpaper
    onClicked: ShellState.toggle("wallpaper")
}
