import QtQuick 2.0

Rectangle {
    property color currentColor
    signal colorSelected(color color)

    width: 40
    height: 40
    radius: 4
    color: currentColor
    border.color: "#FFFFFF"
    border.width: 2

    MouseArea {
        anchors.fill: parent
      //  onClicked: colorDialog.open()
    }

//       ColorDialog {
//           id: colorDialog
//           color: currentColor
//           onColorChanged: {
//               parent.currentColor = color
//               parent.colorSelected(color)
//            }
//        }
}
