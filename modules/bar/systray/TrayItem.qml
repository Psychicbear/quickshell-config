pragma ComponentBehavior: Bound

import qs.config
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.components
import qs.components.effects

MouseArea {
    id: root

    required property SystemTrayItem modelData
    property alias iconSize: icon.implicitSize
    
    signal menuOpened(qsWindow: var)
    signal menuClosed()

    acceptedButtons: Qt.LeftButton | Qt.RightButton
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true
    Layout.preferredWidth: Appearance.font.size.small * 2
    Layout.preferredHeight: Appearance.font.size.small * 2

    onPressed: (event) => {
        switch (event.button) {
        case Qt.LeftButton:
            modelData.activate();
            break;
        case Qt.RightButton:
            if (modelData.hasMenu) menu.open();
            break;
        }
        event.accepted = true;
    }


     Loader {
        id: menu
        function open() {
            menu.active = true;
        }
        active: false
        sourceComponent: TrayMenu {
            Component.onCompleted: this.open();
            trayItem: root.modelData.menu
            anchors {
                // window: root.QsWindow.window
                left: root.x + QsWindow.window?.width
                top: root.y 
                bottom: root.height
                right: root.width
            }
            onMenuOpened: (window) => root.menuOpened(window);
            onMenuClosed: {
                root.menuClosed();
                menu.active = false;
            }
        }
    }

    IconImage {
        id: icon
        source: root.modelData.icon
    }
}