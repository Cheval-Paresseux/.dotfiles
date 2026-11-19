import Quickshell.Io
import QtQuick
import QtQuick.Shapes
import qs.config
import qs.services

// The bar's market board: CPU and memory quoted like shares, each with a sparkline of
// the last ninety seconds, then the network's incoming traffic
Row {
    id: root

    readonly property int samples: 30
    property var cpuHistory: []
    property var memoryHistory: []
    property var cpuSample: null // [busy, total] jiffies at the previous tick
    property var received: null // bytes received at the previous tick
    property real downloadRate: 0

    spacing: 12

    function push(history, value) {
        return [...history, value].slice(-samples)
    }

    function readCpu(text) {
        const fields = text.split("\n")[0].trim().split(/\s+/).slice(1).map(Number)
        const total = fields.reduce((a, b) => a + b, 0)
        const busy = total - fields[3] - fields[4] // minus idle and iowait
        if (cpuSample && total > cpuSample[1])
            cpuHistory = push(cpuHistory, (busy - cpuSample[0]) / (total - cpuSample[1]))
        cpuSample = [busy, total]
    }

    function readMemory(text) {
        const kib = name => Number(text.match(new RegExp(name + ":\\s+(\\d+)"))[1])
        memoryHistory = push(memoryHistory, 1 - kib("MemAvailable") / kib("MemTotal"))
    }

    // Bytes received by every interface but loopback
    function readNetwork(text) {
        const bytes = text.split("\n").slice(2)
            .filter(line => line.includes(":") && !line.trim().startsWith("lo:"))
            .reduce((sum, line) => sum + Number(line.split(":")[1].trim().split(/\s+/)[0]), 0)
        if (received !== null)
            downloadRate = Math.max(0, (bytes - received) / (tick.interval / 1000))
        received = bytes
    }

    FileView {
        id: stat

        path: "/proc/stat"
        onLoaded: root.readCpu(text())
    }

    FileView {
        id: meminfo

        path: "/proc/meminfo"
        onLoaded: root.readMemory(text())
    }

    FileView {
        id: netdev

        path: "/proc/net/dev"
        onLoaded: root.readNetwork(text())
    }

    Timer {
        id: tick

        interval: 3000
        running: true
        repeat: true
        onTriggered: {
            stat.reload()
            meminfo.reload()
            netdev.reload()
        }
    }

    component Label: Text {
        anchors.verticalCenter: parent.verticalCenter
        font.family: Theme.displayFont
        font.pixelSize: Theme.fontMedium
        font.weight: Font.Medium
        font.letterSpacing: 1.5
    }

    component Diamond: Label {
        text: "◆"
        color: Qt.alpha(Theme.accent, 0.6)
        font.pixelSize: 7
    }

    // A share: its symbol, a sparkline scaled to its own range, the value and its last move
    component Quote: Row {
        id: quote

        required property string symbol
        required property var history
        readonly property real value: history.length ? history[history.length - 1] : 0
        readonly property real move: history.length > 1 ? value - history[history.length - 2] : 0
        readonly property real low: Math.min(...history)
        readonly property real range: Math.max(Math.max(...history) - low, 0.02)

        spacing: 6

        function point(index) {
            return Qt.point(index * chart.width / (history.length - 1),
                            chart.height - 1 - (history[index] - low) / range * (chart.height - 2))
        }

        Label {
            text: quote.symbol
            color: Theme.accent
        }

        Shape {
            id: chart

            anchors.verticalCenter: parent.verticalCenter
            width: 44
            height: 14
            visible: quote.history.length > 1
            preferredRendererType: Shape.CurveRenderer

            readonly property var line: quote.history.map((_, i) => quote.point(i))

            // Gold wash under the line, as on a price chart
            ShapePath {
                strokeColor: "transparent"
                fillGradient: LinearGradient {
                    y2: chart.height
                    GradientStop { position: 0; color: Qt.alpha(Theme.accent, 0.3) }
                    GradientStop { position: 1; color: Qt.alpha(Theme.accent, 0) }
                }

                PathPolyline {
                    path: chart.line.length
                        ? [Qt.point(0, chart.height), ...chart.line, Qt.point(chart.line[chart.line.length - 1].x, chart.height)]
                        : []
                }
            }

            ShapePath {
                strokeColor: Theme.champagne
                strokeWidth: 1.2
                fillColor: "transparent"
                joinStyle: ShapePath.RoundJoin

                PathPolyline { path: chart.line }
            }
        }

        // Ticker arrows stay neutral: a rising load is not good news, a high one needs attention
        Label {
            text: Math.round(quote.value * 100) + "% " + (quote.move > 0.01 ? "▲" : (quote.move < -0.01 ? "▼" : "▪"))
            color: quote.value > 0.9 ? Theme.critical : (quote.value > 0.75 ? Theme.warning : Theme.textMuted)
        }
    }

    Quote {
        symbol: "CPU"
        history: root.cpuHistory
    }

    Diamond {}

    Quote {
        symbol: "MEM"
        history: root.memoryHistory
    }

    Diamond {}

    Row {
        spacing: 6

        Label {
            text: "NET"
            color: Theme.accent
        }

        Label {
            text: "↓ " + Format.rate(root.downloadRate)
            color: Theme.textMuted
        }
    }
}
