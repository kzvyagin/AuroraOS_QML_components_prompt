import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.Layouts 1.0
import "../AiGenerated" 1.0
import "../ClockComponent" 1.0

Page {
    objectName: "mainPage"
    allowedOrientations: Orientation.All

    /*
    // uncomment to test DialProgress
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        ColumnLayout {
            id: column
            width: parent.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: "Dial Progress"
            }

            // Основной диал (как на картинке — 60%)
            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.itemSizeExtraLarge * 3.5

                DialProgress {
                    id: mainDial
                    anchors.centerIn: parent
                    dialSize: Math.min(parent.width, parent.height) * 0.85
                    value: 0.60
                    trackWidth: Theme.paddingLarge * 1.2
                }
            }

            // Слайдер для управления
            Slider {
                id: slider
                Layout.fillWidth: true
               // Layout.margins: Theme.paddingLarge
                minimumValue: 0
                maximumValue: 100
                value: 60
                stepSize: 1
                label: "Progress"
                valueText: value + "%"

                onValueChanged: mainDial.value = value / 100
            }

        }
    }
*/
    // uncomment to test LikeButton
    Column {
        anchors.centerIn: parent
        spacing: Theme.paddingLarge



        // Simple icon-only like button (matches the picture)
        LikeButton {
            liked: false
            showCount: false
            onTriggered: console.log("Liked:", liked)
        }

        // Like button with a counter
        LikeButton {
            liked: true
            likeCount: 42
            showCount: true
            activeColor: Theme.highlightColor
            onTriggered: console.log("Liked:", liked)
        }

        // Custom-styled
        LikeButton {
            liked: true
            likeCount: 127
            showCount: true
            activeColor: "#3B82F6"       // blue as in the picture
            iconSize: Theme.iconSizeLarge
            onTriggered: { console.log("Liked:", liked) ; likeCount++}
        }

    }
    /* //uncomment to test ClockComponent
   ClockComponent {
          anchors.centerIn: parent
          width: 380
          height: 520
      }
    */


    /* //uncomment to test  GlassyButton
    SilicaFlickable {
           anchors.fill: parent
           contentHeight: column.height + Theme.paddingLarge * 2

           ColumnLayout {
               id: column
               anchors {
                   top: parent.top
                   left: parent.left
                   right: parent.right
                   margins: Theme.paddingLarge
               }
               spacing: Theme.paddingMedium

               // Page header
               PageHeader {
                   title: qsTr("Glassy Buttons")
                   Layout.fillWidth: true
               }

               // Button 1: Blue - SHOP NOW
               GlassyButton {
                   text: qsTr("SHOP NOW")
                   colorScheme: blue
                   Layout.fillWidth: true
                   Layout.preferredHeight: Theme.itemSizeMedium
                   onClicked: console.log("Shop Now clicked")
               }

               // Button 2: Pink - BUY NOW
               GlassyButton {
                   text: qsTr("BUY NOW")
                   colorScheme: pink
                   Layout.fillWidth: true
                   Layout.preferredHeight: Theme.itemSizeMedium
                   onClicked: console.log("Buy Now clicked")
               }

               // Button 3: Green - CONTACT US
               GlassyButton {
                   text: qsTr("CONTACT US")
                   colorScheme: green
                   Layout.fillWidth: true
                   Layout.preferredHeight: Theme.itemSizeMedium
                   onClicked: console.log("Contact Us clicked")
               }

               // Button 4: Purple - LEARN MORE
               GlassyButton {
                   text: qsTr("LEARN MORE")
                   colorScheme: purple
                   Layout.fillWidth: true
                   Layout.preferredHeight: Theme.itemSizeMedium
                   onClicked: console.log("Learn More clicked")
               }

               // Button 5: Indigo - KNOW MORE
               GlassyButton {
                   text: qsTr("KNOW MORE")
                   colorScheme: indigo
                   Layout.fillWidth: true
                   Layout.preferredHeight: Theme.itemSizeMedium
                   onClicked: console.log("Know More clicked")
               }

               // Spacer
               Item { Layout.fillHeight: true }
           }

           VerticalScrollDecorator {}
       }*/
}
