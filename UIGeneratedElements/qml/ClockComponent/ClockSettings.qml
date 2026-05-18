import QtQuick 2.0
import QtQuick.Layouts 1.0
import Sailfish.Silica 1.0

Rectangle {
    id: root
    // === Сигналы для связи с часами ===
    signal colorChanged(string propertyName, color newColor)
    signal toggleChanged(string propertyName, bool newValue)
    signal valueChanged(string propertyName, real newValue)

    property int rowHeight: 50
    property int labelWidth: 160

    color: "#2D2D44"
    radius: 8

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 8

        // === Заголовок ===
        Text {
            text: "⚙ Настройки часов"
            color: "#FFFFFF"
            font.pixelSize: 20
            font.bold: true
            //Layout.alignment: Qt.AlignHCenter
            //Layout.bottomMargin: 10
        }

        // === Цвет циферблата ===
        SettingRow {
            label: "Цвет циферблата"
            ColorButton {
                currentColor: "#5B4FC4"
                onColorSelected: root.colorChanged("faceColor", color)
            }
        }

        // === Цвет ободка ===
        SettingRow {
            label: "Цвет ободка"
            ColorButton {
                currentColor: "#FFFFFF"
                onColorSelected: root.colorChanged("borderColor", color)
            }
        }

        // === Цвет часовой стрелки ===
        SettingRow {
            label: "Часовая стрелка"
            ColorButton {
                currentColor: "#FFFFFF"
                onColorSelected: root.colorChanged("hourHandColor", color)
            }
        }

        // === Цвет минутной стрелки ===
        SettingRow {
            label: "Минутная стрелка"
            ColorButton {
                currentColor: "#FFFFFF"
                onColorSelected: root.colorChanged("minuteHandColor", color)
            }
        }

        // === Цвет секундной стрелки ===
        SettingRow {
            label: "Секундная стрелка"
            ColorButton {
                currentColor: "#FF6B6B"
                onColorSelected: root.colorChanged("secondHandColor", color)
            }
        }

        // === Толщина ободка ===
        //SettingRow {
        SettingRow {
            label: "Толщина ободка"
            Slider {
                minimumValue: 0
                maximumValue: 20
                value: 6
                stepSize: 1
                onValueChanged: root.valueChanged("borderWidth", value)
            }
        }

        // === Показывать секунды ===
        SettingRow {
            label: "Секундная стрелка"
            Switch {
                checked: true
                onCheckedChanged: root.toggleChanged("showSeconds", checked)
            }
        }

        // === Плавная стрелка ===
        SettingRow {
            label: "Плавный ход"
            Switch {
                checked: false
                onCheckedChanged: root.toggleChanged("smoothSecondHand", checked)
            }
        }

        // === Показывать метки ===
        SettingRow {
            label: "Метки на циферблате"
            Switch {
                checked: true
                onCheckedChanged: root.toggleChanged("showTicks", checked)
            }
        }

        // === Запуск/остановка ===
        SettingRow {
            label: "Работа часов"
            Switch {
                checked: true
                onCheckedChanged: root.toggleChanged("running", checked)
            }
        }

        Item { Layout.fillHeight: true }



    }


    // === Вспомогательные компоненты ===

}
