import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Services.Mpris

Item {
    // width: 200
    // height: 30
    clip: true
    property var player: Mpris.players.values[0]
    
	Text {
	    text: {
	        id: songData
	        
	        if(!player) {
	            return ""
	        } else {
	            return player.trackArtist + " - " + player.trackTitle
	        }
	    }
        color: "#FFFFFF"
        font.family: "Iosevka Curly"
	    Layout.alignment: Qt.AlignHCenter
        x: 20
        y: 20
        NumberAnimation on x {
            from: 30
            to: -songData.width
            duration: 3000
            loops: Animation.Infinite
        }
    
    }
}
