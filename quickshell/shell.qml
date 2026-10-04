// shell.qml
import Quickshell
import Quickshell.Wayland
import QtQuick
import Quickshell.Io
import "Config" as Config
import "Hyprland" as Hyprland

ShellRoot {
	Bar {
		id: mainBar
	}

	DarkThemeSwitcher {}
	
	VolumePopup {
		id: volumePopup
	}

	PowerMenu {
		id: powerMenu
	}


	IpcHandler {
	    target: "volume"

	    function display() {
	        volumePopup.display()
	    }
	}

	IpcHandler {
	    target: "powermenu"

	    function display() {
	        powerMenu.display()
	    }
	}

	IpcHandler {
		target: "theme"

		function darkMode(mode: bool): void {
			Config.Theme.darkMode = mode
			Hyprland.HyprlandCtl.applyTheme()
		}
		
		function toggle(): void {
			if(Config.Theme.darkMode) {
				Config.Theme.darkMode = false
			} else {
				Config.Theme.darkMode = true
			}
			Hyprland.HyprlandCtl.applyTheme()
		}
	}

	IpcHandler {
	    target: "workspaces"

	    function blink(id: int) {
	        mainBar.workspaces.blink(id)
	    }
	}
}
