pragma ComponentBehavior: Bound;

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.modules.common
import qs

Rectangle {
    id: root
    Layout.alignment: Qt.AlignLeft
    implicitWidth: row.implicitWidth + 8
    height: bar.height - 8
    color: Appearance.colors.colLayer4
    radius: 5
    required property var bar
    required property int wsBaseIndex
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(bar.screen)
    property int wsCount: 5
    property int currentIndex: 0
    property int existsCount: 0

    signal workspaceAdded(workspace: HyprlandWorkspace)

    RowLayout {
        id: row
        spacing: 8
        anchors.fill: parent
        anchors.margins: 3
        Repeater {
            id: repeater
            model: root.wsCount

            Rectangle {
                id: wsItem
                width: parent.height / 2
                height: parent.height /2
                radius: active ? 10 : 2
                color: active ? Appearance.colors.colPrimary : Appearance.m3colors[`term${index % 8}`] 

                required property int index;
                property int wsIndex: index + root.wsBaseIndex
                property HyprlandWorkspace workspace: null
                property bool exists: workspace != null
                property bool active: workspace?.active ?? false

                MouseArea {
                    acceptedButtons: Qt.LeftButton
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: {
                        Hyprland.dispatch(`split-workspace ${wsItem.wsIndex}`);
                    }

                    onEntered: {
                        if (wsItem.active) wsItem.color = Appearance.colors.colPrimaryHover;
                        wsItem.width += 10
                        wsItem.x -= 5
                        Debug.debugText = `Workspace ${wsItem}`;
                    }

                    onExited: {
                        if (wsItem.active) wsItem.color = Appearance.colors.colPrimary;
                        wsItem.width -= 10
                        wsItem.x += 5
                    }
                }

                onActiveChanged: {
                    if (active) {
                        root.currentIndex = index;
                        color = Appearance.colors.colPrimary;
                        radius = 10
                    }
                }

                onExistsChanged: {
                    root.existsCount += exists ? 1 : -1;
                }

                Connections {
                    target: root
                    function onWorkspaceAdded(workspace: HyprlandWorkspace) {
                        if (workspace.id == wsItem.wsIndex) {
                            wsItem.workspace = workspace;
                        }
                    }
                }
            }


        }
    }

    Connections {
		target: Hyprland.workspaces

		function onObjectInsertedPost(workspace) {
			root.workspaceAdded(workspace);
		}
	}

	Component.onCompleted: {
		Hyprland.workspaces.values.forEach(workspace => {
			root.workspaceAdded(workspace)
		});
	}

}