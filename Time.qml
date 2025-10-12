// Time.qml
pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    readonly property string time: {
        Qt.formatDateTime(clock.date, "hh:mm AP ddd dd/mm/yy")
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}