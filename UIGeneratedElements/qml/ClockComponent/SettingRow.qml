import QtQuick 2.0
import QtQuick.Layouts 1.0

RowLayout {
    property alias label: labelText.text
    //property alias control: controlContainer.children[0]

    height: root.rowHeight
    Layout.fillWidth: true

    Text {
        id: labelText
        color: "#CCCCCC"
        font.pixelSize: 14
        Layout.preferredWidth: root.labelWidth
        verticalAlignment: Text.AlignVCenter
    }

    Item {
        id: controlContainer
        Layout.fillWidth: true
        height: root.rowHeight
    }
}
