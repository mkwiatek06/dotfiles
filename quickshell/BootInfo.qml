import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts
import Quickshell.Io


ColumnLayout {
    property string kernel: "unkwn"
    property string bootMode: "unkwn"
	Text {
	    Process {
            id: getKernel
    		running: true
    		command: [ "uname", "-r" ]
    		stdout: StdioCollector {
    		    onStreamFinished: {
    		        let head = this.text.indexOf("-")
    		        if(head != 0) {
        		        kernel = this.text.substring(0, head)
        		    }
                    console.log(kernel)
    		    }
    		}
	    }
    text: kernel
    color: "#FFFFFF"
    font.family: "Iosevka Curly"
	Layout.alignment: Qt.AlignHCenter
	}
	Text {
	    Process {
            id: getBootMode
    		running: true
    		command: [ "test", "-d", "/sys/firmware/efi" ]
		    onExited: {
		        if(exitCode === 0) {
    		        bootMode = "UEFI"
    		    } else {
    		        bootMode = "BIOS"
    		    }
		    }
	    }
    text: bootMode
    color: "#FFFFFF"
    font.family: "Iosevka Curly"
	Layout.alignment: Qt.AlignHCenter
	}
}


