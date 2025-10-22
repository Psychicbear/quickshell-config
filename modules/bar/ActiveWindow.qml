import qs.services
import qs.config
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Item {
    id: root
    required property var bar
    readonly property HyprlandMonitor monitor: Hypr.monitorFor(root.bar.screen)
    property bool focusingThisMonitor: Hypr.focusedMonitor.name == monitor?.name
    readonly property HyprlandToplevel activeWindow: Hypr.activeToplevel
    property HyprlandToplevel activeMonitorWindow: focusingThisMonitor ? activeWindow : activeMonitorWindow

    


    Layout.fillHeight: true
    Layout.preferredWidth: colLayout.implicitWidth + 20

    ColumnLayout {
        id: colLayout

        Layout.fillWidth: true
        spacing: -4

        Text {
            Layout.fillWidth: true
            font {
                family: Appearance.font.family.title
                pixelSize: Appearance.font.size.smaller
            }
            color: Colour.textSurfaceVariant
            elide: Text.ElideRight
            text: root.activeMonitorWindow?.wayland?.appId || "Hyprland"

        }

        Text {
            Layout.fillWidth: true
            font {
                family: Appearance.font.family.title
                pixelSize: Appearance.font.size.large
            }

            color: Colour.textSurface
            elide: Text.ElideRight
            text: root.activeMonitorWindow?.title || "Desktop"
        }

    }

}
