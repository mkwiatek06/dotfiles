import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects


Scope {
		PanelWindow {
			implicitWidth: 50
			color: "#000000"		
			anchors {
				left: true
				top: true
				bottom: true
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

					BootInfo {
						Layout.alignment: Qt.AlignHCenter
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
