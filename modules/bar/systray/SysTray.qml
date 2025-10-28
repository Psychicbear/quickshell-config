pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import qs.components
import qs.config


Item {
    id: root
    required property var bar;
    property int itemCount: SystemTray.items.values.length
    Layout.fillHeight: containerWidth
    Layout.preferredWidth: containerWidth
    Layout.leftMargin: Appearance.padding.small
    Layout.rightMargin: Appearance.padding.small
    property int containerWidth: container.implicitWidth + Appearance.spacing.normal 

    Behavior on Layout.preferredWidth {
        Anim {}
    }

    Component.onCompleted: {
        console.log("SysTray initialized with", SystemTray.items.values.length, "items");
    }

    Rectangle {
        id: background
        anchors {
            fill: root
        }
        implicitHeight: root.Layout.preferredHeight
        implicitWidth: root.Layout.preferredWidth
        radius: 6
        color: Colour.surfaceContainerHighest
    }

    RowLayout {
        id: container
        spacing: Appearance.spacing.small
        implicitWidth: repeater.implicitWidth + Appearance.spacing.normal * 2
        anchors {
            fill: background
            leftMargin: Appearance.spacing.normal
            rightMargin: Appearance.spacing.normal
        }

        Repeater {
            id: repeater
            model: SystemTray.items
            delegate: TrayItem {iconSize: Appearance.font.size.small * 2}
        }
    }

}