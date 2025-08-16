{ config, pkgs, ... }:

{
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  services.xserver.enable = true;
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  # Sway-related packages
  environment.systemPackages = with pkgs; [
    wofi
    waybar
    swayidle
    swaylock
    wl-clipboard
    mako
    grim
    slurp
    polkit_gnome
  ];

  # Start polkit agent
  security.polkit.enable = true;
}
