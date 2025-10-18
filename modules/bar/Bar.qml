import QtQuick
import QtQuick.Layouts
import Quickshell // for PanelWindow
import Quickshell.Wayland
import Quickshell.Hyprland
import Qt5Compat.GraphicalEffects
import qs.modules.common
import qs.modules.common.functions
import qs
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

        anchors {
          top: true
          left: true
          right: true
        }

        // Background
        Rectangle {
          id: barBackground
          anchors.fill: parent
          color: ColorUtils.transparentize(Appearance.colors.colLayer0, 0.75)
          // color: '#d543499a'
          radius: 3
        }

        FastBlur{
          anchors.fill: barBackground
          source: barBackground
          radius: 20
        }

        implicitHeight: 40

        // Left layout
        RowLayout {
            id: leftLayout
            anchors {
              top: parent.top
              bottom: parent.bottom
              left: parent.left
              right: centerLayout.left
            }

            Layout.alignment: Qt.AlignLeft
            spacing: 8

            Workspaces {
              id: workspaces
              bar: bar
              wsBaseIndex: root.screen.name == "DP-1" ? 5 : 0
              wsCount: 5
            }

        }

        // Center layout
        Row {
          id: centerLayout
          anchors {
            top: parent.top
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
          }

          // Text {
          //   id: debug
          //   anchors.centerIn: parent
          //   font.pixelSize: Appearance.font.pixelSize.small
          //   color: Appearance.colors.colOnLayer0
          //   text: Debug.debugText
          // }

          Text {
            anchors {
              left: parent.left
              verticalCenter: parent.verticalCenter
              right: debug.left
              rightMargin: 10
            }
            font.pixelSize: Appearance.font.pixelSize.small
            color: Appearance.colors.colOnLayer0
            text: bar.screen.name
          }

          // ActiveWindow{
          //   visible: true
          //   Layout.fillWidth: true
          //   Layout.fillHeight: true
          // }
        }

        // Right layout
        RowLayout {
          id: rightLayout
          anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
            left: centerLayout.right
          }
          
          
          Layout.alignment: Qt.AlignRight
          spacing: 8
          Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            // color: '#8fff57'
            color: 'transparent'
            RowLayout {
              anchors.fill: parent

              spacing: 8
              Layout.fillWidth: true
              Layout.fillHeight: true

              ClockWidget {
                Layout.alignment: Qt.AlignRight
                Layout.preferredHeight: parent.height - 5
              }

            }


          }


        }

      }
  }
}



