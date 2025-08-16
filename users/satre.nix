{ config, pkgs, ... }:

{
  users.users.satre = {
    isNormalUser = true;
    description = "sam tredgett";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # User-specific packages can go here
    ];
  };
}
