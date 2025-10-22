import QtQuick
import QtQuick.Layouts
import qs.services
import qs.config

Rectangle {
    id: root
    Layout.preferredWidth: clocktext.implicitWidth
    color: "transparent"
    
    Text {
        anchors {
            right: parent.right
            rightMargin: 10
        }
        font.pixelSize: Appearance.font.size.normal
        font.family: Appearance.font.family.sans
        id: clocktext
        color: Colour.textSurface
        text: Time.time
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        lineHeight: 1
    }

}