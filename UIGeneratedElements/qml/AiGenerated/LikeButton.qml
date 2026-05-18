import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.Layouts 1.0

/**
 * A reusable "Like" (thumbs-up) button for Aurora OS / Sailfish OS.
 *
 * Example usage:
 *   LikeButton {
 *       liked: model.liked
 *       likeCount: model.likeCount
 *       showCount: true
 *       onTriggered: model.toggleLike()
 *   }
 */
Item {
    id: root

    // ── Public Properties ────────────────────────────────────────

    /** Whether the item is currently liked. */
    property bool liked: false

    /** Fill color when liked. */
    property color activeColor: Theme.highlightColor

    /** Fill color when not liked. */
    property color inactiveColor: Theme.secondaryColor

    /** Diameter / side length of the icon. */
    property real iconSize: Theme.iconSizeMedium

    /** Number to display next to the icon (e.g. like count). */
    property int likeCount: 0

    /** Show the count label when likeCount > 0. */
    property bool showCount: true

    // ── Signals ──────────────────────────────────────────────────

    /** Emitted every time the button is tapped (after toggling `liked`). */
    signal triggered()

    // ── Implicit Size ────────────────────────────────────────────

    implicitWidth: contentRow.width
    implicitHeight: contentRow.height

    // ── Content ──────────────────────────────────────────────────

    RowLayout {
        id: contentRow

        spacing: Theme.paddingSmall
        anchors.centerIn: parent

        // ── Icon (Canvas-drawn thumbs-up) ────────────────────────

        Item {
            id: iconWrapper

            width: root.iconSize
            height: root.iconSize
            Layout.alignment: Qt.AlignVCenter

            Canvas {
                id: thumbCanvas

                anchors.fill: parent

                onPaint: {
                    var ctx = getContext('2d')
                    ctx.clearRect(0, 0, width, height)

                    var s  = width / 24                          // scale 24×24 → actual size
                    var fc = root.liked ? root.activeColor
                                        : root.inactiveColor

                    ctx.save()
                    ctx.scale(s, s)
                    ctx.fillStyle = fc.toString()

                    // ── Palm / wrist base (left bar) ─────────────
                    ctx.beginPath()
                    ctx.moveTo(1, 21)
                    ctx.lineTo(5, 21)
                    ctx.lineTo(5, 9)
                    ctx.lineTo(1, 9)
                    ctx.closePath()
                    ctx.fill()

                    // ── Thumb + hand (Material "thumb up" path) ──
                    ctx.beginPath()
                    ctx.moveTo(23, 10)
                    ctx.bezierCurveTo(23,   8.9,  22.1, 8,    21,   8)
                    ctx.lineTo(14.69, 8)
                    ctx.lineTo(15.64, 3.43)
                    ctx.lineTo(15.67, 3.11)
                    ctx.bezierCurveTo(15.67, 2.7,  15.5,  2.32, 15.23, 2.05)
                    ctx.lineTo(14.17, 1)
                    ctx.lineTo(7.59,  7.59)
                    ctx.bezierCurveTo(7.22,  7.95, 7,     8.45, 7,     9)
                    ctx.lineTo(7, 19)
                    ctx.bezierCurveTo(7,     20.1, 7.9,   21,   9,     21)
                    ctx.lineTo(18, 21)
                    ctx.bezierCurveTo(18.83, 21,   19.54, 20.5, 19.84, 19.78)
                    ctx.lineTo(22.86, 12.73)
                    ctx.bezierCurveTo(22.95, 12.5, 23,    12.26,23,    12)
                    ctx.lineTo(23, 10)
                    ctx.closePath()
                    ctx.fill()

                    ctx.restore()
                }

                // Repaint whenever visual dependencies change
                Connections {
                    target: root
                    onLikedChanged:       thumbCanvas.requestPaint()
                    onActiveColorChanged: thumbCanvas.requestPaint()
                    onInactiveColorChanged:thumbCanvas.requestPaint()
                }
            }

            // Bounce animation on toggle
            SequentialAnimation {
                id: bounceAnim

                NumberAnimation {
                    target: iconWrapper
                    property: "scale"
                    to: 1.25
                    duration: 90
                    easing.type: Easing.OutQuad
                }
                NumberAnimation {
                    target: iconWrapper
                    property: "scale"
                    to: 1.0
                    duration: 130
                    easing.type: Easing.InOutQuad
                }
            }
        }

        // ── Count Label ──────────────────────────────────────────

        Label {
            id: countLabel

            visible: root.showCount && root.likeCount > 0
            text: root.likeCount.toString()
            font.pixelSize: Theme.fontSizeSmall
            color: root.liked ? root.activeColor : Theme.primaryColor
            Layout.alignment: Qt.AlignVCenter
        }
    }

    // ── Interaction ──────────────────────────────────────────────

    MouseArea {
        id: mouseArea

        anchors.fill: parent

        onPressedChanged: {
            iconWrapper.scale = pressed ? 0.88 : 1.0
        }

        onClicked: {
            root.liked = !root.liked
            bounceAnim.start()
            root.triggered()
        }
    }
}
