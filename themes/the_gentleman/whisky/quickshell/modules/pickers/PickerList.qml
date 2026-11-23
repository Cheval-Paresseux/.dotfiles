import QtQuick

ListView {
    id: root

    signal activated(var entry)

    function handleKey(event) {
        switch (event.key) {
        case Qt.Key_Down:
        case Qt.Key_Tab:
            incrementCurrentIndex()
            break
        case Qt.Key_Up:
        case Qt.Key_Backtab:
            decrementCurrentIndex()
            break
        case Qt.Key_Return:
        case Qt.Key_Enter:
            if (currentIndex >= 0 && currentIndex < count)
                activated(model[currentIndex])
            break
        default:
            return false
        }
        return true
    }

    anchors.fill: parent
    clip: true
    spacing: 4
    boundsBehavior: Flickable.StopAtBounds
    highlightMoveDuration: 0
}
