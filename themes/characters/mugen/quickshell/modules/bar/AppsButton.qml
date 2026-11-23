import qs.config
import qs.services

BarButton {
    icon: Icons.apps
    onClicked: ShellState.toggle("launcher")
}
