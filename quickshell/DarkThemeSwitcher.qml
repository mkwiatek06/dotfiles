import QtQuick
import "Config" as Config
import "Hyprland" as Hyprland

Item {
    property var sunset: 20
    property var sunrise: 8 
    property var timer: 0

    Timer {
        id: mainTimer
        interval: timer * 1000 // Seconds to miliseconds
        repeat: false
        running: false
        onTriggered: themeTimer()
    }
    
    function themeTimer() {
        const date = new Date;
        let hour = date.getHours();
        let minute = date.getMinutes();
        let second = date.getSeconds();

        if(hour == sunset) {
            if(Config.Theme.darkMode == true) {
                Hyprland.HyprlandCtl.applyTheme();
                timer = (dayDiff(hour, sunrise) * 3600) - (minute * 60) - second + 1
                mainTimer.restart()
            } else {
                Config.Theme.darkMode = true;
                Hyprland.HyprlandCtl.applyTheme();
                timer = (dayDiff(hour, sunrise) * 3600) - (minute * 60) - second + 1
                mainTimer.restart()
            }
        } else if(hour == sunrise) {
            if(Config.Theme.darkMode == false) {
                Hyprland.HyprlandCtl.applyTheme();
                timer = (dayDiff(hour, sunset) * 3600) - (minute * 60) - second + 1
                mainTimer.restart()
            } else {
                Config.Theme.darkMode = false;
                Hyprland.HyprlandCtl.applyTheme();
                timer = (dayDiff(hour, sunset) * 3600) - (minute * 60) - second + 1
                mainTimer.restart()
            }
        } else {
            if(dayDiff(hour, sunset) < dayDiff(hour, sunrise)) {
                Config.Theme.darkMode = false
                Hyprland.HyprlandCtl.applyTheme();
                timer = (dayDiff(hour, sunset) * 3600) - (minute * 60) - second + 1
                mainTimer.restart()
            } else {
                Config.Theme.darkMode = true
                Hyprland.HyprlandCtl.applyTheme();
                timer = (dayDiff(hour, sunrise) * 3600) - (minute * 60) - second + 1
                mainTimer.restart()
            }
        }

        console.log("\x1b[36m[INFO]\x1b[0m" + " At " + hour + ":" + minute + ":" + second + " theme auto-switch timer set to " + timer + "s");
    }

    // Absolute hour difference (considering next/previous day)
    function dayDiff(thisHour, nextHour) {
        if(thisHour > nextHour) {
            return (24 - thisHour + nextHour)
        } else {
            return (nextHour - thisHour)
        }
    }

    Component.onCompleted: themeTimer()
}

