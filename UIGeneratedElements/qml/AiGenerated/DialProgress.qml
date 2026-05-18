// DialProgress.qml
import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.Layouts 1.0

Item {
    id: root

    // === Публичные свойства (lowercase) ===
    property real value: 0.0
    property real minimumValue: 0.0
    property real maximumValue: 1.0
    property real trackWidth: Theme.paddingLarge
    property bool roundCaps: true

    // Цвета
    property color trackColor: "#E8E4E0"
    property color progressStartColor: "#3366FF"   // Синий
    property color progressEndColor: "#CC44EE"      // Фиолетово-розовый
    property color centerColor: "#FFFFFF"
    property color textColor: "#333333"

    // Размер — адаптивный
    property int dialSize: Math.min(parent.width, parent.height) > 0
                          ? Math.min(parent.width, parent.height)
                          : Theme.itemSizeExtraLarge * 2.5

    // === Внутренние вычисления ===
    property real normalizedValue: {
        var range = maximumValue - minimumValue
        return range > 0 ? Math.max(0, Math.min(1, (value - minimumValue) / range)) : 0
    }

    width: dialSize
    height: dialSize
    anchors.centerIn: parent

    // === 1. Внешний светлый ободок/фон ===
    Rectangle {
        id: outerRing
        anchors.fill: parent
        radius: width / 2
        color: "#F0EEEC"
        border.width: 1
        border.color: "#D8D4D0"

        // Лёгкий внутренний градиент для объёма
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            color: "transparent"

            // Внутренняя тень ободка
            Rectangle {
                anchors.fill: parent
                anchors.margins: Theme.paddingSmall / 2
                radius: width / 2
                color: "transparent"
                border.width: 2
                border.color: "#FFFFFF"
                opacity: 0.6
            }
        }
    }

    // === 2. Трек прогресса (фоновая дуга) ===
    Canvas {
        id: trackCanvas
        anchors.fill: parent
        antialiasing: true

        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)

            var centerX = width / 2
            var centerY = height / 2
            var radius = (Math.min(width, height) / 2) - (root.trackWidth / 2) - Theme.paddingMedium

            ctx.beginPath()
            ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI, false)
            ctx.lineWidth = root.trackWidth
            ctx.strokeStyle = root.trackColor
            ctx.lineCap = "butt"
            ctx.stroke()
        }
    }

    // === 3. Прогресс-дуга с градиентом и тенью ===
    Item {
        id: progressContainer
        anchors.fill: parent

        // Тень под прогресс-дугой
        Canvas {
            id: shadowCanvas
            anchors.fill: parent
            antialiasing: true
            opacity: 0.25

            property real startAngle: -Math.PI / 2
            property real endAngle: startAngle + (2 * Math.PI * root.normalizedValue)

            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)

                if (root.normalizedValue <= 0) return

                var centerX = width / 2
                var centerY = height / 2
                var radius = (Math.min(width, height) / 2) - (root.trackWidth / 2) - Theme.paddingMedium

                // Смещение тени
                var offsetX = 3
                var offsetY = 4

                ctx.beginPath()
                ctx.arc(centerX + offsetX, centerY + offsetY, radius, startAngle, endAngle, false)
                ctx.lineWidth = root.trackWidth
                ctx.strokeStyle = "#000000"
                ctx.lineCap = root.roundCaps ? "round" : "butt"
                ctx.shadowColor = "#000000"
                ctx.shadowBlur = 8
                ctx.shadowOffsetX = 2
                ctx.shadowOffsetY = 3
                ctx.stroke()
            }
        }

        // Сама прогресс-дуга
        Canvas {
            id: progressCanvas
            anchors.fill: parent
            antialiasing: true
            renderTarget: Canvas.FramebufferObject

            property real startAngle: -Math.PI / 2
            property real endAngle: startAngle + (2 * Math.PI * root.normalizedValue)

            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)

                if (root.normalizedValue <= 0) return

                var centerX = width / 2
                var centerY = height / 2
                var radius = (Math.min(width, height) / 2) - (root.trackWidth / 2) - Theme.paddingMedium

                // Создаём градиент по дуге (приближённо через линейный)
                var gradient = ctx.createLinearGradient(
                    centerX - radius, centerY - radius,
                    centerX + radius, centerY + radius
                )
                gradient.addColorStop(0, root.progressStartColor)
                gradient.addColorStop(0.5, "#7744FF")
                gradient.addColorStop(1, root.progressEndColor)

                ctx.beginPath()
                ctx.arc(centerX, centerY, radius, startAngle, endAngle, false)
                ctx.lineWidth = root.trackWidth
                ctx.strokeStyle = gradient
                ctx.lineCap = root.roundCaps ? "round" : "butt"
                ctx.stroke()
            }
        }
    }

    // === 4. Центральный белый круг с тенью ===
    Rectangle {
        id: centerCircle
        anchors.centerIn: parent
        width: parent.width - (root.trackWidth * 2) - (Theme.paddingLarge * 1.5)
        height: width
        radius: width / 2
        color: root.centerColor

        // Внешняя тень (под кругом)
        Rectangle {
            anchors.fill: parent
            anchors.margins: -Theme.paddingSmall
            radius: width / 2
            color: "transparent"
            border.width: Theme.paddingSmall
            border.color: "#000000"
            opacity: 0.08
        }

        // Внутренняя мягкая тень/выпуклость
        Rectangle {
            anchors.fill: parent
            anchors.margins: 1
            radius: width / 2
            color: "transparent"
            border.width: 1
            border.color: "#FFFFFF"
            opacity: 0.8
        }

        // Текст процентов
        Label {
            id: percentLabel
            anchors.centerIn: parent
            text: Math.round(root.normalizedValue * 100) + "%"
            font.pixelSize: Math.floor(parent.width * 0.35)
            font.bold: false
            color: root.textColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    // === Обновление канвасов ===
    onNormalizedValueChanged: {
        shadowCanvas.requestPaint()
        progressCanvas.requestPaint()
    }
    onTrackWidthChanged: {
        trackCanvas.requestPaint()
        shadowCanvas.requestPaint()
        progressCanvas.requestPaint()
    }

    Component.onCompleted: {
        trackCanvas.requestPaint()
        shadowCanvas.requestPaint()
        progressCanvas.requestPaint()
    }
}
