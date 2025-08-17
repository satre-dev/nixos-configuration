{ config, pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland.enable = true;

  # XDG portal (much simpler with Hyprland)
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
  };

  # Required packages
  environment.systemPackages = with pkgs; [
    waybar          # Status bar
    wofi            # App launcher
    kitty           # Terminal
    alacritty       # Terminal 2
    mako            # Notifications
    wl-clipboard    # Clipboard
    grim            # Screenshots
    slurp           # Screen selection
    brightnessctl   # Brightness control
    swww            # Wallpaper daemon
    libnotify       # Notifications
  ];

  # Enable services
  services.xserver.enable = true;
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  # Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
}
