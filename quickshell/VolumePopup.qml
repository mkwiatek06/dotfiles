import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick

PanelWindow {
    id: root

    property bool visibility: false
    property int volume: 0
    property string version: "0.0"

    visible: visibility

    screen: Quickshell.screens[0]
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.exclusiveZone: 0

    anchors {
        bottom: true
    }

    implicitWidth: 350
    implicitHeight: 50

    color: "#00000000"

    margins {
        bottom: 100
    }
    
    Rectangle {
        anchors.fill: parent
        radius: 0
        color: "#000000"
        border.width: 0.5
        border.color: "#FFFFFF"

        Row {
            anchors.centerIn: parent
            spacing: 10

            Text {
                anchors.verticalCenter: parent.verticalCenter
                    // anchors.verticalCenterOffset: 5
                text: root.volume + "%"
                color: "white"
                font.pixelSize: 22
                font.family: "Iosevka Curly"
            }

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                    // anchors.verticalCenterOffset: 5
                width: 270
                height: 20
                radius: 0
                color: "#303030"

                Text {
                    // anchors.right: parent
                    x: parent.width - width
                    y: parent.height - height + 15
                    // anchors.verticalCenterOffset: 17
                    // anchors.horizontalCenterOffset: 110
                    text: version
                    color: "white"
                    font.pixelSize: 10
                    font.family: "Iosevka Curly"
                }

                Rectangle {
                    width: parent.width * root.volume / 100
                    height: parent.height
                    radius: parent.radius
                    color: "#FFFFFF"
                }
            }
        }
    }

    Timer {
        id: hideTimer
        interval: 2000
        running: false

        onTriggered: {
            root.visibility = false
        }
    }

    function display() {
        // console.log("Showing volume popup")
        // volume = vol
        // visibility = true
        // hideTimer.restart()
        volumeGet.running = true
    }

    
    Process {
        id: volumeGet

        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]

        stdout: StdioCollector {
            onStreamFinished: {
                // let match = this.text.match(/Volume:\s+([0-9.]+)/)

                // if (match) {
                //     root.show(Math.round(parseFloat(match[1]) * 100))
                // }
            let match = this.text.match(/Volume:\s+([0-9.]+)/)

            if (match) {
                root.volume = Math.round(parseFloat(match[1]) * 100)
                root.visibility = true
                hideTimer.restart()
            }
                }
        }

    }        
    Process {
        id: pipewireVer
        running: true

        command: ["pacman", "-Q", "pipewire"]

        stdout: StdioCollector {
            onStreamFinished: {
                let pos = this.text.indexOf(" ") + 1
                root.version = "ver." + this.text.substring(pos)
            }
        }
    }
}
