pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick

IconImage {
    id: root

    required property color colour

    asynchronous: true

    layer.enabled: true
    layer.effect: Colouriser {
        sourceColor: analyser.colors[0]
        colorizationColor: root.colour
    }

    ColorQuantizer {
        id: analyser

        depth: 3
        rescaleSize: 64
        source: root.source
    }
}
