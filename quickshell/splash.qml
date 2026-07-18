import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: splashWindow
    title: "splashHint"
    visible: true
    flags: Qt.SplashScreen
    // | Qt.FramelessWindowHint | Qt.WindowStaysOnBottomHint 
    color: "#00000000"
    width: 800
    height: 50

    Text {
        id: splashText
        anchors.centerIn: parent
        text: "meow"
        color: "white"
        font.pixelSize: 32
    }
}
