import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts

ColumnLayout {
	property var symbols: ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十"]
	Repeater {
		model: Hyprland.workspaces

		Text {
			// property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
			// property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
			property var ws: modelData
			property bool isActive: Hyprland.focusedWorkspace?.id === ws.id

			visible: ws.id > 0 ? true : false
			text: symbols[ws.id - 1] ?? ""
			color: isActive ? "#ED0BFF" : (ws ? "#FFFFFF" : "#dddddd")
			font.pixelSize: 20
			anchors.topMargin: 3
			anchors.bottomMargin: 3

			MouseArea {
				anchors.fill: parent
				onClicked: Hyprland.dispatch("workspace " + (ws.id))
			}								
		}

			// Layout.preferredHeight: 1
			// implicitHeight: 1
	}
}


