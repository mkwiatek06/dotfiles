import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import "Config" as Config

Scope {
	PanelWindow {
  		anchors {
			left: true
			top: true
			bottom: true
		}
  		WlrLayershell.layer: WlrLayer.Bottom
		implicitWidth: 100
	    WlrLayershell.exclusiveZone: 50
		color: "transparent"		

		Rectangle {
			Layout.alignment: Qt.AlignHCenter
            width: 50
            height: parent.height
            radius: parent.radius
			
			implicitWidth: 50
			color: Config.Theme.darkMode ? "#000000" : "#A9222222"

			Image {
				anchors.fill: parent
				source: "/home/x4sh3n/Pictures/wallpapers/Frieren-1-Sidebar.jxl"
				fillMode: Image.PreserveAspectCrop
				layer.enabled: true
				layer.effect: MultiEffect {
					blurEnabled: Config.Theme.darkMode ? false : true
					blurMax: 64
					blur: 0.7
				}
				z: -1
			}		

			layer.enabled: true
			layer.effect: MultiEffect {
				shadowEnabled: true
				shadowColor: Config.Theme.darkMode ? "#FF00FF" : "#000000"
				shadowVerticalOffset: 0
				shadowHorizontalOffset: 0
				blurMax: 50
			}

				ColumnLayout {


					
					id: uwu
					anchors {
						centerIn: parent
						fill: parent
						margins: 8
					}

					
					Network {
						Layout.alignment: Qt.AlignHCenter
					}

					Loader {
						active: Config.Theme.darkMode

						sourceComponent: Component {
							BootInfo {
								Layout.alignment: Qt.AlignHCenter
							}
						}
					}

					MPRIS {
						// Layout.alignment: Qt.AlignHCenter
					}

					Item { Layout.fillHeight: true }

					WorkspaceWidget {
						Layout.alignment: Qt.AlignHCenter
					}

					Item { Layout.fillHeight: true }

					ClockWidget {
						Layout.alignment: Qt.AlignHCenter
					}

				}
		}
	}
}
