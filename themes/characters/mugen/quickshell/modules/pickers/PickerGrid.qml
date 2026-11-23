import QtQuick
import qs.config

// Grid of image cards with keyboard navigation (wallpapers, and theme emblems in the theme picker).
// A null entry is an empty cell (the theme picker ends each group's row with them): it is
// not drawn and never selected.
GridView {
    id: root

    property int columns: 4
    // Height of an image relative to its width; square images are fitted rather than cropped
    property real imageRatio: 9 / 16
    property string emptyText
    // How to show an entry of the model
    property var imageOf: entry => entry
    property var labelOf: entry => entry
    property bool labelBold
    property var isCurrent: entry => false

    signal activated(var entry)

    function handleKey(event) {
        switch (event.key) {
        case Qt.Key_Right:
        case Qt.Key_Tab:
            moveCurrentIndexRight()
            skipEmptyCells(1)
            break
        case Qt.Key_Left:
        case Qt.Key_Backtab:
            moveCurrentIndexLeft()
            skipEmptyCells(-1)
            break
        case Qt.Key_Down:
            moveCurrentIndexDown()
            skipEmptyCells(-1)
            break
        case Qt.Key_Up:
            moveCurrentIndexUp()
            skipEmptyCells(-1)
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

    // Keep going the same way past empty cells; at the end of the grid, come back to the last entry
    function skipEmptyCells(step) {
        while (model[currentIndex] === null && currentIndex + step >= 0 && currentIndex + step < count)
            currentIndex += step
        while (model[currentIndex] === null && currentIndex > 0)
            currentIndex--
    }

    clip: true
    boundsBehavior: Flickable.StopAtBounds
    highlightMoveDuration: 0
    cellWidth: width / columns
    cellHeight: cellWidth * imageRatio + 24

    delegate: Item {
        id: cell

        required property var modelData
        required property int index

        readonly property bool selected: index === root.currentIndex

        width: root.cellWidth
        height: root.cellHeight
        visible: modelData !== null

        Rectangle {
            id: frame

            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 8
            height: width * root.imageRatio
            radius: Theme.radius
            color: Theme.surface
            border.width: 2
            border.color: cell.selected
                ? Theme.accent
                : (mouseArea.containsMouse ? Theme.overlay0 : "transparent")

            Image {
                anchors.fill: parent
                anchors.margins: 3
                source: root.imageOf(cell.modelData) ? "file://" + root.imageOf(cell.modelData) : ""
                sourceSize.width: 320
                fillMode: root.imageRatio === 1 ? Image.PreserveAspectFit : Image.PreserveAspectCrop
                asynchronous: true
            }
        }

        Text {
            anchors.top: frame.bottom
            anchors.topMargin: 3
            anchors.left: frame.left
            anchors.right: frame.right
            text: (root.isCurrent(cell.modelData) ? "● " : "") + root.labelOf(cell.modelData)
            color: cell.selected ? Theme.text : Theme.textSubtle
            font.pixelSize: Theme.fontSmall
            font.bold: root.labelBold
            elide: Text.ElideMiddle
            horizontalAlignment: Text.AlignHCenter
        }

        MouseArea {
            id: mouseArea

            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onEntered: root.currentIndex = cell.index
            onClicked: root.activated(cell.modelData)
        }
    }

    Text {
        anchors.centerIn: parent
        width: parent.width * 0.8
        visible: root.count === 0
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        text: root.emptyText
        color: Theme.textDisabled
        font.pixelSize: Theme.fontLarge
    }
}
