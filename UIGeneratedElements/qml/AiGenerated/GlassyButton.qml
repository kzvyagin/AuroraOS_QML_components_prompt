// GlassyButton.qml
// A glossy, gradient button component for Sailfish OS / Aurora OS
// Compatible with Qt 5.6, QtQuick 2.0, Sailfish.Silica 1.0, QtQuick.Layouts 1.0

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.Layouts 1.0

/*!
    \qmltype GlassyButton
    \inqmlmodule Components
    \brief A glossy gradient button with adaptive layout for Sailfish/Aurora OS.

    This component provides a glassy, rounded button with a horizontal gradient,
    glossy highlight overlay, and shadow effects. It adapts to the Sailfish
    Silica Theme for sizing, fonts, and colors.

    \section1 Usage Example

    \qml
    GlassyButton {
        text: "SHOP NOW"
        colorScheme: GlassyButton.Blue
        onClicked: console.log("Button clicked!")
    }
    \endqml

    \section1 Color Schemes

    The button supports five predefined color schemes matching the image:
    \list
        \li Blue - Cyan to blue gradient
        \li Pink - Magenta to pink gradient
        \li Green - Emerald to green gradient
        \li Purple - Violet to purple gradient
        \li Indigo - Deep blue to indigo gradient
    \endlist
*/


    MouseArea {
        id: root
         // =====================================================================
        // Public API
        // =====================================================================

        /*! \qmlproperty string text
        The text displayed on the button. */
        property alias text: buttonText.text

        /*! \qmlproperty var colorScheme
        The color scheme enum. One of: Blue, Pink, Green, Purple, Indigo. */
        property int colorScheme: GlassyButton.blue

        /*! \qmlproperty alias font
        The font used for the button text. Defaults to Theme font. */
        property alias font: buttonText.font

        /*! \qmlproperty real horizontalMargin
        Horizontal margin inside the button around the text. */
        property real horizontalMargin: Theme.paddingLarge

        /*! \qmlproperty real verticalMargin
        Vertical margin inside the button around the text. */
        property real verticalMargin: Theme.paddingMedium

        /*! \qmlproperty real radius
        Corner radius of the button. */
        property real radius: height / 2

        /*! \qmlproperty real borderWidth
        Width of the subtle border around the button. */
        property real borderWidth: 1

        /*! \qmlproperty real shadowOpacity
        Opacity of the drop shadow beneath the button. */
        property real shadowOpacity: 0.25

        /*! \qmlproperty real shadowVerticalOffset
        Vertical offset of the drop shadow. */
        property real shadowVerticalOffset: Theme.paddingSmall / 2

        /*! \qmlproperty real highlightOpacity
        Opacity of the glossy highlight overlay. */
        property real highlightOpacity: 0.4

        // Color scheme enum values
        readonly property int blue:   0
        readonly property int pink:   1
        readonly property int green:  2
        readonly property int purple: 3
        readonly property int indigo: 4

        // =====================================================================
        // Internal Properties - Color definitions based on image analysis
        // =====================================================================

        // Gradient start colors (left side, darker)
        readonly property var _gradientStartColors: [
            Qt.rgba(0.25, 0.52, 0.98, 1.0),   // blue:   #4085FA
            Qt.rgba(0.93, 0.19, 0.53, 1.0),   // Pink:   #EC3186
            Qt.rgba(0.03, 0.56, 0.12, 1.0),   // Green:  #088E1E
            Qt.rgba(0.52, 0.09, 0.98, 1.0),   // Purple: #8517FA
            Qt.rgba(0.27, 0.17, 0.98, 1.0)    // Indigo: #452CFA
        ]

        // Gradient end colors (right side, slightly different tone)
        readonly property var _gradientEndColors: [
            Qt.rgba(0.29, 0.54, 0.97, 1.0),   // blue:   #4A89F7
            Qt.rgba(0.93, 0.23, 0.55, 1.0),   // Pink:   #EC3A8D
            Qt.rgba(0.03, 0.62, 0.16, 1.0),   // Green:  #089E29
            Qt.rgba(0.56, 0.18, 0.98, 1.0),   // Purple: #8E2EFA
            Qt.rgba(0.31, 0.25, 0.96, 1.0)    // Indigo: #4E3FF6
        ]

        // Center highlight color (lighter, for the glossy effect)
        readonly property var _highlightColors: [
            Qt.rgba(0.75, 0.86, 0.99, 1.0),   // blue:   #BFDDFD
            Qt.rgba(0.96, 0.45, 0.70, 1.0),   // Pink:   #F572B2
            Qt.rgba(0.23, 0.79, 0.34, 1.0),   // Green:  #3AC957
            Qt.rgba(0.81, 0.67, 0.99, 1.0),   // Purple: #CEAAFC
            Qt.rgba(0.64, 0.61, 0.94, 1.0)    // Indigo: #A29CF0
        ]

        // Border colors (subtle, slightly lighter than start)
        readonly property var _borderColors: [
            Qt.rgba(0.45, 0.70, 1.00, 0.60),   // blue
            Qt.rgba(1.00, 0.40, 0.70, 0.60),   // Pink
            Qt.rgba(0.15, 0.70, 0.30, 0.60),   // Green
            Qt.rgba(0.65, 0.35, 1.00, 0.60),   // Purple
            Qt.rgba(0.45, 0.40, 1.00, 0.60)    // Indigo
        ]

        // =====================================================================
        // Derived Colors
        // =====================================================================

        readonly property color gradientStart: _gradientStartColors[Math.max(0, Math.min(4, colorScheme))]
        readonly property color gradientEnd:   _gradientEndColors[Math.max(0, Math.min(4, colorScheme))]
        readonly property color highlightColor: _highlightColors[Math.max(0, Math.min(4, colorScheme))]
        readonly property color borderColor:   _borderColors[Math.max(0, Math.min(4, colorScheme))]

        // =====================================================================
        // Layout & Geometry
        // =====================================================================

        // Adaptive height based on Theme font metrics
        implicitHeight: buttonText.implicitHeight + verticalMargin * 2
        implicitWidth:  buttonText.implicitWidth + horizontalMargin * 2

        // Minimum dimensions to ensure touchability
        Layout.minimumWidth: Theme.itemSizeExtraSmall
        Layout.minimumHeight: Theme.itemSizeSmall / 2
        Layout.preferredHeight: implicitHeight
        Layout.fillWidth: true

        // Ensure the button is tall enough for comfortable touch
        height: Math.max(implicitHeight, Theme.iconSizeMedium)

        // =====================================================================
        // Visual Feedback
        // =====================================================================

        scale: pressed ? 0.97 : 1.0
        opacity: enabled ? 1.0 : 0.5

        Behavior on scale {
            NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
        }

        Behavior on opacity {
            NumberAnimation { duration: 150 }
        }

        // =====================================================================
        // Visual Hierarchy
        // =====================================================================

        // Layer 1: Drop Shadow
        Rectangle {
            id: shadowLayer
            anchors {
                fill: parent
                topMargin: root.shadowVerticalOffset
            }
            radius: root.radius
            color: "black"
            opacity: root.shadowOpacity
            visible: root.enabled
        }

        // Layer 2: Main Button Body with Gradient
        Rectangle {
            id: buttonBody
            anchors.fill: parent
            radius: root.radius

            // Horizontal gradient from left to right
            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: root.gradientStart
                }
                GradientStop {
                    position: 0.5
                    color: root.highlightColor
                }
                GradientStop {
                    position: 1.0
                    color: root.gradientEnd
                }
            }

            // Subtle border
            border {
                width: root.borderWidth
                color: root.borderColor
            }
        }

        // Layer 3: Top Glossy Highlight (simulates light reflection)
     /*   Rectangle {
            id: topHighlight
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                topMargin: root.borderWidth
                leftMargin: root.borderWidth
                rightMargin: root.borderWidth
            }
            height: parent.height * 0.45
            radius: root.radius - root.borderWidth

            // Clip to rounded top, flat bottom for highlight
            // Using a second rectangle to mask the bottom
            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                gradient: Gradient {
                    GradientStop {
                        position: 0.0
                        color: Qt.rgba(1.0, 1.0, 1.0, root.highlightOpacity)
                    }
                    GradientStop {
                        position: 1.0
                        color: Qt.rgba(1.0, 1.0, 1.0, 0.0)
                    }
                }
            }

            // Mask out the bottom half to create a curved highlight effect
            Rectangle {
                anchors {
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                }
                height: parent.height * 0.5
                color: "transparent"
            }
        }*/

        // Layer 4: Bottom Shadow Overlay (adds depth)
        Rectangle {
            id: bottomShadow
            anchors {
                bottom: parent.bottom
                left: parent.left
                right: parent.right
                bottomMargin: root.borderWidth
                leftMargin: root.borderWidth
                rightMargin: root.borderWidth
            }
            height: parent.height * 0.35
            radius: root.radius - root.borderWidth

            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: Qt.rgba(0.0, 0.0, 0.0, 0.0)
                }
                GradientStop {
                    position: 1.0
                    color: Qt.rgba(0.0, 0.0, 0.0, 0.15)
                }
            }
        }

        // Layer 5: Text Label
        Label {
            id: buttonText
            anchors {
                centerIn: parent
                verticalCenterOffset: -1  // Slight optical correction
            }

            // Use Theme font with adaptive sizing
            font {
                family: Theme.fontFamilyHeading
                pixelSize: Theme.fontSizeSmall
                bold: true
            }

            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            // Subtle text shadow for depth
            style: Text.Raised
            styleColor: Qt.rgba(0, 0, 0, 0.3)

            // Ensure text fits
            elide: Text.ElideRight
            maximumLineCount: 1
        }

        // =====================================================================
        // Pressed State Overlay
        // =====================================================================

        Rectangle {
            id: pressOverlay
            anchors.fill: buttonBody
            radius: buttonBody.radius
            color: "black"
            opacity: root.pressed ? 0.15 : 0.0

            Behavior on opacity {
                NumberAnimation { duration: 80 }
            }
        }

        // =====================================================================
        // Signals
        // =====================================================================

        signal clicked()
        signal pressAndHold()

        onReleased: {
            if (containsMouse) {
                root.clicked()
            }
        }

        onPressAndHold: root.pressAndHold()
    }
