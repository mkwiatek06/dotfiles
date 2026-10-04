import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts
import "Config" as Config

ColumnLayout {
	property var symbols: ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十"]
	property var workspacePTRs: ({})
	property var toBlink
	
	Repeater {
		model: Hyprland.workspaces

		Text {
			// property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
			// property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
			property var ws: modelData.id
			property bool isActive: Hyprland.focusedWorkspace?.id === ws
			property var blinking: false

			visible: ws > 0 ? true : false
			text: symbols[ws - 1] ?? "ERR"
			color: Config.Theme.darkMode ? (blinking ? "#00FFFF" : (isActive ? "#ED0BFF" : "#FFFFFF")) : (blinking ? "#ED0BFF" : (isActive ? "#FFFFFF" : "#818181"))
			font.pixelSize: 20
			anchors.topMargin: 3
			anchors.bottomMargin: 3

			TapHandler {
				onTapped: Hyprland.dispatch("hl.dsp.focus({ workspace = " + (ws) + " })")
			}
			// MouseArea {
			// 	anchors.fill: parent
			// 	onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + (ws) + " })")
			// }

			Component.onCompleted: {
				workspacePTRs[ws] = this
			}								
		}

			// Layout.preferredHeight: 1
			// implicitHeight: 1
	}

	function blink(wsid: int) {
		toBlink = wsid
		workspacePTRs[toBlink].blinking = true
		blinkTimer.restart()
	}

	Timer {
		id: blinkTimer
		interval: 500
		running: false

		onTriggered: {
			workspacePTRs[toBlink].blinking = false
		}
	}
}


