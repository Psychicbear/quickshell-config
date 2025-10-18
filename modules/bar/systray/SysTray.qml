pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Services.SystemTray

Item {
    id: root
    required property var bar;
    implicitHeight: container.implicitHeight + 10

    ColumnLayout {
        id: container
        anchors {
            fill: parent
            margins: 5
        }

        Repeater {
            model: SystemTray.items
            delegate: SysTrayIcon {
                iconData: modelData
                bar: root.bar
            }
        }
    }

}