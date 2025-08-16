{ config, pkgs, ... }:

{
  networking = {
    hostName = "satreNixOS";
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
    wireless.enable = false;
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
