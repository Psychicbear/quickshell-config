import QtQuick
import qs.services
import qs.modules.common

Rectangle {
    id: root
    width: clocktext.implicitWidth
    //color: Appearance.colors.colLayer3
    color: "transparent"
    radius: Appearance.rounding.small
    
    Text {
        anchors {
            right: parent.right
            rightMargin: 10
        }
        font.pixelSize: Appearance.font.pixelSize.smaller
        font.family: Appearance.font.family.main
        id: clocktext
        color: Appearance.colors.colOnLayer0
        text: Time.time
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        lineHeight: 0.75
    }

}