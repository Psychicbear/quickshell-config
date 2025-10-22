pragma ComponentBehavior: Bound

import qs.config
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.components

MouseArea {
    id: root

    required property SystemTrayItem modelData
    property alias iconSize: icon.implicitSize

    acceptedButtons: Qt.LeftButton | Qt.RightButton
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true
    Layout.preferredWidth: Appearance.font.size.small * 2
    Layout.preferredHeight: Appearance.font.size.small * 2

    onClicked: event => {
        if (event.button === Qt.LeftButton)
            modelData.activate();
        else
            modelData.secondaryActivate();
    }

    Rectangle {
        id: background
        anchors {
            fill: parent
        }
        property int size: icon.implicitSize * 2 + 4
        width: size
        height: size
        color: root.containsMouse ? Colour.textPrimaryContainer : "transparent"
        radius: 5

        Behavior on color {
            CAnim{}
        }
    }

    IconImage {
        id: icon
        source: root.modelData.icon
    }
}