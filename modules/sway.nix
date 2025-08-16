{ config, pkgs, ... }:

{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      swaylock-effects
      swayidle
      wl-clipboard
      mako
      wofi
      waybar
      grim
      slurp
      wf-recorder
    ];
    
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_WPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  };

  # Sway configuration
  environment.etc."sway/config".text = ''
    # Variables
    set $mod Mod4
    set $left h
    set $down j
    set $up k
    set $right l
    set $term kitty
    set $menu wofi --show drun --prompt "Run: "
    
    # Font
    font pango:Noto Sans 14

    # Startup applications
    exec --no-startup-id nm-applet --indicator
    exec --no-startup-id /run/current-system/sw/libexec/polkit-gnome-authentication-agent-1
    exec --no-startup-id mako

    # Input configuration
    input type:keyboard {
        xkb_layout us
        repeat_delay 300
        repeat_rate 30
    }

    input type:touchpad {
        tap enabled
        natural_scroll enabled
        scroll_factor 0.5
    }

    # Output configuration
    output * bg #1e1e1e solid_color

    # Window rules
    for_window [app_id="librewolf"] border pixel 2
    for_window [app_id="kitty"] border pixel 2
    for_window [app_id="wofi"] border pixel 0

    # Key bindings - basic
    bindsym $mod+Shift+Return exec $term
    bindsym $mod+Shift+q kill
    bindsym $mod+d exec $menu
    bindsym $mod+Shift+c reload
    bindsym $mod+Shift+e exec swaynag -t warning -m 'Exit sway?' -B 'Yes' 'swaymsg exit'

    # Movement
    bindsym $mod+$left focus left
    bindsym $mod+$down focus down
    bindsym $mod+$up focus up
    bindsym $mod+$right focus right

    bindsym $mod+Shift+$left move left
    bindsym $mod+Shift+$down move down
    bindsym $mod+Shift+$up move up
    bindsym $mod+Shift+$right move right

    # Workspaces
    bindsym $mod+1 workspace number 1
    bindsym $mod+2 workspace number 2
    bindsym $mod+3 workspace number 3
    bindsym $mod+4 workspace number 4
    bindsym $mod+5 workspace number 5
    bindsym $mod+6 workspace number 6
    bindsym $mod+7 workspace number 7
    bindsym $mod+8 workspace number 8
    bindsym $mod+9 workspace number 9
    bindsym $mod+0 workspace number 10

    bindsym $mod+Shift+1 move container to workspace number 1
    bindsym $mod+Shift+2 move container to workspace number 2
    bindsym $mod+Shift+3 move container to workspace number 3
    bindsym $mod+Shift+4 move container to workspace number 4
    bindsym $mod+Shift+5 move container to workspace number 5
    bindsym $mod+Shift+6 move container to workspace number 6
    bindsym $mod+Shift+7 move container to workspace number 7
    bindsym $mod+Shift+8 move container to workspace number 8
    bindsym $mod+Shift+9 move container to workspace number 9
    bindsym $mod+Shift+0 move container to workspace number 10

    # Layout
    bindsym $mod+h splith
    bindsym $mod+v splitv
    bindsym $mod+s layout stacking
    bindsym $mod+w layout tabbed
    bindsym $mod+e layout toggle split
    bindsym $mod+f fullscreen
    bindsym $mod+Shift+space floating toggle
    bindsym $mod+space focus mode_toggle
    
    # Audio and brightness
    bindsym XF86AudioRaiseVolume exec pactl set-sink-volume @DEFAULT_SINK@ +5%
    bindsym XF86AudioLowerVolume exec pactl set-sink-volume @DEFAULT_SINK@ -5%
    bindsym XF86AudioMute exec pactl set-sink-mute @DEFAULT_SINK@ toggle
    bindsym XF86MonBrightnessDown exec brightnessctl set 5%-
    bindsym XF86MonBrightnessUp exec brightnessctl set 5%+

    # Screenshots
    bindsym $mod+Print exec grim ~/Pictures/screenshots/$(date +%Y%m%d-%H%M%S).png
    bindsym $mod+Shift+Print exec grim -g "$(slurp)" ~/Pictures/screenshots/$(date +%Y%m%d-%H%M%S).png

    # Lock Screen
    bindsym $mod+Shift+Delete exec swaylock-effects

    # Resizing
    mode "resize" {
        bindsym $left resize shrink width 10px
        bindsym $down resize grow height 10px
        bindsym $up resize shrink height 10px
        bindsym $right resize grow width 10px

        bindsym Return mode "default"
        bindsym Escape mode "default"
    }
    bindsym $mod+r mode "resize"
    
    # Status Bar
    bar {
        position top
        status_command waybar
        tray {
            icon_theme adwaita
        }
    }
    
    # Colors (Gruvbox inspired)
    client.focused 		#689d6a #689d6a #282828 #689d6a  #689d6a
    client.focused_inactive 	#1d2021 #1d2021 #928374 #292d2e  #222222
    client.unfocused 		#32302f #32302f #928374 #292d2e  #222222
    client.urgent 		#cc241d #cc241d #ebdbb2 #cc241d  #cc241d
    client.placeholder 		#000000 #0c0c0c #ffffff #000000  #0c0c0c
    client.background 		#ffffff
  ''; 

  services.xserver.enable = true;
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  environment.systemPackages = with pkgs; [
    polkit_gnome
    brightnessctl
  ];

  # Start polkit agent
  security.polkit.enable = true;
}
