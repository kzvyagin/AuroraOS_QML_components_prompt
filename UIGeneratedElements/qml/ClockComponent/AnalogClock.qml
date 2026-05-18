import QtQuick 2.0

Item {
    id: root

    // === Публичные свойства для управления ===
    property color faceColor: "#5B4FC4"           // Цвет циферблата
    property color borderColor: "#FFFFFF"         // Цвет ободка
    property color hourHandColor: "#FFFFFF"       // Цвет часовой стрелки
    property color minuteHandColor: "#FFFFFF"     // Цвет минутной стрелки
    property color secondHandColor: "#FF6B6B"     // Цвет секундной стрелки
    property color tickColor: "#FFFFFF"           // Цвет меток
    property color centerDotColor: "#FF6B6B"      // Цвет точки в центре

    property int borderWidth: 6                   // Толщина ободка
    property int hourHandWidth: 6                 // Толщина часовой стрелки
    property int minuteHandWidth: 4               // Толщина минутной стрелки
    property int secondHandWidth: 2               // Толщина секундной стрелки
    property int tickWidth: 2                     // Толщина меток

    property real hourHandLength: 0.45            // Длина часовой стрелки (от радиуса)
    property real minuteHandLength: 0.65          // Длина минутной стрелки
    property real secondHandLength: 0.75          // Длина секундной стрелки
    property real tickLength: 0.08                // Длина меток

    property bool showSeconds: true               // Показывать секундную стрелку
    property bool showTicks: true                 // Показывать метки
    property bool smoothSecondHand: false           // Плавная секундная стрелка

    property bool running: true                   // Запущены ли часы

    // === Внутренние свойства ===
    property real _radius: Math.min(width, height) / 2 - 10
    property real _centerX: width / 2
    property real _centerY: height / 2

    // === Таймер ===
    Timer {
        id: clockTimer
        interval: smoothSecondHand ? 50 : 1000
        running: root.running
        repeat: true
        triggeredOnStart: true
        onTriggered: canvas.requestPaint()
    }

    // === Холст для отрисовки ===
    Canvas {
        id: canvas
        anchors.fill: parent
        antialiasing: true
        renderTarget: Canvas.Image

        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)

            var now = new Date()
            var hours = now.getHours()
            var minutes = now.getMinutes()
            var seconds = now.getSeconds()
            var milliseconds = now.getMilliseconds()

            // === Рисуем циферблат ===
            drawFace(ctx)

            // === Рисуем метки ===
            if (showTicks) {
                drawTicks(ctx)
            }

            // === Рассчитываем углы ===
            var secondAngle = smoothSecondHand
                ? (seconds + milliseconds / 1000) * 6 - 90
                : seconds * 6 - 90
            var minuteAngle = (minutes + seconds / 60) * 6 - 90
            var hourAngle = ((hours % 12) + minutes / 60) * 30 - 90

            // === Рисуем стрелки ===
            drawHand(ctx, hourAngle, hourHandLength, hourHandWidth, hourHandColor, true)
            drawHand(ctx, minuteAngle, minuteHandLength, minuteHandWidth, minuteHandColor, false)

            if (showSeconds) {
                drawHand(ctx, secondAngle, secondHandLength, secondHandWidth, secondHandColor, false)
            }

            // === Центральная точка ===
            drawCenterDot(ctx)
        }
    }

    // === Функции отрисовки ===

    function drawFace(ctx) {
        ctx.beginPath()
        ctx.arc(_centerX, _centerY, _radius, 0, 2 * Math.PI)
        ctx.fillStyle = faceColor
        ctx.fill()

        if (borderWidth > 0) {
            ctx.lineWidth = borderWidth
            ctx.strokeStyle = borderColor
            ctx.stroke()
        }
    }

    function drawTicks(ctx) {
        for (var i = 0; i < 12; i++) {
            var angle = i * 30 * Math.PI / 180
            var isMajor = i % 3 === 0
            var tickLen = isMajor ? tickLength * 1.5 : tickLength
            var tickW = isMajor ? tickWidth * 1.5 : tickWidth

            var x1 = _centerX + Math.cos(angle) * (_radius * 0.85)
            var y1 = _centerY + Math.sin(angle) * (_radius * 0.85)
            var x2 = _centerX + Math.cos(angle) * (_radius * 0.85 - _radius * tickLen)
            var y2 = _centerY + Math.sin(angle) * (_radius * 0.85 - _radius * tickLen)

            ctx.beginPath()
            ctx.moveTo(x1, y1)
            ctx.lineTo(x2, y2)
            ctx.lineWidth = tickW
            ctx.strokeStyle = tickColor
            ctx.lineCap = "round"
            ctx.stroke()
        }
    }

    function drawHand(ctx, angleDeg, lengthRatio, width, color, hasArrow) {
        var angleRad = angleDeg * Math.PI / 180
        var length = _radius * lengthRatio

        var x2 = _centerX + Math.cos(angleRad) * length
        var y2 = _centerY + Math.sin(angleRad) * length

        // Основная линия стрелки
        ctx.beginPath()
        ctx.moveTo(_centerX, _centerY)
        ctx.lineTo(x2, y2)
        ctx.lineWidth = width
        ctx.strokeStyle = color
        ctx.lineCap = "round"
        ctx.stroke()

        // Контрастная обводка для лучшей видимости
        ctx.beginPath()
        ctx.moveTo(_centerX, _centerY)
        ctx.lineTo(x2, y2)
        ctx.lineWidth = width + 2
        ctx.strokeStyle = Qt.rgba(0, 0, 0, 0.1)
        ctx.lineCap = "round"
        ctx.stroke()
    }

    function drawCenterDot(ctx) {
        ctx.beginPath()
        ctx.arc(_centerX, _centerY, 6, 0, 2 * Math.PI)
        ctx.fillStyle = centerDotColor
        ctx.fill()

        ctx.beginPath()
        ctx.arc(_centerX, _centerY, 6, 0, 2 * Math.PI)
        ctx.lineWidth = 2
        ctx.strokeStyle = borderColor
        ctx.stroke()
    }
}
