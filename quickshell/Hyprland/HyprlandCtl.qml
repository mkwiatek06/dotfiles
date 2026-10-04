pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Io
import "../Config" as Config

Scope {
    property var dTab: [
        ["hl.config({decoration={rounding=12}})"],
        ["hl.config({decoration={rounding_power=1}})"],
        ["hl.config({general={col={active_border=0xeeed0bff}}})"],
    ]
    property var lTab: [
        ["hl.config({decoration={rounding=8}})"],
        ["hl.config({decoration={rounding_power=2}})"],
        ["hl.config({general={col={active_border=0xffffffff}}})"],
    ]
    property string monitor: ""
    property string dWallpaper: "~/Pictures/wallpapers/Wallpaper Alchemy - Ellen Joe Maid Wallpaper – Zenless Zone Zero 4K.jpg"
    property string lWallpaper: "~/Pictures/wallpapers/Frieren-1.jxl"
    property string fitMode: "cover"
    property var tab: []
    property int index: 0

    Process {
        id: hyprPaper
        running: false
        command: [
            "hyprctl",
            "hyprpaper",
            "wallpaper",
            monitor + "," + (Config.Theme.darkMode ? dWallpaper : lWallpaper) + "," + fitMode
        ]
    }

    Process {
        id: hyprTheme
        running: false
        command: []
        onExited: {
            if(index < tab.length) {
                applySetting()
            }
        }
    }

    function applyTheme() {
        tab = Config.Theme.darkMode ? dTab : lTab
        index = 0
        hyprPaper.running = false
        hyprPaper.running = true
        applySetting()    
    }
    
    function applySetting() {
        hyprTheme.command = [
            "hyprctl",
            "eval",
            tab[index],
        ]
        hyprTheme.running = true
        index++
    }
}

