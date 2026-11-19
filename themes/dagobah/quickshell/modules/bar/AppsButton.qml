import qs.config
import qs.services

BarButton {
    svg: "jedi"
    onClicked: ShellState.toggle("launcher")
}
