import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: window
    visible: true
    width: 400
    height: 400
    title: "Fibonacci Sequence Generator"
    color: themeToggle.checked ? "#ffffff" : "#2b2b2b"

    Rectangle {
        anchors.fill: parent
        color: themeToggle.checked ? "#ffffff" : "#2b2b2b"

        // Exit button at top left
        Button {
            text: "Exit"
            width: 80
            height: 40
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: 10
            onClicked: Qt.quit()
            font.pixelSize: 16
            background: Rectangle {
                color: themeToggle.checked ? "#e74c3c" : "#c0392b"
                radius: 5
            }
        }

        // Theme toggle button at top right
        CheckBox {
            id: themeToggle
            text: "Light Theme"
            
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 10
            font.pixelSize: 16
            onCheckedChanged: {
                if (checked) {
                    themeToggle.text = "Dark Theme"
                } else {
                    themeToggle.text = "Light Theme"
                }
            }
        }

        Column {
            anchors.centerIn: parent
            spacing: 10

            Text {
                text: "Fibonacci Sequence Generator"
                font.pixelSize: 24
                color: themeToggle.checked ? "#000000" : "#61dafb"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            TextField {
                id: inputField
                width: 300
                placeholderText: "Enter the number of terms"
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 18
                inputMethodHints: Qt.ImhDigitsOnly
                color: themeToggle.checked ? "#000000" : "#ffffff"
                background: Rectangle {
                    color: themeToggle.checked ? "#dddddd" : "#444444"
                    radius: 5
                }
            }

            Button {
                text: "Generate"
                width: 150
                height: 40
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    if (inputField.text) {
                        app.generateFibonacci(parseInt(inputField.text))
                    } else {
                        inputField.placeholderText = "Please enter a number"
                    }
                }
                font.pixelSize: 18
                background: Rectangle {
                    color: themeToggle.checked ? "#3498db" : "#2980b9"
                    radius: 5
                }
            }

            ListView {
                id: fibonacciList
                width: 300
                height: 100
                model: fibonacciModel
                delegate: Item {
                    width: 300
                    height: 30

                    Text {
                        text: modelData
                        font.pixelSize: 16
                        color: themeToggle.checked ? "#000000" : "white"
                    }
                }
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true
            }

            TextArea {
                id: outputArea
                width: 300
                height: 100
                readOnly: true
                font.pixelSize: 16
                color: themeToggle.checked ? "#000000" : "white"
                
                wrapMode: TextEdit.Wrap
                text: app.fibonacciOutput
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
}
