import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick

PanelWindow {
    id: root

    property bool visibility: false
    property var tooltip: ""

    visible: visibility

    screen: Quickshell.screens[0]
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.exclusiveZone: 0

    // anchors {
    //     top: true
    // }

    implicitWidth: 350
    implicitHeight: 200

    focusable: true

    // color: activeFocus ? "#FFFF00FF" : "#00000000"

    // margins {
    //     top: 100
    // }
    
    Rectangle {
        anchors.fill: parent
        radius: 0
        color: "#000000"
        border.width: 0.5
        border.color: "#FFFFFF"

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            // anchors.verticalCenterOffset: 5
            text: "POWER MENU"
            color: "white"
            font.pixelSize: 22
            font.family: "Iosevka Curly"
        }

        Row {
            anchors.centerIn: parent
            spacing: 10


            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                // anchors.verticalCenterOffset: 5
                width: 50
                height: 50
                radius: 30
                color: "#FF0000"
                TapHandler {
    				onTapped: {
    				    testThingy.running = true
        				tooltip = "POWER OFF"
    				}
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    // anchors.right: parent
                    // anchors.verticalCenterOffset: 17
                    // anchors.horizontalCenterOffset: 110
                    text: "ᛋ"
                    color: "white"
                    font.pixelSize: 30
                    font.family: "Iosevka Curly"
                }

            }

            
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                // anchors.verticalCenterOffset: 5
                width: 50
                height: 50
                radius: 30
                color: "#0000FF"
                TapHandler {
    				onTapped: {
    				    testThingy.running = true
        				tooltip = "EXIT HYPRLAND"
    				}
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    // anchors.right: parent
                    // anchors.verticalCenterOffset: 17
                    // anchors.horizontalCenterOffset: 110
                    text: "ᚸ"
                    color: "white"
                    font.pixelSize: 30
                    font.family: "Iosevka Curly"
                }

            }
        }

        
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.y + 130
            // anchors {
            //     bottom: true
            // }
            text: tooltip
            color: "white"
            font.pixelSize: 22
            font.family: "Iosevka Curly"
        }
    }

    Process {
        id: testThingy
        command: ["notify-send", "clicked :3"]
    }

    Timer {
        id: hideTimer
        interval: 7000
        running: false

        onTriggered: {
            root.visibility = false
        }
    }

    function display() {
        // volume = vol
        visibility = true
        hideTimer.restart()
        // volumeGet.running = true
    }

    

    // onActiveChanged: {
    //     if(!active) {
    //         visibility = false
    //     }
    // }

    
    // Process {
    //     id: volumeGet

    //     command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]

    //     stdout: StdioCollector {
    //         onStreamFinished: {
    //             // let match = this.text.match(/Volume:\s+([0-9.]+)/)

    //             // if (match) {
    //             //     root.show(Math.round(parseFloat(match[1]) * 100))
    //             // }
    //         let match = this.text.match(/Volume:\s+([0-9.]+)/)

    //         if (match) {
    //             root.volume = Math.round(parseFloat(match[1]) * 100)
    //             root.visibility = true
    //             hideTimer.restart()
    //         }
    //             }
    //     }

    // }        
    // Process {
    //     id: pipewireVer
    //     running: true

    //     command: ["pacman", "-Q", "pipewire"]

    //     stdout: StdioCollector {
    //         onStreamFinished: {
    //             let pos = this.text.indexOf(" ") + 1
    //             root.version = "ver." + this.text.substring(pos)
    //         }
    //     }
    // }
}
