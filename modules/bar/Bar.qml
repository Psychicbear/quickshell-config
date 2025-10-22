import QtQuick
import QtQuick.Layouts
import Quickshell // for PanelWindow
import Quickshell.Wayland
import qs.config
import qs.modules.bar.systray
Scope {
  Variants {
    id: root
    model: Quickshell.screens;

    PanelWindow {
        id: bar
        required property var modelData
        screen: modelData

        // exclusionMode: ExclusionMode.Ignore
				WlrLayershell.layer: WlrLayer.Background
				WlrLayershell.namespace: "shell:background"

        color: "transparent"
        implicitHeight: 40

        anchors {
          top: true
          left: true
          right: true
        }

        // Background
        Rectangle {
          id: barBackground
          anchors.fill: parent
          color: Colour.surfaceContainer
          // color: '#d543499a'
          radius: 3
        }

        FlexboxLayout {
          id: base
          anchors.fill: barBackground
          alignContent: FlexboxLayout.AlignCenter

          // Left layout
          FlexCol {
              id: leftLayout
              base: base
              Layout.leftMargin: 5
              
              Workspaces {
                id: workspaces
                screen: bar.screen
                wsBaseIndex: bar.screen.name == "DP-1" ? 6 : 1
                wsCount: 5
              }

              SysTray {
                id: systray
                bar: bar
              }

          }

          // Center layout
          FlexCol {
            id: centerLayout
            base: base
            justifyContent: FlexboxLayout.JustifyCenter
            alignContent: FlexboxLayout.AlignCenter

            ActiveWindow{
              bar: bar
              visible: true
            }
          }

          // Right layout
          FlexCol {
            id: rightLayout
            base: base

            direction: FlexboxLayout.RowReverse
            ClockWidget {
                Layout.preferredHeight: rightLayout.height
            }



          }
        }

      }
  }
}



