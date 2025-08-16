{ config, pkgs, ... }:

{
  environment.etc."xdg/waybar/config".text = ''
    {
      "layer": "top",
      "position": "top",
      "height": 30,
      "spacing": 4,
      
      "modules-left": ["sway/workspaces", "sway/mode"],
      "modules-center": ["sway/window"],
      "modules-right": ["network", "pulseaudio", "battery", "clock", "tray"],
      
      "sway/workspaces": {
        "disable-scroll": true,
        "all-outputs": true,
        "format": "{name}: {icon}",
        "format-icons": {
          "1": "",
          "2": "",
          "3": "",
          "4": "",
          "5": "",
          "urgent": "",
          "focused": "",
          "default": ""
        }
      },
      
      "sway/window": {
        "max-length": 50
      },
      
      "network": {
        "format-wifi": "{essid} ({signalStrength}%) ",
        "format-ethernet": "{ipaddr}/{cidr} ",
        "tooltip-format": "{ifname} via {gwaddr} ",
        "format-linked": "{ifname} (No IP) ",
        "format-disconnected": "Disconnected ⚠",
        "format-alt": "{ifname}: {ipaddr}/{cidr}"
      },
      
      "pulseaudio": {
        "format": "{volume}% {icon} {format_source}",
        "format-bluetooth": "{volume}% {icon} {format_source}",
        "format-bluetooth-muted": " {icon} {format_source}",
        "format-muted": " {format_source}",
        "format-source": "{volume}% ",
        "format-source-muted": "",
        "format-icons": {
          "headphone": "",
          "hands-free": "",
          "headset": "",
          "phone": "",
          "portable": "",
          "car": "",
          "default": ["", "", ""]
        },
        "on-click": "pavucontrol"
      },
      
      "battery": {
        "states": {
          "good": 95,
          "warning": 30,
          "critical": 15
        },
        "format": "{capacity}% {icon}",
        "format-charging": "{capacity}% ",
        "format-plugged": "{capacity}% ",
        "format-alt": "{time} {icon}",
        "format-icons": ["", "", "", "", ""]
      },
      
      "clock": {
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
        "format-alt": "{:%Y-%m-%d}"
      },
      
      "tray": {
        "icon-size": 21,
        "spacing": 10
      }
    }
  '';

  environment.etc."xdg/waybar/style.css".text = ''
    * {
      border: none;
      border-radius: 0;
      font-family: "Fira Code", "Font Awesome 5 Free";
      font-size: 13px;
      min-height: 0;
    }

    window#waybar {
      background-color: rgba(43, 48, 59, 0.5);
      border-bottom: 3px solid rgba(100, 114, 125, 0.5);
      color: #ffffff;
      transition-property: background-color;
      transition-duration: .5s;
    }

    button {
      box-shadow: inset 0 -3px transparent;
      border: none;
      border-radius: 0;
    }

    #workspaces button {
      padding: 0 5px;
      background-color: transparent;
      color: #ffffff;
    }

    #workspaces button:hover {
      background: rgba(0, 0, 0, 0.2);
    }

    #workspaces button.focused {
      background-color: #64727D;
      box-shadow: inset 0 -3px #ffffff;
    }

    #workspaces button.urgent {
      background-color: #eb4d4b;
    }

    #mode {
      background-color: #64727D;
      border-bottom: 3px solid #ffffff;
    }

    #clock,
    #battery,
    #cpu,
    #memory,
    #disk,
    #temperature,
    #backlight,
    #network,
    #pulseaudio,
    #custom-media,
    #tray,
    #mode,
    #idle_inhibitor,
    #mpd {
      padding: 0 10px;
      color: #ffffff;
    }

    #window,
    #workspaces {
      margin: 0 4px;
    }

    #clock {
      background-color: #64727D;
    }

    #battery {
      background-color: #ffffff;
      color: #000000;
    }

    #battery.charging, #battery.plugged {
      color: #ffffff;
      background-color: #26A65B;
    }

    #battery.critical:not(.charging) {
      background-color: #f53c3c;
      color: #ffffff;
      animation-name: blink;
      animation-duration: 0.5s;
      animation-timing-function: linear;
      animation-iteration-count: infinite;
      animation-direction: alternate;
    }

    #network {
      background-color: #2980b9;
    }

    #network.disconnected {
      background-color: #f53c3c;
    }

    #pulseaudio {
      background-color: #f1c40f;
      color: #000000;
    }

    #pulseaudio.muted {
      background-color: #90b1b1;
      color: #2a5c45;
    }

    @keyframes blink {
      to {
        background-color: #ffffff;
        color: #000000;
      }
    }
  '';
}
