import qs.services
import qs.modules.common
import qs.modules.common.widgets
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

Item {
    id: root
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(root.QsWindow.screen)
    readonly property Toplevel activeWindow: ToplevelManager.activeToplevel
    function onMonitorChanged() {
        console.log("ActiveWindow monitor changed to", monitor)
    }

    property string activeWindowAddress: `0x${activeWindow?.HyprlandToplevel?.address}`
    property bool focusingThisMonitor: HyprData.activeWorkspace?.monitor == monitor?.name
    property var biggestWindow: HyprData.biggestWindowForWorkspace(HyprData.monitors[root.monitor?.id]?.activeWorkspace.id)

    implicitWidth: colLayout.implicitWidth

    ColumnLayout {
        id: colLayout

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: -4

        Text {
            Layout.fillWidth: true
            font.pixelSize: Appearance.font.pixelSize.smaller
            color: Appearance.colors.colSubtext
            elide: Text.ElideRight
            text: root.activeWindow?.appId || root.biggestWindow?.appId || "No windows"

        }

        Text {
            Layout.fillWidth: true
            font.pixelSize: Appearance.font.pixelSize.small
            color: Appearance.colors.colOnLayer0
            elide: Text.ElideRight
            text: root.activeWindow?.title
        }

    }

}
