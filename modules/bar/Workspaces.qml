pragma ComponentBehavior: Bound;

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.components
import qs.services
import qs.config

Item {
    id: root
    Layout.fillHeight: true
    Layout.preferredWidth: wsCount * 25 + 20


    Rectangle {
        id: background
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left


            leftMargin: 8
        }
        color: Colour.surfaceContainerHighest
        width: row.implicitWidth + 10
        radius: 8
    }
    
    
    required property var screen
    required property int wsBaseIndex
    readonly property HyprlandMonitor monitor: Hypr.monitorFor(screen)
    property int wsCount: 5
    property int currentIndex: 0
    property int existsCount: 0

    signal workspaceAdded(workspace: HyprlandWorkspace)

    RowLayout {
        id: row
        spacing: 8
        
        anchors {
            fill: background
            margins: 5
        }

        Repeater {
            id: repeater
            model: root.wsCount

            Rectangle {
                id: wsItem
                Layout.preferredWidth: area.containsMouse ? 20 : 15
                height: 15
                radius: active ? 10 : 4
                color: currentColor
                required property int index;
                property int wsIndex: index + root.wsBaseIndex
                property HyprlandWorkspace workspace: Hypr.workspaces.values.find(ws => ws.id === wsIndex) ?? null
                property bool exists: workspace != null
                property bool active: workspace.active


                property color currentColor: active ? 
                    (area.containsMouse ? Colour.secondary : 
                        Colour.primary) :
                    (area.containsMouse ? Colour.textPrimaryContainer : 
                        Colour.textSecondaryContainer)

                Behavior on Layout.preferredWidth {
                    Anim{}
                }

                Behavior on color {
                    CAnim{}
                }

                Behavior on radius {
                    Anim{}
                }
                

                MouseArea {
                    id: area
                    acceptedButtons: Qt.LeftButton
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onPressed: {
                        console.log("Switching to workspace", wsItem.wsIndex, wsItem.index);
                        Hypr.dispatch(`split-workspace ${wsItem.index+1}`);
                    }

                }

                onActiveChanged: {
                    if (active) {
                        root.currentIndex = index;
                    }
                }

                onExistsChanged: {
                    root.existsCount += exists ? 1 : -1;
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

}