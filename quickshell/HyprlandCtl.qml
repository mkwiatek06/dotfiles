import Quickshell
import QtQuick
import Quickshell.Io
import "Config" as Config

Scope {
    property var dTab: [
        ["general:col.active_border", "rgba(ed0bffee)"],
    ]
    property var lTab: [
        ["general:col.active_border", "rgba(ffffffff)"],
    ]
    property string monitor: ""
    property string dWallpaper: "~/Pictures/wallpapers/Wallpaper Alchemy - Ellen Joe Maid Wallpaper – Zenless Zone Zero 4K.jpg"
    property string lWallpaper: "~/Pictures/wallpapers/Frieren-1.jxl"
    property string fitMode: "cover"

    Process {
        id: hyprTheme
        running: false
        command: []
        onStarted: console.log(command)
    }
    
    Process {
        id: hyprPaper
        running: true
        command: [
            "hyprctl",
            "hyprpaper",
            "wallpaper",
            monitor + "," + (Config.Theme.darkMode ? dWallpaper : lWallpaper) + "," + fitMode
            // '${monitor},${Config.Theme.darkMode ? dWallpaper : lWallpaper},${fitMode}'
        ]
        onStarted: console.log(command)
    }

    function applyTheme() {
        hyprTheme.running = false
        hyprTheme.running = true
        hyprPaper.running = false
        hyprPaper.running = true
        for(let row of Config.Theme.darkMode ? dTab : lTab) {
            hyprTheme.command = [
                "hyprctl",
                "keyword",
                row[0],
                row[1]
            ]
            hyprTheme.running = true
        }
    }
}

