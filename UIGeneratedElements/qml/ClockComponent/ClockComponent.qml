import QtQuick 2.0
import QtQuick.Layouts 1.0


Item {
    id: root

    // === Размеры по умолчанию ===
    width: 400
    height: 500

    // === Фон ===
    Rectangle {
        anchors.fill: parent
        color: "#1E1E2E"
        radius: 12
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 16

        // === ЧАСЫ ===
        AnalogClock {
            id: clock
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: Math.min(root.width, root.height * 0.6) - 32
            Layout.preferredHeight: Layout.preferredWidth

            // Начальные значения (совпадают с настройками по умолчанию)
            faceColor: "#5B4FC4"
            borderColor: "#FFFFFF"
            hourHandColor: "#FFFFFF"
            minuteHandColor: "#FFFFFF"
            secondHandColor: "#FF6B6B"
            centerDotColor: "#FF6B4B"
        }

        // === ПАНЕЛЬ УПРАВЛЕНИЯ ===
     /*     ClockSettings {
          Layout.fillWidth: true
            Layout.fillHeight: true

            // === Обработка изменений ===
            onColorChanged: {
                switch(propertyName) {
                    case "faceColor": clock.faceColor = newColor; break
                    case "borderColor": clock.borderColor = newColor; break
                    case "hourHandColor": clock.hourHandColor = newColor; break
                    case "minuteHandColor": clock.minuteHandColor = newColor; break
                    case "secondHandColor": clock.secondHandColor = newColor; break
                }
            }

            onToggleChanged: {
                switch(propertyName) {
                    case "showSeconds": clock.showSeconds = newValue; break
                    case "smoothSecondHand": clock.smoothSecondHand = newValue; break
                    case "showTicks": clock.showTicks = newValue; break
                    case "running": clock.running = newValue; break
                }
            }

            onValueChanged: {
                switch(propertyName) {
                    case "borderWidth": clock.borderWidth = newValue; break
                }
            }
        }*/
    }
}
