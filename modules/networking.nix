{ config, pkgs, ... }:

{
  networking = {
    hostName = "satreNixOS";
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
    wireless.enable = false;
    wireguard.enable = true;
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/wgnord 0700 root root -"
    "f /var/lib/wgnord/credentials.json 0600 root root -"
    "f /var/lib/wgnord/auth_token 0600 root root -"
    "d /etc/wireguard 0700 root root -"
  ];

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    wgnord
    wireguard-tools
  ];


}
