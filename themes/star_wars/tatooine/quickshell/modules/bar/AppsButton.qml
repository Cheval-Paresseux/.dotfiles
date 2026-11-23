import qs.config
import qs.services

BarButton {
    svg: "rebel"
    onClicked: ShellState.toggle("launcher")
}
