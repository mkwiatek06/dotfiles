import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts
import Quickshell.Io


ColumnLayout {
    id: root
    property string kernel: "unkwn"
    property string bootMode: "unkwn"
    property string sysdStat: "unkwn"
    property bool vulnerable: false

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

    Timer {
        id: sysdTimer
        
        interval: 2000
        running: false
        repeat: false

        onTriggered: {
            getSysdStat.running = true
            console.log(sysdStat)
        }
    }
	Text {
	    Process {
            id: getSysdStat
    		running: true
    		command: [ "systemctl", "is-system-running" ]
    		stdout: StdioCollector {
    		    onStreamFinished: {
                    console.log(this.text)
    		        if(this.text.trim() === "running") {
    		            sysdStat = "sd_OK"
        		    } else if(this.text.trim() === "degraded") {
        		        sysdStat = "sd_DEG"
        		    } else if(this.text.trim() === "starting") {
        		        sysdStat = "BOOT"
        		        sysdTimer.restart()
        		    } else if(this.text.trim() === "initializing") {
        		        sysdStat = "INIT"
        		        sysdTimer.restart()
        		    } else if(this.text.trim() === "offline" || this.text.trim() === "unknown") {
        		        sysdStat = "_ERR"
        		        sysdTimer.restart()
        		    } else {
        		        sysdStat = "UNKWN"
        		        sysdTimer.restart()
        		    }
    		    }
    		}
	    }
	    
        text: sysdStat
        color: sysdStat === "sd_OK" ? "#0000FF" :
               sysdStat === "sd_DEG" ? "#00FFFF" :
               sysdStat === "BOOT" ? "#313131" :
               sysdStat === "INIT" ? "#FFFFFF" :
               sysdStat === "_ERR" ? "#FF0000" :
               "#313131"
        font.family: "Iosevka Curly"
    	Layout.alignment: Qt.AlignHCenter
	}
	
	Text {
	    Process {
            id: getVulns
    		running: true
    		command: [ "grep", "-l", "'^Vulnerable'", "/sys/devices/system/cpu/vulnerabilities" ]
    		stdout: StdioCollector {
    		    onStreamFinished: {
                    console.log(this.text)
                    if(this.text === "") {
                        vulnerable = false
                    } else {
                        vulnerable = true
                    }
    		    }
    		}
	    }
	    
        text: vulnerable === false ? "vu_OK" :
              "VULN!"
        color: vulnerable === false ? "#0000FF" :
               "#FF0000"
        font.family: "Iosevka Curly"
    	Layout.alignment: Qt.AlignHCenter
    	}
}


