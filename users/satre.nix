{ config, pkgs, ... }:

{
  users.users.satre = {
    isNormalUser = true;
    description = "sam tredgett";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      # User-specific packages can go here
    ];
  };
   programs.zsh.enable = true;
}
