// shell.qml
import Quickshell
import Quickshell.Wayland
import QtQuick
import Quickshell.Io
import "Config" as Config

ShellRoot {
	Bar {}

	HyprlandCtl {
		id: hyprland
	}
	
	VolumePopup {
		id: volumePopup
	}

	IpcHandler {
	    target: "volume"

	    function display() {
	        volumePopup.display()
	    }
	}

	IpcHandler {
		target: "theme"

		function darkMode(mode: bool): void {
			Config.Theme.darkMode = mode
			hyprland.applyTheme()
		}
	}
}
