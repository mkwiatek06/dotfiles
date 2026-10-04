// DEPS: pacman, pipewire, wpctl

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick

PanelWindow {
    id: root

    property bool visibility: false
    property int volume: 0
    property bool muted: false
    property string version: "0.0"
    property string devname: "unknown"

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
                id: percentage
                anchors.verticalCenter: parent.verticalCenter
                // width: percentageMetrics.width
                text: root.volume.toString().length == 2 ? ("<font color=\"#1F1F1F\">0</font>" + root.volume + "%")
                    : (root.volume.toString().length == 1 ? ("<font color=\"#1F1F1F\">00</font>" + root.volume + "%")
                        : (root.volume + "%"))
                color: "white"
                font.pixelSize: 22
                font.family: "Iosevka Curly"
            }

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                width: 270
                height: 20
                radius: 0
                color: "#303030"

                Text {
                    x: 0
                    y: parent.height
                    text: devname
                    color: "white"
                    font.pixelSize: 10
                    font.family: "Iosevka Curly"
                }

                Text {
                    id: ver
                    x: parent.width - width
                    y: parent.height
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

                Text {
                    x: 2
                    y: 0

                    visible: root.muted
                    text: "MUTED"
                    color: "black"
                    font.pixelSize: 18
                    font.family: "Iosevka Curly"
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
        volumeGet.running = true
        getDevName.running = true
    }

    
    Process {
        id: volumeGet

        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]

        stdout: StdioCollector {
            onStreamFinished: {
				let words = this.text.split(" ")

				if (words) {
					root.volume = Math.round(parseFloat(words[1]) * 100)
					if(typeof(words[2]) === 'undefined') {
						root.muted = false
					} else {
						root.muted = true
					}
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

    Process {
        id: getDevName
        command: ["wpctl", "list"]

        stdout: StdioCollector {
            onStreamFinished: {
                let lines = this.text.split("\n")
                for (const oneline of lines) {
                    if (oneline.includes("\*") && oneline.includes("alsa_output")) {
                        let myline = oneline.substring(oneline.indexOf(".") + 1)
                        myline = myline.slice(myline.indexOf(".") + 1, myline.search(/\s/))
                        if (myline.length > 30) {
                            myline = myline.slice(0, 27) + "..."
                        }
                        root.devname = myline
                        break
                    }
                }
            }
        }
    }
}
