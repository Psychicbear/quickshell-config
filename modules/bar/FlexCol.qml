import QtQuick
import QtQuick.Layouts

FlexboxLayout {
    id: root
    required property FlexboxLayout base
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.preferredWidth: base.width / 3
    Layout.preferredHeight: base.height
    Layout.topMargin: 5
    Layout.bottomMargin: 5

}