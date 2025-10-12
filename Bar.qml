import QtQuick
import Quickshell // for PanelWindow
import Quickshell.Wayland
import Quickshell.Hyprland

Scope {
  id: bar
  Variants {
    model: Quickshell.screens;

    PanelWindow {
        required property var modelData
        screen: modelData

        color: "transparent"
        anchors {
          top: true
          left: true
          right: true
        }

        implicitHeight: 30

        Rectangle {
          anchors.fill: parent
          color: "#1e1e2e80"
        }

        ClockWidget {
          anchors.right: parent.right
        }
      }
  }
}



