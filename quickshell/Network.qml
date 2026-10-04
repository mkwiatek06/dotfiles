import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import "Config" as Config

Text {
	
	
	id: root
	
	QtObject {
		id: qMLCantDoEnums 

		readonly property int connected: 0
		readonly property int ifUp : 1
		readonly property int ifDown : 2
		readonly property int noHW : 3
		readonly property int unknown : 4
	}

	property int defDevState: qMLCantDoEnums.unknown;
	property string defDev: "";


	Timer {
		interval: 5000
		running: true
		repeat: true

		onTriggered: {
			if(getRoute.running === false && getState.running === false) {
				getRoute.running = true
			}
		}
	}

	Process {
		id: getRoute
		running: true
		command: [ "ip", "-j", "route", "show", "default" ]
		stdout: StdioCollector {
		onStreamFinished: {
				if(this.text === "") {
					if(defDev !== "") {
						getState.command = ["ip", "-j", "link", "show", defDev]
						getState.running = true
					}
				}
				let obj = JSON.parse(this.text)
				if(obj[0]?.dev !== undefined) {
					defDevState = qMLCantDoEnums.connected
					defDev = obj[0].dev
				} else {
					if(defDev !== "") {
						getState.command = ["ip", "-j", "link", "show", defDev]
						getState.running = true
					}
				}
			}
		}
	}

	Process {
		id: getState
		running: false
		stdout: StdioCollector {
			onStreamFinished: {
				if(this.text === "") {
					defDevState = qMLCantDoEnums.noHW
				} else {
					let obj = JSON.parse(this.text)
					if(obj[0].operstate === "UP") {
						defDevState = qMLCantDoEnums.ifUp
					} else {
						defDevState = qMLCantDoEnums.ifDown
					}
				}
			}
		}
	}
	
	Process {
		id: check
		running: false
		stdout: StdioCollector {
			onStreamFinished: {
				let obj = JSON.parse(this.text)
				if(obj[0].operstate === "UP") {
					defDevState = qMLCantDoEnums.ifUp
				} else {
					
				}
			}
		}
	}

	text:  !Config.Theme.darkMode ?
		   		defDevState === qMLCantDoEnums.connected ? "󰤨" :
			    defDevState === qMLCantDoEnums.connected ? "CONN" :
			    defDevState === qMLCantDoEnums.ifUp ? "OPER" :
			    defDevState === qMLCantDoEnums.ifDown ? "LDWN" :
			    defDevState === qMLCantDoEnums.noHW ? "NoHW" :
			    "UKWN" :
		   defDevState === qMLCantDoEnums.connected ? "CONN" :
		   defDevState === qMLCantDoEnums.ifUp ? "OPER" :
		   defDevState === qMLCantDoEnums.ifDown ? "LDWN" :
		   defDevState === qMLCantDoEnums.noHW ? "NoHW" :
		   "UKWN"
	color: Config.Theme.darkMode === false ? "#FFFFFF" :
		   defDevState === qMLCantDoEnums.connected ? "#ED0BFF" :
		   defDevState === qMLCantDoEnums.ifUp ? "#00FF00" :
		   defDevState === qMLCantDoEnums.ifDown ? "#FF0000" :
		   defDevState === qMLCantDoEnums.noHW ? "#A1A1A1" :
		   "#444444"
		   
	font.pixelSize: Config.Theme.darkMode ? 18 : 30
	font.family: Config.Theme.darkMode ? "Iosevka Curly" : "Terminess Nerd Font Mono"
	anchors.topMargin: 3
	anchors.bottomMargin: 3
}

