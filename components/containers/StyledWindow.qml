import Quickshell
import Quickshell.Wayland

PanelWindow {
    required property string name

    WlrLayershell.namespace: `quaccshell-${name}`
    color: "transparent"
}